Microsoft Graph modules for v1.0 and beta, plus curated modules.

- Generator commit: `9c2d60e3dd7774d65ff834ca986450eb9f4ff09d`
- Microsoft Graph metadata commit: `7b2914c8ad1340129f52aa785f13c074cb46fd7c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `eb2d5f1aa0c898e21711087479c9e1cfb96cba1403e05dc2de2eb5d17754dac1`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1430/1430, contract_reviewed 5/1430, lifecycle_verified 0/1430
- beta: schema_validated 2479/2479, contract_reviewed 5/2479, lifecycle_verified 0/2479

Contract/interface and evidence changes: .

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

This release tags the GraphModules commit containing generated modules under `modules/generated/<api>` and curated modules under `modules/curated`. Git module sources use `//modules/generated/<api>/<category>/<module>?ref=<release-tag>` or `//modules/curated/<module>?ref=<release-tag>`. The module-only archives below preserve those same paths. Each module archive includes `release-manifest.json`. Verify downloads with `sha256sum -c SHA256SUMS`.

Example using this release's exact tag:

```hcl
module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/applications/applications?ref=graphmodules-eb2d5f1aa0c898e21711"
  display_name = "Example application"
}

module "curated_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/groups?ref=graphmodules-eb2d5f1aa0c898e21711"
  display_name     = "Example group"
  mail_nickname    = "example-group"
  security_enabled = true
}
```
