Microsoft Graph modules for v1.0 and beta, plus curated modules.

- Generator commit: `45c7fe8dd8bc12b1b5cb2f61da2533041eb61f78`
- Microsoft Graph metadata commit: `b8cbef92f6959dca8150bf3edcc650863765e529`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `e7a8ce8ca695596df2c6e28823194d463b707b971761dc4e50de92cdc3386876`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1430/1430, contract_reviewed 5/1430, lifecycle_verified 0/1430
- beta: schema_validated 2479/2479, contract_reviewed 5/2479, lifecycle_verified 0/2479

Contract/interface and evidence changes: .

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

This release tags the GraphModules commit containing generated modules under `modules/generated/<api>` and curated modules under `modules/curated`. Git module sources use `//modules/generated/<api>/<category>/<module>?ref=<release-tag>` or `//modules/curated/<module>?ref=<release-tag>`. The module-only archives below preserve those same paths. Each module archive includes `release-manifest.json`. Verify downloads with `sha256sum -c SHA256SUMS`.

Example using this release's exact tag:

```hcl
module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/applications/applications?ref=graphmodules-e7a8ce8ca695596df2c6"
  display_name = "Example application"
}

module "curated_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/groups?ref=graphmodules-e7a8ce8ca695596df2c6"
  display_name     = "Example group"
  mail_nickname    = "example-group"
  security_enabled = true
}
```
