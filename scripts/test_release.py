"""Offline tests for release verification. Run: python -m unittest discover -s scripts"""

import contextlib
import hashlib
import io
import os
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import release

TAG = "graphmodules-067c9d13832914ce38d2"
SHA = "539975df7dbe162de40f2afff3f5c94f59e5db9e"


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


if __name__ == "__main__":
    unittest.main()
