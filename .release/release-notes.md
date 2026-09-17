Generated Microsoft Graph modules for v1.0 and beta, plus the curated modules.

- Generator commit: `aba3ff0ff15fadc86315e438c30ce22d65bf5165`
- Microsoft Graph metadata commit: `28e4d24f3547898328eb52c700f2beb869116cfe`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `67a6846bf4b9fc488842d775bf0263a9290365f95ee9e5a64a638e8b5d99c8e6`

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

This release tags the GraphModules commit containing the validated modules under `generated/v1.0`, `generated/beta` and curated `modules`. Git module sources use `//generated/<api>/<category>/<module>?ref=<release-tag>`. The module-only archives below keep the same catalog under `modules/<api>`. Each module archive includes `release-manifest.json`. Verify downloads with `sha256sum -c SHA256SUMS`.
