Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1410 modules; 0 added, 0 removed, 0 interface-changed.
- beta: 2399 modules; 0 added, 0 removed, 0 interface-changed.
- curated: 13 modules; 0 added, 0 removed, 0 interface-changed.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Microsoft Graph upstream:

- Microsoft Graph metadata commits: [`7b2914c8ad13...a2c1bebf415c`](https://github.com/microsoftgraph/msgraph-metadata/compare/7b2914c8ad1340129f52aa785f13c074cb46fd7c...a2c1bebf415c76589e5ad765d5c429134c1ffc81).
- Microsoft Graph documentation commit unchanged: `4ad99fd37a9e`.
- No new changelog entries.
- Entries are production-cloud changelog entries added between the two documentation commits. Details are in [Microsoft's changelog](https://learn.microsoft.com/graph/changelog).

Provenance:

- Generator commit: `c7ce616274d7599daab9ba54e131f9b2939a93e5`
- Microsoft Graph metadata commit: `a2c1bebf415c76589e5ad765d5c429134c1ffc81`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `23d890654ff0004072efa2e7740dd5c5a2d777c0593e410536d68ff01e48b8d8`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1410/1410, contract_reviewed 6/1410, lifecycle_verified 0/1410
- beta: schema_validated 2399/2399, contract_reviewed 6/2399, lifecycle_verified 0/2399

Contract/interface and evidence changes: none. The release gate reported no findings against `graphmodules-2a06155127be2da9de94`.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/benhaspalace/GraphModules#readme): pin `git::https://github.com/benhaspalace/GraphModules.git//modules/<path>?ref=graphmodules-23d890654ff0004072ef`.
