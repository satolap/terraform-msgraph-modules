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
    request = Request(
        f"https://api.github.com/repos/{repository}/{suffix}",
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "GraphModules-release",
            "Authorization": f"Bearer {os.environ['GH_TOKEN']}",
        },
    )
    with urlopen(request, timeout=60) as response:
        return json.load(response)


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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tag", required=True)
    parser.add_argument("--repository", required=True)
    parser.add_argument("--verify-only", action="store_true")
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix="graphmodules-") as temporary:
        directory = Path(temporary)
        sha, assets = build(args.tag, directory)
        if not args.verify_only:
            release(args.repository, args.tag, sha, assets, directory)
        print(f"Verified {args.tag} at {sha}")


if __name__ == "__main__":
    main()
