Microsoft Graph modules for v1.0 and beta, plus verified modules.

Version 0.5.0: the public version line restarts at 0.x. Versions 1.0.0 to 5.0.0 were published within days of each other, before anyone depended on them, and overstated the stability of these modules, so they were withdrawn. While the major version is 0, a breaking change bumps the minor version, a compatible addition bumps the minor version and a fix bumps the patch version: pin a patch-only constraint such as ~&gt; 0.5.0 to take only fixes, and read the migration notes before moving to a new minor version. 1.0.0 follows once the published stability criteria are met.

Withdrawn releases and tags: `v1.0.0`, `v2.0.0`, `v3.0.0`, `v4.0.0`, `v5.0.0`.

This release was compared with `v5.0.0`: its interface changes and migration notes below are relative to that release.

Summary:

- v1.0: 311 modules; 0 added, 0 removed, 232 renamed, 308 interface-changed.
- beta: 623 modules; 0 added, 0 removed, 491 renamed, 605 interface-changed.
- verified: 43 modules; 14 added, 14 removed, 16 interface-changed.
- Accepted breaking changes: 8818 in 961 modules, from 2 release decisions.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Preserve original Graph folder and input spelling in generated modules; publish with the verified-tree migration in the same release
  - Decision: `2026-10-28-generated-graph-casing.json`, approved by agent review (two independent reviews).
  - Accepted changes by kind: module_renamed: 723, replacement_changed: 6, variable_removed: 7347, variable_required: 625.
  - Accepted changes by catalog: v1.0: 2948, beta: 5753.
  - Migration notes: Generated module source paths and Graph-derived inputs now keep Microsoft Graph's original spelling. This change ships together with the verified-tree rename in the same release. Adopt both migrations together; no compatibility aliases are emitted. Every folder level takes the Graph route segment, for example identity-governance/entitlement-management/access-packages becomes identityGovernance/entitlementManagement/accessPackages and reports/daily-print-usage-by-user becomes reports/dailyPrintUsageByUser. Graph-derived arguments take the Graph property or URL-parameter spelling, for example black_and_white_page_count becomes blackAndWhitePageCount and user_id becomes user-id. Names that are not valid Terraform identifiers (such as @odata.type), reserved names and real collisions keep their existing argument name through an explicit Graph-to-input mapping, and generator controls and outputs keep their names. On Terraform 1.11 or later, update each caller's module source path and renamed arguments, keep module block labels and values unchanged, then run terraform init -upgrade and inspect a saved plan before applying. Resource addresses inside the modules are unchanged, so a source-path or argument rename needs no state move; the six replacement-trigger changes (groups, service-principals and subscriptions in v1.0 and beta) only follow the renamed inputs they reference. If you also rename a module block label, use a root moved block from module.old_label to module.new_label, or back up state and run terraform state mv with the exact instance addresses under exclusive backend access; do not do both. Download casing-migration.json and casing-migration.md from the release assets for generated and verified old and new paths, inputs and nested attributes; the JSON separates the mappings into generated and verified sections. This guidance does not establish provider or live Graph behavior for an upgrade.
  - Beta preview: 5753 accepted changes in beta modules, which are preview and may break in a minor release.
- Preserve Graph casing in verified module paths and inputs; publish with the generated-tree migration in the same release
  - Decision: `2026-10-29-verified-graph-casing.json`, approved by agent review (two independent reviews).
  - Accepted changes by kind: module_removed: 14, postcondition_changed: 1, precondition_changed: 11, replacement_changed: 9, validation_changed: 9, variable_removed: 40, variable_required: 24, variable_type_changed: 9.
  - Accepted changes by catalog: verified: 117.
  - Migration notes: Verified module folders and Graph-derived inputs now keep Microsoft Graph's spelling and case. The generated catalogs take Graph's folder and input casing in the same release. No compatibility aliases exist. 14 verified modules move: the folder levels identity-governance/entitlement-management, identity/conditional-access, role-management, directory/administrative-units and service-principals take their Graph route segments (identityGovernance/entitlementManagement, identity/conditionalAccess, roleManagement, directory/administrativeUnits, servicePrincipals), and each module that sat in one is removed under its old path and added under its new one (module_removed and module_added). Three hand mappings name folders that no Graph route segment names: catalogs/custom-extensions becomes catalogs/customWorkflowExtensions (the Graph collection catalogs/{accessPackageCatalog-id}/customWorkflowExtensions), the named-location modules become namedLocations/ipNamedLocation and namedLocations/countryNamedLocation (the Graph subtypes microsoft.graph.ipNamedLocation and microsoft.graph.countryNamedLocation), and role-management/directory/role-schedules becomes roleManagement/directory/roleSchedules (the module manages both roleAssignmentSchedules and roleEligibilitySchedules, which have no common Graph segment). Inputs that fill a top-level Graph property or a URL parameter take Graph's name in the modules whose path does not change (displayName, groupTypes, principalId, application-id, accessPackageCatalog-id; 40 removed and 24 required-added keys in these modules). The 14 moved modules rename their inputs by the same rule (for example ipNamedLocation display_name becomes displayName and is_trusted becomes isTrusted). In every module, an input that fills no top-level Graph property or URL parameter keeps its name. The renamed inputs reach conditions and replacement triggers through var references, so 12 precondition and postcondition findings and 7 replacement-trigger findings (plus the one for lifecycleWorkflows/workflows) are bound by digest: the conditions, messages and triggers are the same, only the input names in them changed. The snake_case attributes nested inside the object inputs of Graph-derived verified modules take the Graph property they fill: 90 attributes of 26 inputs in 11 modules are renamed (for example app_roles[*].display_name becomes displayName, tasks[*].is_enabled becomes isEnabled, users.include_users becomes includeUsers, questions[*].is_required becomes isRequired, logic_app.subscription_id becomes subscriptionId, callback.timeout becomes timeoutDuration) and 13 stay with a recorded reason because they fill no single Graph property name or are Terraform-only (content_base64, authentication_strength_id, persistent_browser_mode, scope_rule, approval_timeout_in_days, duration_days, member_id, range_type, extension_id, extension_type). In the six modules whose path does not move (applications, assignments, accessReviews/definitions, lifecycleWorkflows/customTaskExtensions, lifecycleWorkflows/workflows, termsOfUse/agreements) this shows as 9 variable_type_changed, 9 validation_changed and 2 replacement_changed keys (the assignments one is the update trigger, which keeps storing the previous release's schedule_update shape so the upgrade sends no second adminUpdate); the moved modules carry it inside module_removed and module_added. Request bodies are unchanged: the modules build the same Graph bodies from the new attribute names, so there is no plan change beyond the argument rename. Each affected object input also declares the old optional attribute names (typed optional(any)) and rejects any non-null value with a plan-time error that names the new attribute, so a caller who misses a rename cannot silently fall back to the default (for example a dropped is_approval_required_for_add or session-control flag would otherwise default off); the digests of the variable_type_changed and validation_changed keys include these guards. Update each caller's module source path and renamed arguments, keep module block labels and values unchanged, then run terraform init -upgrade and inspect a saved plan before applying. A module's resource addresses do not depend on its folder or input names, so a source or argument rename needs no state move and no moved block; if you also rename a module block label, use a root moved block from module.old_label to module.new_label, or back up state and run terraform state mv with the exact instance addresses under exclusive backend access, not both. The release asset .release/casing-migration.md (and .json) lists every old and new folder, every input rename and every nested attribute rename per module, and each module's variables.tf shows its new inputs.

While the major version is 0, breaking changes ship in minor releases: read these migration notes before taking a new minor version.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Every old and new module path and input of the casing migration is in the `casing-migration.json` and `casing-migration.md` release assets, listed in `SHA256SUMS`.

Verified modules:

- Added: `modules/verified/directory/administrativeUnits`, `modules/verified/identity/conditionalAccess/namedLocations/countryNamedLocation`, `modules/verified/identity/conditionalAccess/namedLocations/ipNamedLocation`, `modules/verified/identity/conditionalAccess/policies`, `modules/verified/identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes`, `modules/verified/identityGovernance/entitlementManagement/accessPackages`, `modules/verified/identityGovernance/entitlementManagement/assignmentPolicies`, `modules/verified/identityGovernance/entitlementManagement/catalogs/customWorkflowExtensions`, `modules/verified/identityGovernance/entitlementManagement/catalogs/resources`, `modules/verified/identityGovernance/entitlementManagement/catalogs`, `modules/verified/identityGovernance/entitlementManagement/connectedOrganizations`, `modules/verified/roleManagement/directory/roleSchedules`, `modules/verified/roleManagement/entitlementManagement/roleAssignments`, `modules/verified/servicePrincipals`.
- Removed: `modules/verified/directory/administrative-units`, `modules/verified/identity-governance/entitlement-management/access-packages/resource-role-scopes`, `modules/verified/identity-governance/entitlement-management/access-packages`, `modules/verified/identity-governance/entitlement-management/assignment-policies`, `modules/verified/identity-governance/entitlement-management/catalogs/custom-extensions`, `modules/verified/identity-governance/entitlement-management/catalogs/resources`, `modules/verified/identity-governance/entitlement-management/catalogs`, `modules/verified/identity-governance/entitlement-management/connected-organizations`, `modules/verified/identity/conditional-access/named-locations/countries`, `modules/verified/identity/conditional-access/named-locations/ip-ranges`, `modules/verified/identity/conditional-access/policies`, `modules/verified/role-management/directory/role-schedules`, `modules/verified/role-management/entitlement-management/role-assignments`, `modules/verified/service-principals`.
- Interface-changed:
  - `modules/verified/applications`: precondition_changed: 1, validation_changed: 1, variable_added: 1, variable_removed: 2, variable_required: 1, variable_type_changed: 1.
  - `modules/verified/applications/federatedIdentityCredentials`: replacement_changed: 1, variable_removed: 1, variable_required: 1.
  - `modules/verified/applications/passwordCredentials`: replacement_changed: 1, variable_removed: 1, variable_required: 1.
  - `modules/verified/groups`: postcondition_changed: 1, precondition_changed: 1, replacement_changed: 1, variable_added: 5, variable_removed: 7, variable_required: 2.
  - `modules/verified/groups/members`: variable_removed: 1, variable_required: 1.
  - `modules/verified/identityGovernance/accessReviews/definitions`: precondition_changed: 1, validation_changed: 1, variable_removed: 3, variable_required: 3, variable_type_changed: 1.
  - `modules/verified/identityGovernance/entitlementManagement/assignments`: replacement_changed: 1, validation_changed: 2, variable_type_changed: 2.
  - `modules/verified/identityGovernance/entitlementManagement/settings`: precondition_changed: 1, variable_added: 2, variable_removed: 2.
  - `modules/verified/identityGovernance/lifecycleWorkflows/customTaskExtensions`: precondition_changed: 1, validation_changed: 1, variable_removed: 1, variable_required: 1, variable_type_changed: 1.
  - `modules/verified/identityGovernance/lifecycleWorkflows/workflows`: precondition_changed: 1, replacement_changed: 1, validation_changed: 2, variable_added: 2, variable_removed: 3, variable_required: 1, variable_type_changed: 2.
  - `modules/verified/identityGovernance/privilegedAccess/group/assignmentScheduleRequests`: precondition_changed: 1, replacement_changed: 1, variable_removed: 3, variable_required: 3.
  - `modules/verified/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests`: precondition_changed: 1, replacement_changed: 1, variable_removed: 3, variable_required: 3.
  - `modules/verified/identityGovernance/termsOfUse/agreements`: precondition_changed: 1, validation_changed: 2, variable_added: 1, variable_removed: 2, variable_required: 1, variable_type_changed: 2.
  - `modules/verified/roleManagement/directory/roleAssignments`: precondition_changed: 1, replacement_changed: 1, variable_added: 1, variable_removed: 3, variable_required: 2.
  - `modules/verified/servicePrincipals/passwordCredentials`: replacement_changed: 1, variable_removed: 1, variable_required: 1.
  - `modules/verified/users`: precondition_changed: 1, variable_added: 4, variable_removed: 7, variable_required: 3.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `c15a287e8af2aca1ce31358055089d35f134b9ec`
- Microsoft Graph metadata commit: `1fd0ef510f79f3dadb3e083bdebc9496f939a11c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `7c27444c0650d00ecf51d9ba131315062d96896051351a97a1c0fa3b4282cf5b`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 311/311, contract_reviewed 6/311, lifecycle_verified 0/311
- beta: schema_validated 623/623, contract_reviewed 6/623, lifecycle_verified 0/623

Contract/interface and evidence changes found by the release gate against `v5.0.0`:

- module_added: 14 modules added to the catalog (notice).
- module_removed: 14 modules removed from the catalog (blocking).
- module_renamed: 723 modules moved to a new path that serves the same Graph endpoint (blocking).
- postcondition_changed: 1 module whose resource or data source postconditions were added or changed (blocking).
- precondition_changed: 11 modules whose resource or data source lifecycle preconditions were added, removed or changed (blocking).
- replacement_changed: 15 modules whose replace_triggered_by triggers, the terraform_data values they reference, or their transitive local expressions changed, so a different set of input changes now replaces the object instead of updating it in place (blocking).
- validation_changed: 9 inputs with a new or changed validation that may reject values accepted before (blocking).
- variable_added: 6738 inputs added with a default, so existing configurations still plan (notice).
- variable_removed: 7387 inputs removed; setting a removed input fails at plan time (blocking).
- variable_required: 649 inputs that callers must now set: added without a default, or with the default removed (blocking).
- variable_type_changed: 9 inputs whose Terraform type changed (blocking).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#readme): use `source = "satolap/modules/msgraph//<path>"` with `version = "0.5.0"`.
