# GraphModules

Tested Terraform modules for Microsoft Graph, generated and curated in
a private generator repository.

Browse the [v1.0 catalog](generated/v1.0/README.md),
[beta catalog](generated/beta/README.md), or [curated modules](modules).
Each [release](https://github.com/benhaspalace/GraphModules/releases) includes
the three module archives, an input provenance manifest, and SHA256 checksums.

```hcl
module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//generated/v1.0/applications/applications?ref=<release-tag>"
  display_name = "Example application"
}

module "curated_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/groups?ref=<release-tag>"
  display_name     = "Example group"
  mail_nickname    = "example-group"
  security_enabled = true
}
```

Replace `<release-tag>` with a published tag and configure the `microsoft/msgraph`
provider in the calling root module. Pin a release for repeatable deployments.
Beta modules retain Microsoft Graph's preview limitations.

## Publication and trust

The generator validates every generated and curated module before publishing its tested
files to this repository's `main` branch. A private GitHub App is installed only on
**GraphModules**, with **Contents: write** and the required Metadata: read permission.
Its private key is the environment secret `GRAPHMODULES_APP_PRIVATE_KEY` in
the generator's **graphmodules** environment, restricted to the **main branch**.
The environment variable `GRAPHMODULES_APP_CLIENT_ID` identifies the App.
Pull-request builds have no access to that environment.

The official `actions/create-github-app-token` action issues a token limited to this
repository and `contents: write` for each publishing job. It expires within one hour
and is revoked at job completion. Checkout removes persisted credentials in its
post-step. No personal access token or deploy key is stored.

The publisher verifies source freshness, checksums and safe archive paths. It pushes
`main` and the release tag atomically, without force. It owns `generated/v1.0`,
`generated/beta`, `generated/release-manifest.json`, `modules`, `.release`, `LICENSE`
and `NOTICE`; changes to modules belong in the generator repository.

The App-token push triggers **Release modules** here. That workflow uses its own
short-lived `GITHUB_TOKEN` with `contents: write` to create the GitHub Release.
It reconstructs the archives from the tagged commit and requires their SHA256 sums
to match the exact assets tested by the generator before uploading a draft and publishing
it. No personal access token is stored, and no credential grants GraphModules write
access to the generator repository.

GitHub documents [App authentication in workflows](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/making-authenticated-api-requests-with-a-github-app-in-a-github-actions-workflow)
and [workflow triggering by authentication type](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow).

## Recovery and rotation

If code publication succeeds but release creation fails, rerun the failed **Release
modules** run or dispatch it on `main` with the existing release tag. Published
releases are never overwritten. The generator waits for matching release checksums and
fails visibly if this workflow does not finish within ten minutes.

To rotate trust, generate a replacement App private key, replace the environment
secret in the generator repository, verify a release, then revoke the old private key. Suspending
or uninstalling the App from GraphModules revokes its installation access. If branch or tag rules are
introduced, explicitly allow this publisher; do not disable protections to recover
a failed release. Actions must remain enabled in both repositories.

The source generator, module fixes, tests and examples live in the generator repository. Historical
Earlier releases remain available there; new releases are published here.
