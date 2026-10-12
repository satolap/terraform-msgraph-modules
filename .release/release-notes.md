Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1411 modules; 0 added, 0 removed, 0 interface-changed.
- beta: 2400 modules; 0 added, 0 removed, 0 interface-changed.
- curated: 17 modules; 0 added, 0 removed, 0 interface-changed.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Provenance:

- Generator commit: `cebc3b43769d8e20b32f32020bab2a28f384acf5`
- Microsoft Graph metadata commit: `fd42f0e5bcd96b0c5edd5e62e2956a1dc1c5d17a`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `d14d59c9000a035c39ba0d830209073ae3bf875d9513456aff243d7e60b232ee`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1411/1411, contract_reviewed 6/1411, lifecycle_verified 0/1411
- beta: schema_validated 2400/2400, contract_reviewed 6/2400, lifecycle_verified 0/2400

Contract/interface and evidence changes: none. The release gate reported no findings against `graphmodules-6167eecc753d3a9eb84c`.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#readme): pin `git::https://github.com/satolap/terraform-msgraph-modules.git//modules/<path>?ref=graphmodules-d14d59c9000a035c39ba`.
