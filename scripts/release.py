"""Reconstruct and verify release assets from a GraphModules publication."""

from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import json
import os
import re
import subprocess
import tarfile
import tempfile
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request, urlopen


def git(*args: str) -> str:
    return subprocess.run(
        ["git", *args], check=True, capture_output=True, text=True, encoding="utf-8"
    ).stdout.strip()


def archive(path: Path, files: dict[str, bytes]) -> None:
    with path.open("wb") as destination:
        with gzip.GzipFile(fileobj=destination, mode="wb", filename="", mtime=0) as compressed:
            with tarfile.open(fileobj=compressed, mode="w", format=tarfile.PAX_FORMAT) as output:
                for name, content in sorted(files.items()):
                    item = tarfile.TarInfo(name)
                    item.size, item.mtime, item.uid, item.gid = len(content), 0, 0, 0
                    item.uname = item.gname = ""
                    item.mode = 0o644
                    output.addfile(item, io.BytesIO(content))


def build(tag: str, directory: Path) -> tuple[str, list[Path]]:
    if not re.fullmatch(r"graphmodules-[0-9a-f]{20}", tag):
        raise ValueError("Invalid GraphModules release tag")
    sha = git("rev-parse", f"refs/tags/{tag}^{{commit}}")
    git("merge-base", "--is-ancestor", sha, "origin/main")
    # A separate worktree avoids running scripts from the publication tag.
    checkout = directory / "publication"
    git("worktree", "add", "--detach", str(checkout), sha)
    try:
        provenance = (checkout / "modules/generated/release-manifest.json").read_bytes()
        manifest = json.loads(provenance)
        inputs = {k: v for k, v in manifest.items() if k not in {"tag", "fingerprint"}}
        canonical = json.dumps(
            inputs, sort_keys=True, separators=(",", ":"), ensure_ascii=False
        ).encode("utf-8")
        fingerprint = hashlib.sha256(canonical).hexdigest()
        if (
            manifest["tag"] != tag
            or manifest["fingerprint"] != fingerprint
            or tag != f"graphmodules-{fingerprint[:20]}"
        ):
            raise ValueError("Manifest fingerprint does not match the release tag")
        notices = {
            n: (checkout / n).read_bytes()
            for n in ("LICENSE", "NOTICE")
            if (checkout / n).is_file()
        }
        assets = []
        for api in ("v1.0", "beta", "curated"):
            root = checkout / (
                "modules/curated" if api == "curated" else f"modules/generated/{api}"
            )
            prefix = "modules/curated" if api == "curated" else f"modules/generated/{api}"
            files = {}
            for path in root.rglob("*"):
                if path.is_symlink():
                    raise ValueError("Publication contains a symlink")
                if path.is_file():
                    files[f"{prefix}/{path.relative_to(root).as_posix()}"] = path.read_bytes()
            if not any(n.endswith("/main.tf") for n in files):
                raise ValueError(f"Missing {api} module catalog")
            files.update(notices)
            files["release-manifest.json"] = provenance
            destination = directory / f"graphmodules-{api}-modules.tar.gz"
            archive(destination, files)
            assets.append(destination)
        manifest_file = directory / "release-manifest.json"
        manifest_file.write_bytes(provenance)
        assets.append(manifest_file)
        # Optional: releases published before this asset existed do not have it.
        changes = checkout / ".release/interface-changes.json"
        if changes.is_symlink():
            raise ValueError("Publication contains a symlink")
        if changes.is_file():
            changes_file = directory / changes.name
            changes_file.write_bytes(changes.read_bytes())
            assets.append(changes_file)
        elif changes.exists():
            raise ValueError("Publication .release/interface-changes.json is not a regular file")
        expected = (checkout / ".release/SHA256SUMS").read_bytes()
        actual = "".join(
            f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.name}\n" for p in sorted(assets)
        ).encode("utf-8")
        if expected.splitlines() != actual.splitlines():
            raise ValueError("Committed modules do not reproduce the tested SHA256SUMS")
        checksums = directory / "SHA256SUMS"
        checksums.write_bytes(expected)
        notes = (checkout / ".release/release-notes.md").read_text(encoding="utf-8")
        (directory / "release-notes.md").write_text(
            notes + f"\nGraphModules publication: `{sha}`.\n", encoding="utf-8"
        )
        return sha, [*assets, checksums]
    finally:
        git("worktree", "remove", str(checkout))


def request_json(repository: str, suffix: str):
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "GraphModules-release",
    }
    # Published releases of this public repository can be verified without a token.
    if os.environ.get("GH_TOKEN"):
        headers["Authorization"] = f"Bearer {os.environ['GH_TOKEN']}"
    request = Request(f"https://api.github.com/repos/{repository}/{suffix}", headers=headers)
    with urlopen(request, timeout=60) as response:
        return json.load(response)


def verify_assets(repository: str, tag: str, sha: str, assets: list[Path]) -> None:
    published = request_json(repository, f"releases/tags/{tag}")
    if published["target_commitish"] != sha:
        raise ValueError("Published release does not target the validated publication")
    expected = {p.name: f"sha256:{hashlib.sha256(p.read_bytes()).hexdigest()}" for p in assets}
    actual = {a["name"]: a.get("digest") for a in published["assets"]}
    changed = sorted(n for n in expected.keys() | actual.keys() if expected.get(n) != actual.get(n))
    if changed:
        raise ValueError(f"Published release assets differ from the rebuild: {', '.join(changed)}")


def update_latest_branch(repository: str, tag: str, sha: str) -> None:
    """Fast-forward the latest branch to a publication that is the GitHub Latest release."""
    try:
        latest = request_json(repository, "releases/latest")["tag_name"]
    except HTTPError as error:
        if error.code != 404:
            raise
        latest = None
    # A recovery run for an older tag must not move the branch backwards.
    if latest != tag:
        print(f"Leaving branch latest unchanged: {tag} is not the GitHub Latest release ({latest})")
        return
    remote = git("ls-remote", "origin", f"refs/tags/{tag}").split()
    if not remote or remote[0] != sha:
        print(f"Leaving branch latest unchanged: remote tag {tag} does not identify {sha}")
        return
    try:
        current = request_json(repository, "git/ref/heads/latest")["object"]["sha"]
    except HTTPError as error:
        if error.code != 404:
            raise
        current = None
    if current == sha:
        print(f"Branch latest already points at {sha}")
        return
    if current is None:
        target = ["--method", "POST", f"repos/{repository}/git/refs", "-f", "ref=refs/heads/latest"]
    else:
        # With force=false GitHub rejects any update that is not a fast-forward.
        path = f"repos/{repository}/git/refs/heads/latest"
        target = ["--method", "PATCH", path, "-F", "force=false"]
    result = subprocess.run(
        ["gh", "api", *target, "-f", f"sha={sha}"],
        check=False,
        capture_output=True,
        text=True,
        encoding="utf-8",
    )
    error = result.stderr.strip()
    if result.returncode and current and "(HTTP 422)" in error:
        raise ValueError(
            f"GitHub rejected moving branch latest from {current} to {sha}; "
            f"it is never force-updated: {error}"
        )
    if result.returncode:
        raise ValueError(f"Could not point branch latest at {sha}: {error}")
    if json.loads(result.stdout)["object"]["sha"] != sha:
        raise ValueError("GitHub did not move branch latest to the validated publication")
    moved = "created at" if current is None else f"moved from {current} to"
    print(f"Branch latest {moved} {sha}")


def update_latest_branch_or_warn(repository: str, tag: str, sha: str) -> None:
    """Warn instead of failing the job: the release is already published at this point."""
    try:
        update_latest_branch(repository, tag, sha)
    except Exception as error:
        # Likely cause: the range changes workflow files, and GITHUB_TOKEN cannot hold the
        # workflow permission GitHub then requires. The daily verification reports the drift.
        message = (
            f"Release {tag} is published, but branch latest was not moved: {error}. "
            "An account with workflow permission can fast-forward it with "
            f"`git push origin {sha}:refs/heads/latest`, "
            "or re-run this workflow after the branch has been created."
        )
        annotation = message.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")
        print(f"::warning::{annotation}")
        if os.environ.get("GITHUB_STEP_SUMMARY"):
            with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as output:
                output.write(f"{message}\n")


def release(repository: str, tag: str, sha: str, assets: list[Path], directory: Path) -> None:
    def gh(*args: str):
        subprocess.run(["gh", "release", *args, "--repo", repository], check=True)

    try:
        existing = request_json(repository, f"releases/tags/{tag}")
    except HTTPError as error:
        if error.code != 404:
            raise
        existing = None
    if not existing:
        page = 1
        while True:
            releases = request_json(repository, f"releases?per_page=100&page={page}")
            existing = next((r for r in releases if r["tag_name"] == tag), None)
            if existing or len(releases) < 100:
                break
            page += 1
    refs = git("ls-remote", "origin", f"refs/tags/{tag}")
    if refs.split()[0] != sha:
        raise ValueError("Remote release tag no longer identifies the validated publication")
    if existing and not existing["draft"]:
        print(f"Release already published: {existing['html_url']}")
        update_latest_branch_or_warn(repository, tag, sha)
        return
    if existing and existing["target_commitish"] != sha:
        raise ValueError("Existing draft targets a different publication")
    notes = str(directory / "release-notes.md")
    if not existing:
        gh(
            "create",
            tag,
            "--draft",
            "--verify-tag",
            "--target",
            sha,
            "--title",
            f"GraphModules {tag}",
            "--notes-file",
            notes,
        )
    gh("upload", tag, *map(str, assets), "--clobber")
    if git("ls-remote", "origin", f"refs/tags/{tag}").split()[0] != sha:
        raise ValueError("Remote release tag changed during asset upload")
    # Do not make an older recovery run the newest release.
    latest = git(
        "log",
        "-1",
        "--format=%H",
        "origin/main",
        "--",
        "modules",
        ".release",
    )
    gh(
        "edit",
        tag,
        "--draft=false",
        "--latest" if latest == sha else "--latest=false",
        "--notes-file",
        notes,
    )
    update_latest_branch_or_warn(repository, tag, sha)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tag", required=True)
    parser.add_argument("--repository", required=True)
    parser.add_argument("--verify-only", action="store_true")
    parser.add_argument("--verify-assets", action="store_true")
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix="graphmodules-") as temporary:
        directory = Path(temporary)
        sha, assets = build(args.tag, directory)
        if args.verify_assets:
            verify_assets(args.repository, args.tag, sha, assets)
        elif not args.verify_only:
            release(args.repository, args.tag, sha, assets, directory)
        print(f"Verified {args.tag} at {sha}")


if __name__ == "__main__":
    main()
