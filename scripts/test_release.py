"""Offline tests for release verification. Run: python -m unittest discover -s scripts"""

import contextlib
import hashlib
import io
import json
import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock
from urllib.error import HTTPError

import release

TAG = "graphmodules-067c9d13832914ce38d2"
SHA = "539975df7dbe162de40f2afff3f5c94f59e5db9e"
NEWER_TAG = "graphmodules-4002ec490efccb9d7832"
OLDER_SHA = "f7648218ee56488fe7a18f646a48404bd153464f"
REPOSITORY = "owner/name"
FORBIDDEN = "gh: Resource not accessible by integration (HTTP 403)\n"
CHANGES = b'{\n  "schema_version": 1\n}\n'
CATALOGS = {
    "v1.0": "modules/generated/v1.0",
    "beta": "modules/generated/beta",
    "curated": "modules/curated",
}
ASSETS = [
    "graphmodules-v1.0-modules.tar.gz",
    "graphmodules-beta-modules.tar.gz",
    "graphmodules-curated-modules.tar.gz",
    "release-manifest.json",
]


def digest(content: bytes) -> str:
    return hashlib.sha256(content).hexdigest()


class FakeGitHub:
    """Serves the REST reads, git and gh commands used by release(), reduced to the fields used."""

    def __init__(self):
        self.latest = TAG  # tag_name of GET releases/latest
        self.tag_commit = SHA  # git ls-remote origin refs/tags/<TAG>
        self.branch = None  # refs/heads/latest; None means GET git/ref/heads/latest is 404
        self.release = None  # GET releases/tags/<TAG>; None means 404
        self.gh_api_error = None  # stderr of a failing gh api call
        self.reads = []
        self.commands = []

    def request_json(self, repository, suffix):
        self.reads.append(suffix)
        if suffix == "releases/latest":
            return {"tag_name": self.latest, "draft": False}
        if suffix == "git/ref/heads/latest" and self.branch:
            return {"ref": "refs/heads/latest", "object": {"sha": self.branch, "type": "commit"}}
        if suffix == f"releases/tags/{TAG}" and self.release:
            return self.release
        if suffix.startswith("releases?"):
            return [self.release] if self.release else []
        url = f"https://api.github.com/repos/{repository}/{suffix}"
        raise HTTPError(url, 404, "Not Found", None, None)

    def run(self, command, **kwargs):
        self.commands.append(command)
        if command[:2] == ["git", "ls-remote"]:
            return subprocess.CompletedProcess(command, 0, f"{self.tag_commit}\trefs/tags/{TAG}\n")
        if command[:2] == ["git", "log"]:
            return subprocess.CompletedProcess(command, 0, f"{SHA}\n")
        if command[:2] == ["gh", "release"]:
            return subprocess.CompletedProcess(command, 0)
        if command[:2] == ["gh", "api"] and self.gh_api_error:
            return subprocess.CompletedProcess(command, 1, '{"status":"422"}', self.gh_api_error)
        if command[:2] == ["gh", "api"]:
            moved = {"ref": "refs/heads/latest", "object": {"sha": SHA, "type": "commit"}}
            return subprocess.CompletedProcess(command, 0, json.dumps(moved), "")
        raise AssertionError(f"Unexpected command: {command}")

    @contextlib.contextmanager
    def serve(self):
        with (
            mock.patch.object(release, "request_json", side_effect=self.request_json),
            mock.patch.object(release.subprocess, "run", side_effect=self.run),
            contextlib.redirect_stdout(io.StringIO()) as output,
        ):
            yield output

    def ref_writes(self):
        return [c for c in self.commands if c[:2] == ["gh", "api"]]


class RequestJsonTest(unittest.TestCase):
    def sent(self, environment: dict[str, str]):
        with (
            mock.patch.dict(os.environ, environment, clear=True),
            mock.patch.object(release, "urlopen", return_value=io.BytesIO(b"{}")) as urlopen,
        ):
            release.request_json("owner/name", f"releases/tags/{TAG}")
        return urlopen.call_args.args[0]

    def test_reads_public_releases_without_a_token(self):
        self.assertFalse(self.sent({}).has_header("Authorization"))

    def test_sends_the_token_when_present(self):
        request = self.sent({"GH_TOKEN": "token"})
        self.assertEqual(request.get_header("Authorization"), "Bearer token")


class VerifyAssetsTest(unittest.TestCase):
    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.assets = []
        for name in ("graphmodules-v1.0-modules.tar.gz", "SHA256SUMS"):
            path = Path(directory.name) / name
            path.write_bytes(name.encode())
            self.assets.append(path)
        # Shape of GET /repos/{owner}/{repo}/releases/tags/{tag}, reduced to the fields used.
        self.published = {
            "tag_name": TAG,
            "draft": False,
            "target_commitish": SHA,
            "assets": [
                {"name": p.name, "digest": f"sha256:{hashlib.sha256(p.read_bytes()).hexdigest()}"}
                for p in self.assets
            ],
        }

    def verify(self):
        with mock.patch.object(release, "request_json", return_value=self.published) as request:
            release.verify_assets("owner/name", TAG, SHA, self.assets)
        request.assert_called_once_with("owner/name", f"releases/tags/{TAG}")

    def test_accepts_matching_release(self):
        self.verify()

    def test_rejects_a_different_target_commit(self):
        self.published["target_commitish"] = "main"
        with self.assertRaisesRegex(ValueError, "does not target"):
            self.verify()

    def test_rejects_a_changed_digest(self):
        self.published["assets"][0]["digest"] = f"sha256:{'0' * 64}"
        with self.assertRaisesRegex(ValueError, "differ from the rebuild: graphmodules-v1.0"):
            self.verify()

    def test_rejects_missing_and_unexpected_assets(self):
        self.published["assets"][1]["name"] = "extra.tar.gz"
        with self.assertRaisesRegex(ValueError, "rebuild: SHA256SUMS, extra.tar.gz$"):
            self.verify()

    def test_rejects_an_asset_without_a_digest(self):
        del self.published["assets"][1]["digest"]
        with self.assertRaisesRegex(ValueError, "rebuild: SHA256SUMS$"):
            self.verify()


class BuildTest(unittest.TestCase):
    """Runs build() on a minimal publication; git worktree add copies that tree."""

    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.source = Path(directory.name) / "source"
        self.output = Path(directory.name) / "output"
        self.output.mkdir()
        inputs = {"generator": {"commit": OLDER_SHA}}
        fingerprint = digest(json.dumps(inputs, sort_keys=True, separators=(",", ":")).encode())
        self.tag = f"graphmodules-{fingerprint[:20]}"
        self.provenance = json.dumps(
            {**inputs, "tag": self.tag, "fingerprint": fingerprint}
        ).encode()
        notices = {"LICENSE": b"license\n", "NOTICE": b"notice\n"}
        files = {
            **notices,
            "modules/generated/release-manifest.json": self.provenance,
            ".release/release-notes.md": b"Notes.\n",
        }
        # SHA256SUMS as the publisher writes it for the archives of this tree.
        self.sums = {"release-manifest.json": digest(self.provenance)}
        for api, prefix in CATALOGS.items():
            module = {f"{prefix}/example/main.tf": b"# module\n"}
            files.update(module)
            archive = Path(directory.name) / f"graphmodules-{api}-modules.tar.gz"
            release.archive(
                archive, {**module, **notices, "release-manifest.json": self.provenance}
            )
            self.sums[archive.name] = digest(archive.read_bytes())
        for name, content in files.items():
            (self.source / name).parent.mkdir(parents=True, exist_ok=True)
            (self.source / name).write_bytes(content)

    def git(self, *args: str) -> str:
        if args[0] == "rev-parse":
            return SHA
        if args[0] == "merge-base":
            return ""
        if args[:2] == ("worktree", "add"):
            shutil.copytree(self.source, args[3], symlinks=True)
            return ""
        if args[:2] == ("worktree", "remove"):
            shutil.rmtree(args[2])
            return ""
        raise AssertionError(f"Unexpected git command: {args}")

    def commit(self, changes: bytes | None, listed: bytes | None) -> bytes:
        """Commit interface-changes.json with `changes`, and a SHA256SUMS that lists `listed`."""
        sums = dict(self.sums)
        if listed is not None:
            sums["interface-changes.json"] = digest(listed)
        checksums = "".join(f"{h}  {n}\n" for n, h in sorted(sums.items())).encode()
        (self.source / ".release/SHA256SUMS").write_bytes(checksums)
        if changes is not None:
            (self.source / ".release/interface-changes.json").write_bytes(changes)
        return checksums

    def build(self) -> tuple[str, list[Path]]:
        with mock.patch.object(release, "git", side_effect=self.git):
            return release.build(self.tag, self.output)

    def test_publication_without_interface_changes_is_unchanged(self):
        checksums = self.commit(changes=None, listed=None)
        sha, assets = self.build()
        self.assertEqual(sha, SHA)
        self.assertEqual([p.name for p in assets], [*ASSETS, "SHA256SUMS"])
        self.assertEqual((self.output / "SHA256SUMS").read_bytes(), checksums)
        self.assertFalse((self.output / "interface-changes.json").exists())

    def test_publishes_committed_interface_changes(self):
        checksums = self.commit(changes=CHANGES, listed=CHANGES)
        _, assets = self.build()
        self.assertEqual(
            [p.name for p in assets], [*ASSETS, "interface-changes.json", "SHA256SUMS"]
        )
        self.assertEqual((self.output / "interface-changes.json").read_bytes(), CHANGES)
        self.assertEqual((self.output / "SHA256SUMS").read_bytes(), checksums)
        self.assertIn(f"{digest(CHANGES)}  interface-changes.json\n", checksums.decode())

    def test_rejects_changed_interface_changes(self):
        self.commit(changes=CHANGES.replace(b"1", b"2"), listed=CHANGES)
        with self.assertRaisesRegex(ValueError, "do not reproduce the tested SHA256SUMS"):
            self.build()

    def test_rejects_interface_changes_missing_from_sha256sums(self):
        self.commit(changes=CHANGES, listed=None)
        with self.assertRaisesRegex(ValueError, "do not reproduce the tested SHA256SUMS"):
            self.build()

    def test_rejects_listed_interface_changes_missing_from_the_publication(self):
        self.commit(changes=None, listed=CHANGES)
        with self.assertRaisesRegex(ValueError, "do not reproduce the tested SHA256SUMS"):
            self.build()

    def test_rejects_symlinked_interface_changes(self):
        # SHA256SUMS lists the link target's bytes, so only the symlink check refuses it.
        self.commit(changes=None, listed=self.provenance)
        link = self.source / ".release/interface-changes.json"
        link.symlink_to("../modules/generated/release-manifest.json")
        with self.assertRaisesRegex(ValueError, "Publication contains a symlink"):
            self.build()

    def test_rejects_interface_changes_that_is_not_a_regular_file(self):
        self.commit(changes=None, listed=None)
        (self.source / ".release/interface-changes.json").mkdir()
        (self.source / ".release/interface-changes.json/nested").write_text("{}\n")
        with self.assertRaisesRegex(ValueError, "is not a regular file"):
            self.build()

    def test_verify_assets_requires_the_published_interface_changes(self):
        self.commit(changes=CHANGES, listed=CHANGES)
        sha, assets = self.build()
        published = {
            "target_commitish": sha,
            "assets": [
                {"name": p.name, "digest": f"sha256:{digest(p.read_bytes())}"} for p in assets
            ],
        }
        with mock.patch.object(release, "request_json", return_value=published):
            release.verify_assets(REPOSITORY, self.tag, sha, assets)
            published["assets"] = [
                a for a in published["assets"] if a["name"] != "interface-changes.json"
            ]
            with self.assertRaisesRegex(ValueError, "rebuild: interface-changes.json$"):
                release.verify_assets(REPOSITORY, self.tag, sha, assets)

    def test_draft_release_uploads_interface_changes(self):
        self.commit(changes=CHANGES, listed=CHANGES)
        sha, assets = self.build()
        github = FakeGitHub()
        # GET releases/tags/<tag> is 404 here; release() finds the draft in the release list.
        github.release = {"tag_name": self.tag, "draft": True, "target_commitish": sha}
        with github.serve():
            release.release(REPOSITORY, self.tag, sha, assets, self.output)
        uploads = [c for c in github.commands if c[:3] == ["gh", "release", "upload"]]
        self.assertEqual(len(uploads), 1)
        self.assertIn(str(self.output / "interface-changes.json"), uploads[0])
        self.assertIn("--clobber", uploads[0])


class MainTest(unittest.TestCase):
    def run_main(self, *flags: str) -> tuple[bool, bool]:
        argv = ["release.py", "--tag", TAG, "--repository", "owner/name", *flags]
        with (
            mock.patch.object(sys, "argv", argv),
            mock.patch.object(release, "build", return_value=(SHA, [])),
            mock.patch.object(release, "release") as publish,
            mock.patch.object(release, "verify_assets") as verify,
            contextlib.redirect_stdout(io.StringIO()),
        ):
            release.main()
        return publish.called, verify.called

    def test_releases_by_default(self):
        self.assertEqual(self.run_main(), (True, False))

    def test_verify_only_does_not_contact_the_api(self):
        self.assertEqual(self.run_main("--verify-only"), (False, False))

    def test_verify_assets_never_publishes(self):
        self.assertEqual(self.run_main("--verify-assets"), (False, True))
        self.assertEqual(self.run_main("--verify-only", "--verify-assets"), (False, True))

    def test_verification_modes_never_write(self):
        github = FakeGitHub()
        github.release = {"draft": False, "target_commitish": SHA, "assets": []}
        for flags in (["--verify-only"], ["--verify-assets"], ["--verify-only", "--verify-assets"]):
            argv = ["release.py", "--tag", TAG, "--repository", REPOSITORY, *flags]
            with (
                self.subTest(flags=flags),
                mock.patch.object(sys, "argv", argv),
                mock.patch.object(release, "build", return_value=(SHA, [])),
                github.serve(),
            ):
                release.main()
        self.assertEqual(github.commands, [])
        self.assertEqual(set(github.reads), {f"releases/tags/{TAG}"})


class UpdateLatestBranchTest(unittest.TestCase):
    def setUp(self):
        self.github = FakeGitHub()

    def update(self) -> str:
        with self.github.serve() as output:
            release.update_latest_branch(REPOSITORY, TAG, SHA)
        return output.getvalue()

    def test_creates_the_branch_when_missing(self):
        self.update()
        self.assertEqual(
            self.github.ref_writes(),
            [
                [
                    "gh",
                    "api",
                    "--method",
                    "POST",
                    f"repos/{REPOSITORY}/git/refs",
                    "-f",
                    "ref=refs/heads/latest",
                    "-f",
                    f"sha={SHA}",
                ]
            ],
        )

    def test_does_nothing_when_already_at_the_release(self):
        self.github.branch = SHA
        self.assertIn("already", self.update())
        self.assertEqual(self.github.ref_writes(), [])

    def test_fast_forwards_without_force(self):
        self.github.branch = OLDER_SHA
        self.update()
        self.assertEqual(
            self.github.ref_writes(),
            [
                [
                    "gh",
                    "api",
                    "--method",
                    "PATCH",
                    f"repos/{REPOSITORY}/git/refs/heads/latest",
                    "-F",
                    "force=false",
                    "-f",
                    f"sha={SHA}",
                ]
            ],
        )

    def test_recovery_run_for_an_older_tag_leaves_the_branch_alone(self):
        self.github.latest = NEWER_TAG
        self.github.branch = OLDER_SHA
        self.assertIn(f"{TAG} is not the GitHub Latest release ({NEWER_TAG})", self.update())
        self.assertEqual(self.github.ref_writes(), [])
        self.assertNotIn("git/ref/heads/latest", self.github.reads)

    def test_moved_remote_tag_leaves_the_branch_alone(self):
        self.github.tag_commit = OLDER_SHA
        self.assertIn("does not identify", self.update())
        self.assertEqual(self.github.ref_writes(), [])

    def test_non_fast_forward_is_an_error_and_never_forced(self):
        self.github.branch = OLDER_SHA
        self.github.gh_api_error = "gh: Update is not a fast forward (HTTP 422)\n"
        with self.assertRaisesRegex(ValueError, "never force-updated.*not a fast forward"):
            self.update()
        self.assertEqual(len(self.github.ref_writes()), 1)
        self.assertNotIn("force=true", self.github.ref_writes()[0])

    def test_refused_ref_write_is_an_error(self):
        self.github.gh_api_error = FORBIDDEN
        with self.assertRaisesRegex(ValueError, f"Could not point branch latest at {SHA}.*403"):
            self.update()


class ReleaseUpdatesLatestBranchTest(unittest.TestCase):
    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.directory = Path(directory.name)
        self.github = FakeGitHub()

    def publish(self, summary: str = "") -> str:
        with (
            mock.patch.dict(os.environ, {"GITHUB_STEP_SUMMARY": summary}),
            self.github.serve() as output,
        ):
            release.release(REPOSITORY, TAG, SHA, [], self.directory)
        return output.getvalue()

    def assert_warned(self, output: str):
        warnings = [line for line in output.splitlines() if line.startswith("::warning::")]
        self.assertEqual(len(warnings), 1)
        self.assertIn("Resource not accessible by integration (HTTP 403)", warnings[0])
        self.assertIn(f"`git push origin {SHA}:refs/heads/latest`", warnings[0])
        self.assertEqual(len(self.github.ref_writes()), 1)
        self.assertNotIn("force=true", self.github.ref_writes()[0])

    def test_publishing_moves_the_branch_after_the_final_edit(self):
        self.github.release = {"draft": True, "target_commitish": SHA, "html_url": "draft"}
        self.publish()
        commands = [" ".join(c[:3]) for c in self.github.commands]
        writes = [i for i, c in enumerate(commands) if c.startswith("gh api")]
        self.assertEqual(len(writes), 1)
        self.assertGreater(writes[0], commands.index("gh release edit"))

    def test_already_published_release_also_moves_the_branch(self):
        self.github.release = {"draft": False, "target_commitish": SHA, "html_url": "published"}
        self.publish()
        self.assertEqual(len(self.github.ref_writes()), 1)
        self.assertNotIn(["gh", "release"], [c[:2] for c in self.github.commands])

    def test_already_published_older_release_leaves_the_branch_alone(self):
        self.github.release = {"draft": False, "target_commitish": SHA, "html_url": "published"}
        self.github.latest = NEWER_TAG
        self.publish()
        self.assertEqual(self.github.ref_writes(), [])

    def test_refused_branch_update_after_publishing_only_warns(self):
        self.github.release = {"draft": True, "target_commitish": SHA, "html_url": "draft"}
        self.github.gh_api_error = FORBIDDEN
        self.assert_warned(self.publish())
        self.assertIn(["gh", "release", "edit"], [c[:3] for c in self.github.commands])

    def test_refused_branch_update_for_a_published_release_only_warns(self):
        self.github.release = {"draft": False, "target_commitish": SHA, "html_url": "published"}
        self.github.gh_api_error = FORBIDDEN
        self.assert_warned(self.publish())

    def test_refused_branch_update_is_added_to_the_step_summary(self):
        self.github.release = {"draft": False, "target_commitish": SHA, "html_url": "published"}
        self.github.gh_api_error = FORBIDDEN
        summary = self.directory / "summary.md"
        output = self.publish(str(summary))
        text = summary.read_text(encoding="utf-8")
        self.assertIn(f"`git push origin {SHA}:refs/heads/latest`", text)
        self.assertIn("(HTTP 403)", text)
        self.assertIn(f"::warning::{text.strip()}", output)


if __name__ == "__main__":
    unittest.main()
