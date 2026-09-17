Microsoft Graph modules for v1.0 and beta, plus curated modules.

- Generator commit: `fc18afe2781f926dcdb9c6a2d71dccf4808a1982`
- Microsoft Graph metadata commit: `28e4d24f3547898328eb52c700f2beb869116cfe`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `067c9d13832914ce38d2ecd275076b30b48387f55d5e4017ec4982a2fa1de3e3`

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

This release tags the GraphModules commit containing generated modules under `modules/generated/<api>` and curated modules under `modules/curated`. Git module sources use `//modules/generated/<api>/<category>/<module>?ref=<release-tag>` or `//modules/curated/<module>?ref=<release-tag>`. The module-only archives below preserve those same paths. Each module archive includes `release-manifest.json`. Verify downloads with `sha256sum -c SHA256SUMS`.

Example using this release's exact tag:

```hcl
module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/applications/applications?ref=graphmodules-067c9d13832914ce38d2"
  display_name = "Example application"
}

module "curated_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/groups?ref=graphmodules-067c9d13832914ce38d2"
  display_name     = "Example group"
  mail_nickname    = "example-group"
  security_enabled = true
}
```
