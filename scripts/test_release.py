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


REGISTRY_REPOSITORY = "satolap/terraform-msgraph-modules"


def interface_changes(tag: str, counts=None, decisions=None, compared=True) -> str:
    return json.dumps({
        "schema_version": 1,
        "tag": tag,
        "comparison_supplied": compared,
        "counts": counts or {},
        "decisions": decisions or [],
        "notices": [],
    })


class RegistryAddressTest(unittest.TestCase):
    def test_registry_named_repository(self):
        self.assertEqual(release.registry_address(REGISTRY_REPOSITORY), "satolap/modules/msgraph")

    def test_other_repositories_have_no_address(self):
        for repository in ("benhaspalace/GraphModules", REPOSITORY, "o/terraform-msgraph"):
            with self.subTest(repository=repository):
                self.assertIsNone(release.registry_address(repository))


class VersionBumpTest(unittest.TestCase):
    def bump(self, **kwargs) -> int:
        return release.version_bump(json.loads(interface_changes(TAG, **kwargs)))

    def test_no_findings_is_a_patch(self):
        self.assertEqual(self.bump(), 2)

    def test_findings_without_decisions_are_a_minor(self):
        self.assertEqual(self.bump(counts={"module_added": 3}), 1)

    def test_accepted_decisions_are_a_major(self):
        self.assertEqual(self.bump(counts={"module_removed": 1}, decisions=[{"decision": "d"}]), 0)

    def test_unknown_compatibility_is_a_major(self):
        self.assertEqual(self.bump(compared=False), 0)


@unittest.skipIf(shutil.which("git") is None, "git is not installed")
class RegistryVersionTest(unittest.TestCase):
    """Chooses registry versions in a scratch repository whose origin is itself."""

    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.repository = Path(directory.name)
        environment = {"GIT_CONFIG_GLOBAL": os.devnull, "GIT_CONFIG_NOSYSTEM": "1"}
        patcher = mock.patch.dict(os.environ, environment)
        patcher.start()
        self.addCleanup(patcher.stop)
        self.git("init", "--quiet", ".")
        self.git("remote", "add", "origin", str(self.repository))
        self.count = 0

    def git(self, *args: str) -> str:
        return subprocess.run(
            ["git", "-c", "user.name=test", "-c", "user.email=test@example.invalid",
             "-c", "commit.gpgsign=false", "-c", "tag.gpgsign=false", *args],
            cwd=self.repository, check=True, capture_output=True, text=True,
        ).stdout.strip()

    def publish(self, **kwargs) -> tuple[str, str]:
        """Commit a publication and return its tag and commit."""
        self.count += 1
        tag = f"graphmodules-{self.count:020x}"
        path = self.repository / ".release/interface-changes.json"
        path.parent.mkdir(exist_ok=True)
        path.write_text(interface_changes(tag, **kwargs), encoding="utf-8")
        self.git("add", "--all")
        self.git("commit", "--quiet", "--message", tag)
        return tag, self.git("rev-parse", "HEAD")

    def version(self, tag: str, sha: str):
        with contextlib.chdir(self.repository):
            return release.registry_version(tag, sha)

    def test_first_registry_version(self):
        self.assertEqual(self.version(*self.publish()), ("v1.0.0", False))

    def test_bumps_from_the_newest_registry_tag(self):
        _, first = self.publish()
        self.git("tag", "v1.0.0", first)
        cases = [
            ("v1.0.1", {}),
            ("v1.1.0", {"counts": {"output_added": 1}}),
            ("v2.0.0", {"counts": {"output_removed": 1}, "decisions": [{"decision": "d"}]}),
            ("v2.0.0", {"compared": False}),
        ]
        for expected, changes in cases:
            with self.subTest(changes=changes):
                self.git("reset", "--quiet", "--hard", first)
                self.assertEqual(self.version(*self.publish(**changes)), (expected, False))

    def test_untagged_breaking_publication_still_counts(self):
        _, first = self.publish()
        self.git("tag", "v1.4.2", first)
        self.publish(decisions=[{"decision": "d"}])  # its registry tag was never created
        self.assertEqual(self.version(*self.publish()), ("v2.0.0", False))

    def test_existing_tag_is_reused(self):
        tag, sha = self.publish()
        self.git("tag", "--annotate", "--message", "v", "v1.0.0", sha)
        self.assertEqual(self.version(tag, sha), ("v1.0.0", True))

    def test_annotated_newest_tag_is_peeled(self):
        _, first = self.publish()
        self.git("tag", "--annotate", "--message", "v", "v1.0.0", first)
        self.assertEqual(self.version(*self.publish(counts={"module_added": 1})), ("v1.1.0", False))

    def test_recovery_run_for_an_older_publication_gets_no_version(self):
        old_tag, old = self.publish()
        _, new = self.publish()
        self.git("tag", "v1.0.0", new)
        self.assertIsNone(self.version(old_tag, old))

    def test_ignores_tags_that_are_not_semver(self):
        _, first = self.publish()
        for name in ("v1.0", "v01.0.0", "1.0.0", "graphmodules-x"):
            self.git("tag", name, first)
        self.assertEqual(self.version(*self.publish()), ("v1.0.0", False))

    def test_rejects_interface_changes_of_another_tag(self):
        _, first = self.publish()
        self.git("tag", "v1.0.0", first)
        _, sha = self.publish()
        with self.assertRaisesRegex(ValueError, "does not describe graphmodules-other"):
            self.version("graphmodules-other", sha)


class ReleaseTagsRegistryVersionTest(unittest.TestCase):
    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.directory = Path(directory.name)
        (self.directory / "release-notes.md").write_text("Notes.\n", encoding="utf-8")
        self.github = FakeGitHub()

    def publish(self) -> str:
        with mock.patch.dict(os.environ, {"GITHUB_STEP_SUMMARY": ""}), self.github.serve() as output:
            release.release(REGISTRY_REPOSITORY, TAG, SHA, [], self.directory)
        return output.getvalue()

    def tag_writes(self):
        return [c for c in self.github.ref_writes() if "ref=refs/tags/v1.0.0" in c]

    def test_new_release_tags_after_publishing_and_names_the_version(self):
        self.github.release = {"draft": True, "target_commitish": SHA, "html_url": "draft"}
        self.publish()
        commands = [" ".join(c[:3]) for c in self.github.commands]
        self.assertEqual(len(self.tag_writes()), 1)
        tag_write = self.github.commands.index(self.tag_writes()[0])
        self.assertGreater(tag_write, commands.index("gh release edit"))
        notes = (self.directory / "release-notes.md").read_text(encoding="utf-8")
        self.assertIn("Terraform Registry: `satolap/modules/msgraph` version `1.0.0`.", notes)

    def test_already_published_release_is_tagged_too(self):
        self.github.release = {"draft": False, "target_commitish": SHA, "html_url": "published"}
        self.publish()
        self.assertEqual(len(self.tag_writes()), 1)

    def test_refused_tag_only_warns(self):
        self.github.release = {"draft": False, "target_commitish": SHA, "html_url": "published"}
        self.github.gh_api_error = FORBIDDEN
        output = self.publish()
        self.assertIn(f"`git push origin {SHA}:refs/tags/v1.0.0`", output)

    def test_repository_not_named_for_the_registry_is_never_tagged(self):
        self.github.release = {"draft": True, "target_commitish": SHA, "html_url": "draft"}
        with self.github.serve():
            release.release(REPOSITORY, TAG, SHA, [], self.directory)
        self.assertEqual(self.tag_writes(), [])
        self.assertNotIn("Terraform Registry", (self.directory / "release-notes.md").read_text())


class VerifyRegistryTagsTest(unittest.TestCase):
    def verify(self, tags, releases=None, latest=TAG, ancestor=True) -> list[str]:
        with (
            mock.patch.object(release, "registry_tags", return_value=tags),
            mock.patch.object(release, "published_release_commits",
                              return_value=releases if releases is not None else {SHA: TAG}),
            mock.patch.object(release, "request_json", return_value={"tag_name": latest}),
            mock.patch.object(release, "is_ancestor", return_value=ancestor),
            contextlib.redirect_stdout(io.StringIO()),
        ):
            return release.verify_registry_tags(REGISTRY_REPOSITORY)

    def test_accepts_tags_on_published_releases(self):
        self.assertEqual(self.verify({(1, 0, 0): SHA}), [])

    def test_no_tags_yet_is_not_a_failure(self):
        self.assertEqual(self.verify({}), [])

    def test_rejects_a_tag_on_an_unpublished_commit(self):
        failures = self.verify({(1, 0, 0): OLDER_SHA, (1, 0, 1): SHA}, releases={SHA: TAG})
        self.assertEqual(failures, [f"v1.0.0 at {OLDER_SHA} is not a published release"])

    def test_rejects_versions_out_of_history_order(self):
        tags = {(1, 0, 0): SHA, (1, 1, 0): OLDER_SHA}
        failures = self.verify(tags, releases={SHA: TAG, OLDER_SHA: NEWER_TAG}, ancestor=False)
        self.assertEqual(failures, ["v1.1.0 does not follow v1.0.0 in history"])

    def test_rejects_a_latest_release_without_a_version(self):
        failures = self.verify({(1, 0, 0): SHA}, releases={SHA: TAG, OLDER_SHA: NEWER_TAG},
                               latest=NEWER_TAG)
        self.assertEqual(failures, [f"GitHub Latest release {NEWER_TAG} has no registry version tag"])

    def test_repository_not_named_for_the_registry_is_skipped(self):
        with mock.patch.object(release, "registry_tags") as tags, contextlib.redirect_stdout(io.StringIO()):
            self.assertEqual(release.verify_registry_tags("benhaspalace/GraphModules"), [])
        tags.assert_not_called()

    def test_main_needs_no_tag_and_fails_on_failures(self):
        argv = ["release.py", "--verify-registry-tags", "--repository", REGISTRY_REPOSITORY]
        with mock.patch.object(sys, "argv", argv):
            with mock.patch.object(release, "verify_registry_tags", return_value=[]):
                release.main()
            with mock.patch.object(release, "verify_registry_tags", return_value=["x"]):
                with self.assertRaises(SystemExit):
                    release.main()


WORKFLOW = Path(__file__).resolve().parent.parent / ".github" / "workflows" / "release.yml"
MANIFEST = "modules/generated/release-manifest.json"
GUARD_IF = "github.event_name == 'push'"
ACTOR_IF = (
    "github.ref == 'refs/heads/main' && (github.event_name == 'workflow_dispatch' || "
    "github.actor == 'graphmodules-release-publisher[bot]')"
)
CHANGED_OUTPUT = (
    "${{ github.event_name == 'workflow_dispatch' && 'true' || steps.manifest.outputs.changed }}"
)
RELEASE_JOB_IF = "needs.manifest.outputs.changed == 'true'"
# Only a run that will release joins the release group: a new job in a group cancels the job
# pending there, so a run that cannot release must never take a waiting publication's place.
# The group is set on the release job because only a job-level group can read needs.
CONCURRENCY_GROUP = (
    f"${{{{ {RELEASE_JOB_IF} && 'graphmodules-release' "
    "|| format('graphmodules-release-skipped-{0}', github.run_id) }}"
)


def mapping(lines: list[str], indent: int) -> dict[str, list[str]]:
    """Keys at exactly `indent` spaces, each as [inline value, *nested lines].

    A careful text reading of the block-style YAML in release.yml, so that the tests keep
    using only the standard library (and "on" stays a string, not YAML 1.1's True).
    """
    entries: dict[str, list[str]] = {}
    key = None
    for line in lines:
        depth = len(line) - len(line.lstrip(" "))
        text = line.strip()
        if text.startswith("#") and depth <= indent:
            continue
        if text and depth == indent:
            key, separator, value = text.partition(":")
            if not separator or key in entries:
                raise AssertionError(f"Unexpected line at indent {indent}: {line!r}")
            entries[key] = [value.strip()]
        elif text and depth < indent:
            raise AssertionError(f"Unexpected dedent to {depth}: {line!r}")
        elif key is not None:
            entries[key].append(line)
    return entries


def content(entry: list[str]) -> list[str]:
    """The non-blank nested lines of an entry."""
    return [line for line in entry[1:] if line.strip()]


def scalar(entry: list[str]) -> str:
    """A plain or folded (>-) scalar as one line."""
    inline, *nested = entry
    parts = nested if inline in (">", ">-") else [inline, *nested]
    return " ".join(part.strip() for part in parts if part.strip())


def workflow_job(text: str, name: str) -> dict[str, list[str]]:
    return mapping(mapping(mapping(text.splitlines(), 0)["jobs"][1:], 2)[name][1:], 4)


def workflow_steps(text: str, name: str) -> list[dict[str, list[str]]]:
    job = workflow_job(text, name)
    steps: list[list[str]] = []
    for line in job["steps"][1:]:
        if line.startswith("      - "):
            steps.append(["        " + line[len("      - "):]])
        elif steps:
            steps[-1].append(line)
    return [mapping(step, 8) for step in steps]


def run_script(step: dict[str, list[str]]) -> str:
    inline, *nested = step["run"]
    if inline != "|":
        raise AssertionError(f"Expected a literal run block, got {inline!r}")
    return "".join(line[10:] + "\n" for line in nested).rstrip("\n") + "\n"


def find_step(steps: list[dict[str, list[str]]], **wanted: str) -> tuple[int, dict[str, list[str]]]:
    """The one step whose keys contain each wanted text, with its index."""
    found = [
        (index, step) for index, step in enumerate(steps)
        if all(key in step and needle in "\n".join(step[key]) for key, needle in wanted.items())
    ]
    if len(found) != 1:
        raise AssertionError(f"Expected exactly one step with {wanted}, found {len(found)}")
    return found[0]


class ReleaseWorkflowTest(unittest.TestCase):
    """Static checks of .github/workflows/release.yml (GraphForm #122)."""

    def setUp(self):
        self.text = WORKFLOW.read_text(encoding="utf-8")
        self.top = mapping(self.text.splitlines(), 0)
        self.jobs = mapping(self.top["jobs"][1:], 2)
        self.manifest = workflow_job(self.text, "manifest")
        self.release = workflow_job(self.text, "release")
        self.steps = {name: workflow_steps(self.text, name) for name in ("manifest", "release")}

    def test_push_trigger_has_no_paths_filter(self):
        # GitHub does not start a paths-filtered workflow when the pushed diff has more than
        # 3,000 files and the matching file is not among the first 3,000 (#122).
        triggers = mapping(self.top["on"][1:], 2)
        self.assertEqual(set(triggers), {"push", "workflow_dispatch"})
        push = mapping(triggers["push"][1:], 4)
        self.assertNotIn("paths", push)
        self.assertNotIn("paths-ignore", push)
        self.assertEqual(push, {"branches": ["[main]"]})
        dispatch = mapping(triggers["workflow_dispatch"][1:], 4)
        self.assertIn("tag:", "\n".join(dispatch["inputs"]))

    def test_push_releases_only_for_the_publisher_app(self):
        self.assertEqual(set(self.jobs), {"manifest", "release"})
        self.assertEqual(scalar(self.manifest["if"]), ACTOR_IF)
        # The release job runs only after the gated manifest job succeeded and said so.
        self.assertEqual(scalar(self.release["needs"]), "manifest")
        self.assertEqual(scalar(self.release["if"]), RELEASE_JOB_IF)

    def test_release_job_depends_on_the_manifest_change_guard(self):
        steps = self.steps["manifest"]
        checkout, _ = find_step(steps, uses="actions/checkout@")
        self.assertIn("fetch-depth: 0", "\n".join(steps[checkout]["with"]))
        guard, step = find_step(steps, id="manifest")
        self.assertGreater(guard, checkout)
        self.assertIn("if", step, "The guard must run on push only")
        self.assertEqual(scalar(step["if"]), GUARD_IF)
        self.assertEqual(scalar(step["shell"]), "python {0}")
        env = mapping(step["env"][1:], 10)
        self.assertEqual(scalar(env["BEFORE"]), "${{ github.event.before }}")
        self.assertEqual(scalar(env["PUBLICATION_COMMIT"]), "${{ github.sha }}")
        script = run_script(step)
        self.assertIn(MANIFEST, script)
        self.assertIn('"git", "diff"', script)
        self.assertIn("GITHUB_OUTPUT", script)
        outputs = mapping(self.manifest["outputs"][1:], 6)
        self.assertEqual(set(outputs), {"changed"})
        self.assertEqual(scalar(outputs["changed"]), CHANGED_OUTPUT)
        for number, step in enumerate(steps):
            self.assertNotIn("scripts/release.py", "\n".join(step.get("run", [])), number)
        _, publish = find_step(self.steps["release"], run="scripts/release.py")
        # The job-level if decides; a step-level if could only drift from it.
        self.assertNotIn("if", publish)

    def test_run_scripts_read_event_values_from_env(self):
        # Script-injection hygiene: expressions go through env, never into the script text.
        scripts = [run_script(step) for steps in self.steps.values() for step in steps if "run" in step]
        self.assertEqual(len(scripts), 2)
        for script in scripts:
            self.assertNotIn("${{", script)

    def test_actions_and_permissions_are_pinned(self):
        for name, steps in self.steps.items():
            uses = [scalar(step["uses"]) for step in steps if "uses" in step]
            self.assertEqual(len(uses), 2, name)
            for action in uses:
                self.assertRegex(action, r"^[\w-]+/[\w-]+@[0-9a-f]{40} # v\d+\.\d+\.\d+$")
        self.assertEqual(content(self.top["permissions"]), ["  contents: read"])
        self.assertNotIn("permissions", self.manifest)
        self.assertEqual(content(self.release["permissions"]), ["      contents: write"])

    def test_only_runs_that_will_release_share_the_concurrency_group(self):
        # "By default, any existing pending job or workflow in the same concurrency group will
        # be canceled" (GitHub docs). Without the paths filter every push to main starts a run,
        # so a human merge, or a publisher push that leaves the manifest unchanged, in the
        # shared group would cancel a publication waiting there. A workflow-level group can
        # read only github, inputs and vars, so it cannot know the guard's result.
        self.assertNotIn("concurrency", self.top)
        self.assertNotIn("concurrency", self.manifest)
        concurrency = mapping(self.release["concurrency"][1:], 6)
        self.assertEqual(set(concurrency), {"group", "cancel-in-progress"})
        self.assertEqual(scalar(concurrency["cancel-in-progress"]), "false")
        self.assertEqual(scalar(concurrency["group"]), CONCURRENCY_GROUP)


@unittest.skipIf(shutil.which("git") is None, "git is not installed")
class ManifestGuardTest(unittest.TestCase):
    """Runs the workflow's manifest-change guard against a scratch repository."""

    def setUp(self):
        _, step = find_step(workflow_steps(WORKFLOW.read_text(encoding="utf-8"), "manifest"), id="manifest")
        self.script = run_script(step)
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.repository = Path(directory.name) / "repository"
        self.output = Path(directory.name) / "output"
        self.environment = {
            **os.environ, "GIT_CONFIG_GLOBAL": os.devnull, "GIT_CONFIG_NOSYSTEM": "1",
        }
        self.git("init", "--quiet", str(self.repository), cwd=directory.name)
        self.first = self.commit({MANIFEST: "{}\n", "modules/generated/v1.0/a/main.tf": "a\n"})

    def git(self, *args: str, cwd=None) -> str:
        return subprocess.run(
            ["git", "-c", "user.name=test", "-c", "user.email=test@example.invalid",
             "-c", "commit.gpgsign=false", *args],
            cwd=cwd or self.repository, env=self.environment,
            check=True, capture_output=True, text=True,
        ).stdout.strip()

    def commit(self, files: dict[str, str]) -> str:
        for name, content in files.items():
            (self.repository / name).parent.mkdir(parents=True, exist_ok=True)
            (self.repository / name).write_text(content, encoding="utf-8")
        self.git("add", "--all")
        self.git("commit", "--quiet", "--message", "publication")
        return self.git("rev-parse", "HEAD")

    def run_guard(self, before: str, commit: str, check: bool) -> subprocess.CompletedProcess:
        self.output.write_text("", encoding="utf-8")
        return subprocess.run(
            [sys.executable, "-c", self.script], cwd=self.repository, check=check,
            capture_output=True, text=True,
            env={**self.environment, "BEFORE": before, "PUBLICATION_COMMIT": commit,
                 "GITHUB_OUTPUT": str(self.output)},
        )

    def guard(self, before: str, commit: str) -> tuple[str, str]:
        result = self.run_guard(before, commit, check=True)
        return self.output.read_text(encoding="utf-8"), result.stdout

    def test_manifest_change_releases(self):
        commit = self.commit({MANIFEST: '{"tag": "new"}\n'})
        self.assertEqual(self.guard(self.first, commit)[0], "changed=true\n")

    def test_large_publication_that_changes_the_manifest_releases(self):
        files = {f"modules/generated/v1.0/m{index:04}/main.tf": "m\n" for index in range(3001)}
        commit = self.commit({**files, MANIFEST: '{"tag": "large"}\n'})
        self.assertEqual(self.guard(self.first, commit)[0], "changed=true\n")

    def test_push_without_a_manifest_change_does_not_release(self):
        commit = self.commit({"README.md": "docs\n"})
        output, stdout = self.guard(self.first, commit)
        self.assertEqual(output, "changed=false\n")
        self.assertIn(f"::notice::{commit} does not change {MANIFEST}", stdout)

    def test_unknown_previous_commit_is_treated_as_changed(self):
        commit = self.commit({"README.md": "docs\n"})
        for before in ("0" * 40, "", "not-a-commit", "1" * 40, "--output=/dev/null"):
            with self.subTest(before=before):
                output, stdout = self.guard(before, commit)
                self.assertEqual(output, "changed=true\n")
                self.assertIn("::warning::Cannot compare with previous commit", stdout)

    def test_only_a_commit_sha_is_compared(self):
        # A symbolic ref or a non-commit object must not reach git diff, even when git could
        # resolve it: the guard compares the pushed range only, and otherwise releases.
        commit = self.commit({"README.md": "docs\n"})
        tree = self.git("rev-parse", f"{self.first}^{{tree}}")
        for before in ("HEAD~1", tree):
            with self.subTest(before=before):
                self.assertEqual(self.guard(before, commit)[0], "changed=true\n")

    def test_failed_comparison_fails_the_job(self):
        # A comparison that cannot run must fail the job, never be read as "not changed".
        missing = "f" * 40  # well formed, but not a commit in the repository
        result = self.run_guard(self.first, missing, check=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(f"git diff {self.first} {missing} failed with exit code", result.stderr)
        self.assertEqual(self.output.read_text(encoding="utf-8"), "")


if __name__ == "__main__":
    unittest.main()
