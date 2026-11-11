"""Offline tests for the daily release verification. Run: python -m unittest discover -s scripts"""

import contextlib
import io
import os
import shutil
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import verify_releases
from test_release import WORKFLOW, content, find_step, mapping, scalar, workflow_job, workflow_steps

VERIFY_WORKFLOW = WORKFLOW.parent / "verify-releases.yml"
ASSETS = ("SHA256SUMS", "graphmodules-v1.0-modules.tar.gz")


class ExemptionTest(unittest.TestCase):
    """Only releases named in an exemption list skip a check; no version range does."""

    def test_no_published_release_is_exempt(self):
        # Every published release has a verified catalog and attested assets. An exemption
        # must name a release that was checked and found to lack them.
        self.assertEqual(verify_releases.WITHOUT_VERIFIED_CATALOG, frozenset())
        self.assertEqual(verify_releases.PUBLISHED_BEFORE_ATTESTATIONS, frozenset())

    def test_0x_releases_are_rebuilt_and_require_attestations(self):
        for tag in ("v0.5.0", "v0.5.1", "v0.9.9", "v0.10.0", "v1.0.0", "v4.0.0", "v5.0.0"):
            self.assertTrue(verify_releases.rebuildable(tag), tag)
            self.assertTrue(verify_releases.attestation_required(tag), tag)

    def test_only_listed_releases_are_exempt(self):
        with (
            mock.patch.object(verify_releases, "WITHOUT_VERIFIED_CATALOG", frozenset({"v1.0.0"})),
            mock.patch.object(verify_releases, "PUBLISHED_BEFORE_ATTESTATIONS", frozenset({"v4.0.0"})),
        ):
            self.assertFalse(verify_releases.rebuildable("v1.0.0"))
            self.assertFalse(verify_releases.attestation_required("v4.0.0"))
            for tag in ("v0.5.0", "v0.9.9", "v1.0.1", "v3.9.9", "v4.0.1"):
                self.assertTrue(verify_releases.rebuildable(tag), tag)
                self.assertTrue(verify_releases.attestation_required(tag), tag)


class VerifyReleasesTest(unittest.TestCase):
    """Runs main() with a fake gh, git and release.py."""

    def verify(self, released, attested=lambda tag, name: True, rebuild_fails=(), tags=None,
               without_catalog=frozenset(), before_attestations=frozenset()):
        """Returns (exit code, commands run, stdout, step summary lines)."""
        summary = Path(tempfile.mkdtemp()) / "summary.md"
        self.addCleanup(shutil.rmtree, summary.parent, True)
        runs = []
        current = {}

        def check_output(command, *args, **kwargs):
            if command[:2] == ["gh", "api"]:
                return released
            self.assertEqual(command[:3], ["git", "tag", "--list"])
            return released if tags is None else tags

        def run(command, *args, **kwargs):
            runs.append(command)
            if command[1] == "scripts/release.py":
                current["tag"] = command[3]
                if command[3] in rebuild_fails:
                    return mock.Mock(returncode=1)
                output = Path(command[command.index("--output-dir") + 1])
                output.mkdir(parents=True)
                for name in ASSETS:
                    (output / name).write_text(name, encoding="utf-8")
                return mock.Mock(returncode=0)
            self.assertEqual(command[:3], ["gh", "attestation", "verify"])
            return mock.Mock(returncode=0 if attested(current["tag"], Path(command[3]).name) else 1)

        env = {"GH_REPO": "owner/repo", "GITHUB_STEP_SUMMARY": str(summary)}
        stdout = io.StringIO()
        code = None
        with (
            mock.patch.dict(os.environ, env),
            mock.patch.object(verify_releases, "WITHOUT_VERIFIED_CATALOG", frozenset(without_catalog)),
            mock.patch.object(
                verify_releases, "PUBLISHED_BEFORE_ATTESTATIONS", frozenset(before_attestations)
            ),
            mock.patch("subprocess.check_output", side_effect=check_output),
            mock.patch("subprocess.run", side_effect=run),
            contextlib.redirect_stdout(stdout),
        ):
            try:
                verify_releases.main()
            except SystemExit as error:
                code = error.code
        return code, runs, stdout.getvalue(), summary.read_text(encoding="utf-8").splitlines()

    def test_unattested_0x_release_fails(self):
        code, _, stdout, lines = self.verify(
            "v0.5.0", attested=lambda tag, name: name != "SHA256SUMS",
        )
        self.assertEqual(code, "Release verification failed: v0.5.0")
        self.assertIn("::error::v0.5.0 assets lack a valid attestation: SHA256SUMS", stdout)
        self.assertIn("- Failed (no valid attestation): `v0.5.0`: SHA256SUMS", lines)

    def test_listed_historical_release_passes_without_attestations(self):
        code, _, stdout, lines = self.verify(
            "v4.0.0", attested=lambda tag, name: False, before_attestations={"v4.0.0"},
        )
        self.assertIsNone(code)
        self.assertIn("::notice::v4.0.0 predates release attestations", stdout)
        self.assertIn("- Verified (published before attestations): `v4.0.0`", lines)

    def test_attested_release_passes(self):
        code, _, _, lines = self.verify("v0.5.0")
        self.assertIsNone(code)
        self.assertIn("- Verified and attested: `v0.5.0`", lines)
        self.assertFalse([line for line in lines if "Failed" in line])

    def test_listing_one_release_exempts_no_other(self):
        code, _, _, lines = self.verify(
            "v0.5.0 v4.0.0 v5.0.0",
            attested=lambda tag, name: False,
            before_attestations={"v4.0.0"},
        )
        self.assertEqual(code, "Release verification failed: v0.5.0, v5.0.0")
        self.assertIn("- Verified (published before attestations): `v4.0.0`", lines)
        for tag in ("v0.5.0", "v5.0.0"):
            self.assertIn(f"- Failed (no valid attestation): `{tag}`: {', '.join(ASSETS)}", lines)

    def test_listed_release_without_a_verified_catalog_is_skipped_not_failed(self):
        code, runs, stdout, lines = self.verify(
            "v0.5.0 v1.0.0", tags="v0.5.0 v1.0.0 v1.1.0", without_catalog={"v1.0.0"},
        )
        self.assertIsNone(code)
        rebuilt = [command[3] for command in runs if command[1] == "scripts/release.py"]
        self.assertEqual(rebuilt, ["v0.5.0"])
        self.assertIn("::notice::Skipped v1.0.0: no verified module catalog", stdout)
        self.assertIn("- Skipped (no verified module catalog): `v1.0.0`", lines)
        self.assertIn("- Verified and attested: `v0.5.0`", lines)
        self.assertIn("- Warning: tag `v1.1.0` has no published release", lines)

    def test_each_rebuilt_asset_is_verified_against_the_release_workflow(self):
        _, runs, _, _ = self.verify("v0.5.0")
        checks = [command for command in runs if command[0] == "gh"]
        self.assertEqual(sorted(Path(command[3]).name for command in checks), sorted(ASSETS))
        for command in checks:
            self.assertEqual(command[4:], [
                "--repo", "owner/repo",
                "--signer-workflow", "owner/repo/.github/workflows/release.yml",
                "--source-ref", "refs/heads/main",
            ])

    def test_failed_rebuild_is_not_checked_for_attestations(self):
        code, runs, _, lines = self.verify("v0.5.0", rebuild_fails=("v0.5.0",))
        self.assertEqual(code, "Release verification failed: v0.5.0")
        self.assertFalse([command for command in runs if command[0] == "gh"])
        self.assertIn("- Failed: `v0.5.0`", lines)


class VerifyReleasesWorkflowTest(unittest.TestCase):
    """Static checks of .github/workflows/verify-releases.yml."""

    def setUp(self):
        self.text = VERIFY_WORKFLOW.read_text(encoding="utf-8")
        self.top = mapping(self.text.splitlines(), 0)
        self.job = workflow_job(self.text, "verify")
        self.steps = workflow_steps(self.text, "verify")

    def test_rebuild_step_runs_the_tested_script(self):
        _, step = find_step(self.steps, name="Rebuild every published release")
        self.assertEqual(scalar(step["run"]), "python scripts/verify_releases.py")
        self.assertNotIn("shell", step)
        env = mapping(step["env"][1:], 10)
        self.assertEqual(scalar(env["GH_TOKEN"]), "${{ github.token }}")
        self.assertEqual(scalar(env["GH_REPO"]), "${{ github.repository }}")

    def test_triggers_actions_and_permissions_are_pinned(self):
        self.assertEqual(set(mapping(self.top["on"][1:], 2)), {"schedule", "workflow_dispatch"})
        uses = [scalar(step["uses"]) for step in self.steps if "uses" in step]
        self.assertEqual(len(uses), 2)
        for action in uses:
            self.assertRegex(action, r"^[\w-]+/[\w-]+@[0-9a-f]{40} # v\d+\.\d+\.\d+$")
        self.assertEqual(content(self.top["permissions"]), ["  contents: read"])
        self.assertEqual(
            content(self.job["permissions"]), ["      contents: read", "      attestations: read"]
        )


if __name__ == "__main__":
    unittest.main()
