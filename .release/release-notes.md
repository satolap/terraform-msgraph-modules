Microsoft Graph modules for v1.0 and beta, plus verified modules.

Summary:

- v1.0: 319 modules; 0 added, 1092 removed, 319 interface-changed.
- beta: 632 modules; 0 added, 1768 removed, 632 interface-changed.
- verified: 27 modules; 10 added, 0 removed, 17 interface-changed.
- Accepted breaking changes: 3847 in 3828 modules, from 7 release decisions.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Add emergency-access guards, a custom directory-role definition module and PIM Microsoft Entra role schedules
  - Decision: `2026-10-18-emergency-access-guard.json`, approved by benhaspalace.
  - Accepted changes by kind: inventory_shift: 1.
  - Accepted changes by catalog: without a module path: 1.
  - Migration notes: Existing module paths and Graph objects are unchanged. The three guard modules create no tenant objects or assignments. The authorization-policy, admin-consent-workflow and authentication-methods modules (#314, #315, #316) create no objects but update existing tenant policy singletons. Adoption requires existing known-at-plan emergency-account/group IDs, an explicit free/p1/p2 tier and the documented read permissions. The default requires two enabled cloud-only Member accounts; an explicit minimum_accounts=1 does not meet Microsoft's recommended redundancy. Optional groups are discovery inputs with static membership and only user members. Conditional Access outputs contain only the validated resolved user snapshot and no group IDs, including for role-assignable groups; later refresh/apply membership changes require a reviewed expected_group_member_ids set or trusted/reviewed source and plan. Consume the guard outputs so dependent policies wait for its checks; treat identifier outputs, state, saved plans and provider logs as private. When policy writers retain known IDs, explicitly depend the verifier module on those writers so its read follows their changes. Feed every baseline policy ID to the separate verifier; tenant mode supports user policies and explicitly refuses checked workload-identity policies. Free tier leaves security defaults on and performs no Conditional Access verification. Subscription capacity checks and configured exclusions do not certify per-user licensing, credential custody, permanent emergency roles, MFA, alerts, successful emergency sign-in, effective Conditional Access or destroy behavior. Complete the separately tracked live/operational acceptance before enforcement. This decision accepts only the verified inventory growth from 17 to 27 for v2.0.0; the entitlement lifecycle changes are accepted by their own v2.0.0 decision, and the live release evidence requirements still apply. The roleManagement/directory/roleDefinitions module creates only new custom definitions, uses Graph-original casing and requires Microsoft Entra ID P1/P2 plus the documented authorization. It creates no assignment or PIM schedule and offers no import/adoption migration. Review exact allowedResourceActions and any future assignment scope, especially broad actions or policy-qualified consent delegation. Changing templateId is a conservative replacement policy; remove dependent assignments first and plan for access interruption. Normal destroy soft-deletes rather than purges; retained definitions, template reuse and permanent removal require separate live evidence. A null description omits without clearing. The provider constraint admits the reviewed 0.6 minor line; offline execution uses 0.6.0, and calling roots must lock their provider selections. No live lifecycle, effective authorization or permanent-cleanup claim is included. The role-management/directory/role-schedules module is additive: it creates PIM eligible or active Microsoft Entra role assignments through immutable adminAssign requests, reads the schedule back, and on destroy submits a guarded adminRemove for the configured principal, role and scope, whoever created that assignment; it changes no existing module path, input or Graph object. It requires Microsoft Entra ID P2 or Microsoft Entra ID Governance for the principals and approvers of the roles it assigns, and the documented role-management permissions. Users and role-assignable groups support the documented assignment kinds; service principals are limited to time-bound active assignments, and eligible or permanent service-principal assignments are not supported. The caller must establish the principal type, because GUID validation performs no type lookup. Role settings in PIM can reject a request. An accepted request whose response was lost requires operator reconciliation. Mocked tests do not establish tenant success, removal or expiry semantics, future-start visibility or live permissions; live PIM acceptance is tracked separately. Owner approval, given in chat on 2026-10-20: "Approve 22→23". It approves binding the verified inventory change from 22 to 23 modules, the module added by the PIM role schedules change, to v2.0.0. Owner approval, given in chat on 2026-10-22: "Approve per batch". It approves binding the verified inventory change from 23 to 26 modules, the three modules added by the batch of #314 (authorization-policy), #315 (admin-consent-workflow) and #316 (authentication-methods), to v2.0.0; with #313, which adds none, the batch is the four pull requests #313, #314, #315 and #316. Owner approval, given in chat on 2026-10-22: "Approve per batch". It approves binding the verified inventory change from 26 to 27 modules, the module added by #318 (conditional-access-p1, security-baseline), to v2.0.0, so the bound inventory change is 17 to 27 modules. The bound digest covers the gate's detail "17 -&gt; 27 modules" against the published v2.0.0.
- Stop publishing two service-owned security collections whose documented methods do not establish a CRUD lifecycle
  - Decision: `2026-10-18-security-update-only.json`, approved by benhaspalace.
  - Accepted changes by kind: module_removed: 2.
  - Accepted changes by catalog: v1.0: 2.
  - Migration notes: The v1.0/security/incidents and v1.0/security/secure-score-control-profiles modules are no longer published. Microsoft Learn documents list/get/update of service-owned objects, without ordinary collection POST or item DELETE lifecycles. alerts_v2 was already excluded and is not another module removal. No verified replacement module is provided. Before upgrading, back up the caller state and stop managing each affected object without deleting it: on Terraform &gt;= 1.7 replace the caller module block with removed { from = module.&lt;actual_caller_address&gt; lifecycle { destroy = false } }, review a plan that only releases the intended state, and apply it before upgrading. Alternatively, review terraform state rm for the exact affected module/resource addresses and remove their configuration. Removing configuration alone can plan destruction. These steps release Terraform ownership and must preserve the service-owned incident or control profile in Microsoft Graph.
- Accept the exact owner-reviewed documented-lifecycle catalog removals and two inventory shifts against v2.0.0
  - Decision: `2026-10-18-v2-documented-lifecycle-removals.json`, approved by benhaspalace.
  - Accepted changes by kind: inventory_shift: 2, module_removed: 2858.
  - Accepted changes by catalog: v1.0: 1090, beta: 1768, without a module path: 2.
  - Migration notes: Owner explicitly approved these exact 2,858 generated-module removals and two inventory shifts after reviewing their scope; no merge, publication, tenant action or broader acceptance is authorized. This decision binds only the keys and detail hashes listed below, from interface report SHA256 4070cdcad6bcde5b7ffe7ac8bfbfa1a4420422f5fa8d5365086056f8e1b2649e. The v1.0 catalog changes from 1,411 to 319 modules and beta from 2,400 to 632. All listed removals follow the pinned documented-lifecycle admission rule; missing indexed POST or DELETE evidence is not proof that the service operation is unsupported. No replacement modules or automatic caller migration are supplied. For EACH exact module_removed key below, strip module_removed: and the leading generated/ prefix to obtain the published module path: generated/v1.0/&lt;route&gt; maps to the caller source suffix //v1.0/&lt;route&gt;, and generated/beta/&lt;route&gt; maps to //beta/&lt;route&gt;. Identify every consuming root configuration using that published path, then map each affected caller module to its actual module and resource state addresses, including nested or repeated instances; repository catalog paths and published source paths are not Terraform state addresses. Before upgrading that caller, back up and securely retain its state. On Terraform &gt;= 1.7 replace each affected module configuration with a removed block using its actual caller address and lifecycle { destroy = false }; review a saved plan that releases only the intended state and does not delete or replace Microsoft Graph objects, then apply that reviewed migration before upgrading. Alternatively, review terraform state rm for the exact affected module/resource addresses and remove their configuration. Do not run generic or guessed state commands. Removing configuration alone can plan destruction. These per-caller actions release Terraform ownership while preserving the service objects; leave unrelated managed resources intact. Account for outputs and dependencies on removed modules before planning, and retain the migration record and state backup. Inventory-shift acceptance records these exact catalog counts only; it grants no additional module removal or lifecycle change. The four verified entitlement-management changes are covered by a separate exact decision. Offline interface checks and this approval do not establish live lifecycle behavior, full generated Terraform validation, transport correctness, or runtime evidence.
- Carry forward four unchanged entitlement-management lifecycle decisions to the v2.0.0 publication baseline
  - Decision: `2026-10-18-v2-entitlement-lifecycle.json`, approved by benhaspalace.
  - Accepted changes by kind: postcondition_changed: 1, precondition_changed: 2, replacement_changed: 1.
  - Accepted changes by catalog: verified: 4.
  - Migration notes: This decision accepts only the four exact lifecycle findings previously reviewed against v1.0.0/v1.1.0, now observed against published v2.0.0. It does not approve other generated catalog changes, inventory changes, tenant operations, publication or release. Existing calling modules must follow the migration guidance below; offline validation does not prove tenant lifecycle behavior. verified/identity-governance/entitlement-management/assignment-policies now replaces the assignment policy when access_package_id changes, because Microsoft Learn documents the accessPackage relationship of an accessPackageAssignmentPolicy as read-only (https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentpolicy?view=graph-rest-1.0#relationships). The update (https://learn.microsoft.com/en-us/graph/api/accesspackageassignmentpolicy-update?view=graph-rest-1.0) is a full-body PUT whose body must carry accessPackage.id, and Learn does not say that it can move a policy to another access package. Before this release such a change planned an in-place PUT naming the new package. This also applies when the access package is itself replaced, for example when its catalog changes: the policy follows the new package id. The new policy is created before the old one is deleted and has a new id. Existing assignments stay with the old policy and the old access package and are not moved; Learn says to remove all assignments before deleting a policy, so Microsoft Graph may refuse to delete a policy that still has assignments. The apply then fails after the new policy is created, and Terraform keeps the old policy as a deposed object that every later apply tries to delete again; remove those assignments and have the users request the new package. Because the policy is created first, Terraform also creates first any resource it refers to whenever that resource is replaced, such as a group named as a target, approver or reviewer, as the conditional access policy module already does; where the old and new object cannot exist together, such as two Microsoft 365 groups with the same mail nickname, give the new object another unique value or remove the reference from the policy first. Terraform updates the replacement trigger before it replaces the policy, so an apply that fails after that update and before the new policy exists, for example because Graph refuses to create it, leaves the trigger ahead of the policy. The module now ignores changes to body.accessPackage, so an update never sends another access package, and a new postcondition fails the next plan with the policy id and both package ids instead of letting it look complete; plan and apply with -replace set to the module's msgraph_resource.assignment_policy to finish the replacement. access_package_id is compared in lower case, so a change of letter case alone keeps the policy and sends no request. The module adds terraform_data.immutable, which makes no API call. Upgrading with unchanged inputs plans only its creation and does not replace the policy, which a mocked upgrade test from the state of the previous release checks; change access_package_id in a later apply. These changes are covered by mocked tests only, not by a live tenant. The catalog resource module (verified/identity-governance/entitlement-management/catalogs/resources) and the resource role scope module (verified/identity-governance/entitlement-management/access-packages/resource-role-scopes) accept resource_origin_system = "AzureResources", so an access package can grant Azure RBAC roles. No caller needs to change anything: for AadGroup, AadApplication and SharePointOnline both modules send byte-identical request bodies and keep their destroy hooks unchanged, so the first plan after the upgrade shows no change. The catalog resource module adds a subscription (/subscriptions/&lt;GUID&gt;) or a management group (/providers/Microsoft.Management/managementGroups/&lt;ID&gt;) with the matching resourceType; its new precondition refuses any other Azure ID, such as a resource group, and is always true for the other origin systems. The resource role scope module adds the optional inputs role_definition_id and role_type (active or eligible) and the output available_scopes. For Azure roles it reads the catalog resource and its scopes instead of the resourceRoles list, which Microsoft Graph does not support for Azure resources, and grants the role at the root scope or at a resource group that Graph lists for the subscription. Its existing role-match precondition now applies only to the other origin systems, and four new preconditions check the Azure inputs; for an existing caller they hold, because role_type and role_definition_id default to null. The data source that lists roles now has count = 1 for the other origin systems, which changes only its address in plan output. Azure resource roles need Microsoft Entra ID Governance or Microsoft Entra Suite, and the identity that adds a subscription or management group needs Azure RBAC permission to manage role assignments there. Verified with mocked providers and read-only queries in a licensed tenant; the module's own create and destroy for Azure roles are not yet verified live.
- Add optional naming preconditions to eleven verified modules (#126)
  - Decision: `2026-10-19-verified-name-pattern.json`, approved by benhaspalace.
  - Accepted changes by kind: precondition_changed: 11.
  - Accepted changes by catalog: verified: 11.
  - Migration notes: Both name_pattern and mail_nickname_pattern default to null, so existing callers keep their current naming behavior. No Graph property casing, resource names, request bodies, replacement semantics, or custom-extension behavior changes. To opt in, pass an RE2 expression; matching is unanchored unless the caller supplies anchors. A mismatch fails the resource plan with the input value and pattern; malformed RE2 fails variable validation. Groups and users validate display_name and mail_nickname with distinct patterns. Conditional Access checks display_name exactly as supplied; explicitly allow the ENABLE IN EMERGENCY prefix in a convention that uses contingency policies. No state migration or object replacement is introduced by this change.
- Raise the minimum supported Terraform version to 1.11.0 for every published module
  - Decision: `2026-10-20-terraform-1-11-floor.json`, approved by benhaspalace.
  - Accepted changes by kind: terraform_version_raised: 968.
  - Accepted changes by catalog: v1.0: 319, beta: 632, verified: 17.
  - Migration notes: Every published module now declares required_version &gt;= 1.11.0 (generated modules &gt;= 1.11.0, &lt; 2.0.0). Terraform 1.5 to 1.10 refuses to initialise a root module that calls one of them, so upgrade Terraform to 1.11.0 or later before taking this release, or keep pinning the previous release. Module inputs, outputs, state addresses and provider requirements do not change, so no state migration is needed.
- Add an optional scoped_role_members input to the administrative-units module
  - Decision: `2026-10-22-administrative-units-scoped-role-member-trigger.json`, approved by benhaspalace.
  - Accepted changes by kind: replacement_changed: 1.
  - Accepted changes by catalog: verified: 1.
  - Migration notes: The replacement trigger on verified/directory/administrative-units applies only to the new optional scoped_role_members input (default empty), so existing callers are unaffected and no existing plan changes. Changing a role/member pair in scoped_role_members replaces that assignment, because Microsoft Graph documents no update for scoped role members. This decision accepts only that one replacement-trigger finding; all other release blockers and evidence requirements remain unresolved. Owner approval, given in chat on 2026-10-22: "Approve the finding". It approves binding the replacement_changed finding for verified/directory/administrative-units (detail "replacement triggers: 1 added, 0 removed, 0 changed") to v2.0.0.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Verified modules:

- Added: `modules/verified/role-management/directory/role-schedules`, `modules/verified/role-management/entitlement-management/role-assignments`, `modules/verified/roleManagement/directory/roleDefinitions`, `modules/verified/security-baseline/admin-consent-workflow`, `modules/verified/security-baseline/authentication-methods`, `modules/verified/security-baseline/authorization-policy`, `modules/verified/security-baseline/conditional-access-p1`, `modules/verified/security-baseline/emergency-access-guard/verify`, `modules/verified/security-baseline/emergency-access-guard`, `modules/verified/security-baseline/licence-guard`.
- Interface-changed:
  - `modules/verified/applications`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/directory/administrative-units`: output_added: 1, precondition_changed: 1, replacement_changed: 1, terraform_version_raised: 1, variable_added: 2.
  - `modules/verified/groups`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 2.
  - `modules/verified/groups/members`: terraform_version_raised: 1.
  - `modules/verified/identity-governance/entitlement-management/access-packages`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/identity-governance/entitlement-management/access-packages/resource-role-scopes`: output_added: 1, precondition_changed: 1, terraform_version_raised: 1, validation_relaxed: 1, variable_added: 2.
  - `modules/verified/identity-governance/entitlement-management/assignment-policies`: postcondition_changed: 1, precondition_changed: 1, replacement_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs/custom-extensions`: terraform_version_raised: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs/resources`: precondition_changed: 1, terraform_version_raised: 1, validation_relaxed: 1.
  - `modules/verified/identity-governance/entitlement-management/connected-organizations`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/identity/conditional-access/named-locations/countries`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/identity/conditional-access/named-locations/ip-ranges`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/identity/conditional-access/policies`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 1.
  - `modules/verified/naming`: terraform_version_raised: 1.
  - `modules/verified/service-principals`: terraform_version_raised: 1.
  - `modules/verified/users`: precondition_changed: 1, terraform_version_raised: 1, variable_added: 2.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Microsoft Graph upstream:

- Microsoft Graph metadata commits: [`fd42f0e5bcd9...34b8e9c29032`](https://github.com/microsoftgraph/msgraph-metadata/compare/fd42f0e5bcd96b0c5edd5e62e2956a1dc1c5d17a...34b8e9c29032c82352a6fd7138be0a864a842bb2).
- Microsoft Graph documentation commits: [`56602fde3f98...98a98cc88051`](https://github.com/microsoftgraph/microsoft-graph-docs-contrib/compare/56602fde3f9889e14ac89916234200ab881feb33...98a98cc88051a857c119a2e1bb61587633585284).
- New changelog entries by version and change type: v1.0: Addition 10, Update 2; beta: Addition 116, Change 12, Deletion 43.
- Deletion, Deprecation, Change and Removal entries:
  - beta Change: `apiUsageReportMetrics` in `sharePointReportSettings`
  - beta Change: `disableApiUsageReport` in `sharePointReportSettings`
  - beta Change: `enableApiUsageReport` in `sharePointReportSettings`
  - beta Change: `getSharePointApiUsage` in `reportRoot`
  - beta Change: `id` in `cloudPcSourceDeviceImage`
  - beta Change: `offer` in `cloudPcGalleryImage`
  - beta Change: `offerDisplayName` in `cloudPcGalleryImage`
  - beta Change: `publisher` in `cloudPcGalleryImage`
  - beta Change: `recommendedSku` in `cloudPcGalleryImage`
  - beta Change: `sku` in `cloudPcGalleryImage`
  - beta Change: `skuDisplayName` in `cloudPcGalleryImage`
  - beta Change: `statusDetails` in `cloudPcDeviceImage`
  - beta Deletion: `Org.OData.Core.V1.Revisions` in `accessDriftDetail`
  - beta Deletion: `Org.OData.Core.V1.Revisions` in `accessDriftReport`
  - beta Deletion: `Org.OData.Core.V1.Revisions` in `accessDriftReportResourceType`
  - beta Deletion: `Org.OData.Core.V1.Revisions` in `accessDriftSummary`
  - beta Deletion: `Org.OData.Core.V1.Revisions` in `accessDriftType`
  - beta Deletion: `Org.OData.Core.V1.Revisions` in `downloadFile`
  - beta Deletion: `Org.OData.Core.V1.Revisions` in `generateDownloadUri`
  - beta Deletion: `accessDriftReport` in `insightRoot`
  - beta Deletion: `accessDriftSummary` in `insightRoot`
  - beta Deletion: `accessPackageIdentifier` in `accessDriftDetail`
  - beta Deletion: `accessPackageName` in `accessDriftDetail`
  - beta Deletion: `archiveSizeTooLarge` in `evaluationErrorType`
  - beta Deletion: `archiveTextExtractionError` in `evaluationErrorType`
  - 29 more in Microsoft's changelog.
- Entries are production-cloud changelog entries added between the two documentation commits. Details are in [Microsoft's changelog](https://learn.microsoft.com/graph/changelog).

Provenance:

- Generator commit: `080e653afe19f02da075681bc7ff2c8a1773a133`
- Microsoft Graph metadata commit: `34b8e9c29032c82352a6fd7138be0a864a842bb2`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `e9e7b7662970789a33e8053be3785e203edd0155fdbe523dc43466d3620d469a`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 319/319, contract_reviewed 6/319, lifecycle_verified 0/319
- beta: schema_validated 632/632, contract_reviewed 6/632, lifecycle_verified 0/632

Contract/interface and evidence changes found by the release gate against `v2.0.0`:

- inventory_shift: 3 catalogs whose module count grew or shrank by more than the gate's shift threshold, 10 percent by default (blocking).
- module_added: 10 modules added to the catalog (notice).
- module_removed: 2860 modules removed from the catalog (blocking).
- output_added: 2 outputs added (notice).
- postcondition_changed: 1 module whose resource or data source postconditions were added or changed (blocking).
- precondition_changed: 13 modules whose resource or data source lifecycle preconditions were added, removed or changed (blocking).
- replacement_changed: 2 modules whose replace_triggered_by triggers, the terraform_data values they reference, or their transitive local expressions changed, so a different set of input changes now replaces the object instead of updating it in place (blocking).
- terraform_version_raised: 968 modules whose Terraform core required_version now rejects a Terraform version that the previous release accepted (blocking).
- validation_relaxed: 2 inputs whose validation changed but provably still accepts every value accepted before (notice).
- variable_added: 16 inputs added with a default, so existing configurations still plan (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#readme): use `source = "satolap/modules/msgraph//<path>"` with `version = "3.0.0"`.
