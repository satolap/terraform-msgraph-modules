Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1430 modules; 0 added, 0 removed, 0 interface-changed.
- beta: 2479 modules; 0 added, 0 removed, 0 interface-changed.
- curated: 12 modules; 0 added, 0 removed, 0 interface-changed.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Provenance:

- Generator commit: `8d477695e81a46f900672968927bbc01c5ea4b1c`
- Microsoft Graph metadata commit: `7b2914c8ad1340129f52aa785f13c074cb46fd7c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `ef8abfd72f69d722705cee8a594aedf157b0101ea297412e0e369e6890b53c87`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1430/1430, contract_reviewed 6/1430, lifecycle_verified 0/1430
- beta: schema_validated 2479/2479, contract_reviewed 6/2479, lifecycle_verified 0/2479

Contract/interface and evidence changes: none. The release gate reported no findings against `graphmodules-763ef257f598c31191e1`.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/benhaspalace/GraphModules#readme): pin `git::https://github.com/benhaspalace/GraphModules.git//modules/<path>?ref=graphmodules-ef8abfd72f69d722705c`.
