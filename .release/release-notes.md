Microsoft Graph modules for v1.0 and beta, plus curated modules.

- Generator commit: `19562375b3c10f3156020e45f9c1a221452e601b`
- Microsoft Graph metadata commit: `28e4d24f3547898328eb52c700f2beb869116cfe`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `b25cf2f0c8c718999b1b14ba641cf90507b7e92541479b5bdfcb33c1cacd973c`

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

This release tags the GraphModules commit containing generated modules under `modules/generated/<api>` and curated modules under `modules/curated`. Git module sources use `//modules/generated/<api>/<category>/<module>?ref=<release-tag>` or `//modules/curated/<module>?ref=<release-tag>`. The module-only archives below preserve those same paths. Each module archive includes `release-manifest.json`. Verify downloads with `sha256sum -c SHA256SUMS`.

Example using this release's exact tag:

```hcl
module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/applications/applications?ref=graphmodules-b25cf2f0c8c718999b1b"
  display_name = "Example application"
}

module "curated_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/groups?ref=graphmodules-b25cf2f0c8c718999b1b"
  display_name     = "Example group"
  mail_nickname    = "example-group"
  security_enabled = true
}
```
