Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1410 modules; 0 added, 0 removed, 0 interface-changed.
- beta: 2399 modules; 0 added, 0 removed, 0 interface-changed.
- curated: 13 modules; 1 added, 0 removed, 1 interface-changed.
- Accepted breaking changes: 2 in 1 module, from 1 release decision.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Assignment policies always send their custom extension bindings, read them back, and warn about bindings that the next apply would remove
  - Decision: `2026-10-01-assignment-policy-custom-extensions.json`, approved by benhaspalace.
  - Accepted changes by kind: check_changed: 1, precondition_changed: 1.
  - Accepted changes by catalog: curated: 2.
  - Migration notes: The assignment policy module (modules/curated/identity-governance/entitlement-management/assignment-policies) now sends customExtensionStageSettings on every apply, and it is authoritative over the custom extension bindings of every policy it manages. The new input custom_extension_stage_settings defaults to [], so with no input the next apply removes custom extension bindings that were configured outside Terraform, in the portal or by another tool, which stops their Logic Apps from being called for that policy. Before upgrading, read the bindings of each policy the module manages with GET /identityGovernance/entitlementManagement/assignmentPolicies/{id}?$expand=customExtensionStageSettings($expand=customExtension) and declare each one in custom_extension_stage_settings as { stage, extension_id, extension_type }, where extension_id is customExtension.id and extension_type is request_workflow for #microsoft.graph.accessPackageAssignmentRequestWorkflowExtension or assignment_workflow for #microsoft.graph.accessPackageAssignmentWorkflowExtension. The first plan after upgrading shows an in-place update of every policy the module manages, because the request body changes, and the policy is also read with the expand from then on. When the server has a different number of bindings than the configuration declares, the plan diff of that policy can print the expanded extension objects, including their endpoint configuration, so review the first plan before sharing its output. The new check undeclared_custom_extension_bindings warns, per policy, about each binding on the server that the next apply would remove because it is not declared; it reads the policy once per plan, so it cannot warn before the policy exists. Apply only when no policy warns. The new input is validated: a documented stage (not unknownFutureValue), request stages with request_workflow and expiration stages with assignment_workflow, each stage at most once, and GUID extension ids. Three new preconditions can fail plans that declare bindings: an expiration stage needs expiration.type other than noExpiration, the access package read must return its catalog, and every extension_id must be in the catalog of the access package. For those guards the module reads the access package and lists the catalog's custom extensions, only when bindings are declared, so a policy without bindings makes no extra request. The new check guest_custom_extension_prerequisite warns when bindings are declared for a policy whose allowed_target_scope can include guests or external users; such a policy needs the tenant linked to an Azure subscription for Microsoft Entra ID Governance for guests, and each successful request is billed. The new output custom_extension_stage_settings returns the bindings Microsoft Graph reported as { stage, extension_id }, or null when the read returned none. Because the new checks read the policy back, a terraform test run with command = plan that creates a policy through this module now fails with 'Check block assertion known after apply', and expect_failures cannot name a check inside a module; run it with command = apply, or on Terraform 1.7 or later add an override_module block for the module. Verified with mocked providers only; not verified in a licensed tenant.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Curated modules:

- Added: `modules/curated/identity-governance/entitlement-management/catalogs/custom-extensions`.
- Interface-changed:
  - `modules/curated/identity-governance/entitlement-management/assignment-policies`: check_changed: 1, output_added: 1, precondition_changed: 1, variable_added: 1.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `c7ce616274d7599daab9ba54e131f9b2939a93e5`
- Microsoft Graph metadata commit: `7b2914c8ad1340129f52aa785f13c074cb46fd7c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `2a06155127be2da9de94e64bb74e448848dca43850d581fcb0abde6617f2d1fe`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1410/1410, contract_reviewed 6/1410, lifecycle_verified 0/1410
- beta: schema_validated 2399/2399, contract_reviewed 6/2399, lifecycle_verified 0/2399

Contract/interface and evidence changes found by the release gate against `graphmodules-59a4cae78d14be98f105`:

- check_changed: 1 module whose check blocks, assertions or check data sources were added or changed (blocking).
- module_added: 1 module added to the catalog (notice).
- output_added: 1 output added (notice).
- precondition_changed: 1 module whose resource or data source lifecycle preconditions were added, removed or changed (blocking).
- variable_added: 1 input added with a default, so existing configurations still plan (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/benhaspalace/GraphModules#readme): pin `git::https://github.com/benhaspalace/GraphModules.git//modules/<path>?ref=graphmodules-2a06155127be2da9de94`.
