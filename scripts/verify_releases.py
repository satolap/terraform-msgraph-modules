"""Rebuild every published release and compare its target, asset digests and attestations.

Run by .github/workflows/verify-releases.yml from the repository root, with GH_TOKEN, GH_REPO
and GITHUB_STEP_SUMMARY set.
"""

from __future__ import annotations

import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

TAG_PATTERN = re.compile(r"v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)")
# Exemptions name each release explicitly, never by version range: the release line restarted
# at v0.5.0, so a rule such as "above v4.0.0" silently exempts every 0.x release.
# Published releases without a verified module catalog, which release.py cannot rebuild.
WITHOUT_VERIFIED_CATALOG: frozenset[str] = frozenset()
# Published releases whose assets were released before the release workflow attested them.
# Every other release, 0.x included, needs a valid attestation for every asset.
PUBLISHED_BEFORE_ATTESTATIONS: frozenset[str] = frozenset()


def rebuildable(tag: str) -> bool:
    return tag not in WITHOUT_VERIFIED_CATALOG


def attestation_required(tag: str) -> bool:
    return tag not in PUBLISHED_BEFORE_ATTESTATIONS


def attested(path: Path, repository: str) -> bool:
    return subprocess.run([
        "gh", "attestation", "verify", str(path), "--repo", repository,
        "--signer-workflow", f"{repository}/.github/workflows/release.yml",
        "--source-ref", "refs/heads/main",
    ]).returncode == 0


def main() -> None:
    repository = os.environ["GH_REPO"]
    released = subprocess.check_output([
        "gh", "api", "--paginate", f"repos/{repository}/releases",
        "--jq", ".[] | select(.draft | not) | .tag_name",
    ], text=True).split()
    tags = subprocess.check_output(["git", "tag", "--list", "v*"], text=True).split()
    summary = ["## Release verification", ""]
    failed = []
    for tag in sorted(filter(TAG_PATTERN.fullmatch, released)):
        if not rebuildable(tag):
            print(f"::notice::Skipped {tag}: no verified module catalog")
            summary.append(f"- Skipped (no verified module catalog): `{tag}`")
            continue
        with tempfile.TemporaryDirectory() as temporary:
            assets = Path(temporary) / "assets"
            result = subprocess.run([
                sys.executable, "scripts/release.py", "--tag", tag,
                "--repository", repository, "--verify-only", "--verify-assets",
                "--output-dir", str(assets),
            ])
            # The rebuilt assets have the published digests, so they stand in for them.
            unattested = [] if result.returncode else [
                p.name for p in sorted(assets.iterdir()) if not attested(p, repository)
            ]
        if result.returncode:
            failed.append(tag)
            summary.append(f"- Failed: `{tag}`")
        elif unattested and attestation_required(tag):
            print(f"::error::{tag} assets lack a valid attestation: {', '.join(unattested)}")
            failed.append(tag)
            summary.append(f"- Failed (no valid attestation): `{tag}`: {', '.join(unattested)}")
        elif unattested:
            print(f"::notice::{tag} predates release attestations")
            summary.append(f"- Verified (published before attestations): `{tag}`")
        else:
            summary.append(f"- Verified and attested: `{tag}`")
    for tag in sorted(set(filter(TAG_PATTERN.fullmatch, tags)) - set(released)):
        print(f"::warning::Tag {tag} has no published release")
        summary.append(f"- Warning: tag `{tag}` has no published release")
    with open(os.environ["GITHUB_STEP_SUMMARY"], "a", encoding="utf-8") as output:
        output.write("\n".join(summary) + "\n")
    if failed:
        sys.exit(f"Release verification failed: {', '.join(failed)}")


if __name__ == "__main__":
    main()
