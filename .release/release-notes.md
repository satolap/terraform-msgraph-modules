Microsoft Graph modules for v1.0 and beta, plus verified modules.

Summary:

- v1.0: 320 modules; 1 added, 0 removed, 319 interface-changed.
- beta: 633 modules; 1 added, 0 removed, 632 interface-changed.
- verified: 42 modules; 15 added, 0 removed, 7 interface-changed.
- Accepted breaking changes: 1208 in 471 modules, from 9 release decisions.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Refuse a change of mail_enabled or of the Unified group type on an existing verified group, and fail the apply when Graph returns different values
  - Decision: `2026-10-25-groups-mail-settings-fixed-at-creation.json`, approved by benhaspalace.
  - Accepted changes by kind: postcondition_changed: 1, precondition_changed: 1, replacement_changed: 1.
  - Accepted changes by catalog: verified: 3.
  - Migration notes: verified/groups no longer sends a PATCH for mail_enabled or for adding or removing "Unified" in group_types: Microsoft Learn's update group page does not list mailEnabled or groupTypes as updatable and documents no conversion between a security group and a Microsoft 365 group (https://learn.microsoft.com/en-us/graph/api/group-update). Before this release such a change planned an in-place update that Graph may refuse or ignore. Now the plan fails with a precondition error and the group, its members and its references stay untouched; to convert, create a new group with the other setting and move members and references. Adding or removing "DynamicMembership" with membership_rule remains an in-place update. The module adds terraform_data.created, which makes no API call, records the creation-time mail_enabled and Unified flag, and is replaced together with terraform_data.immutable; it is named in replace_triggered_by only so that the declaration can say the values are kept from creation, and it adds no replacement of its own. For a group created before this release or imported, the record is taken from the first plan, so upgrade first with unchanged mail_enabled and group_types, and change them in a later apply; a conversion made in that first plan is not refused by the preconditions, but two new postconditions compare the mailEnabled and groupTypes values that Graph returns with the configuration and fail the apply when they differ or are missing. The module now exports mailEnabled and groupTypes from the response for that comparison. A configuration that sets a mail_enabled or Unified value different from the stored group fails the plan where the apply silently kept or failed before. The behavior is documentation-based; no live run has confirmed what Graph does with a PATCH of these properties (GB-directory-objects-519, GB-directory-objects-520). Owner approval, given in chat on 2026-10-26: "Do these for me" and "Do it", in reply to the request to approve this decision for v3.0.0; it accepts the precondition, postcondition and replacement-trigger findings for verified/groups listed here.
- Refuse a passkey campaign whose target group is excluded from passkeys
  - Decision: `2026-10-26-authentication-methods-passkey-campaign-guard.json`, approved by benhaspalace.
  - Accepted changes by kind: precondition_changed: 1.
  - Accepted changes by catalog: verified: 1.
  - Migration notes: verified/security-baseline/authentication-methods adds one lifecycle precondition: with campaign_method = "fido2" and the policy not restored from the snapshot, the plan fails when campaign_include_group_id is also listed in fido2_exclude_group_ids. Users excluded from the passkey (FIDO2) method cannot register it, so such a campaign would prompt every target user for a method they are denied; the configuration never worked. To fix a failing plan, remove the group from fido2_exclude_group_ids or target another group. Configurations that do not combine the two are unaffected and plan no change. Owner decision, given in chat on 2026-10-26: accept this precondition for the next release.
- Tighten enum inputs and required nested role-permission attributes
  - Decision: `2026-10-26-enum-hygiene-nested-required.json`, approved by benhaspalace.
  - Accepted changes by kind: validation_changed: 1164, variable_type_changed: 2.
  - Accepted changes by catalog: v1.0: 389, beta: 777.
  - Migration notes: Enum inputs reject unknownFutureValue, the evolvable-enum placeholder; replace it with an accepted concrete member. Members declared after that sentinel, such as mover and extensibility in the lifecycle workflow and task categories and linux in the Conditional Access device platform, remain refused until a reviewed live probe establishes write and provider refresh/readback behavior and explicitly permits that member for the relevant API version. A member declared before the sentinel stays accepted, for example linux in the federation system_browser_enabled_on input. No post-sentinel member is probed in this change. Typed nested enum attributes, list elements and dictionary values now follow the same accepted-member and comma-separated flags rules as scalar enum inputs, including enums without a sentinel; correct values that older modules left unchecked. Optional null parents and optional null attributes remain allowed. Every role_permissions item in generated/v1.0/role-management/directory/role-definitions must now include a non-null allowedResourceActions list; supplying an item without it or with null fails validation or planning. The same rules apply to the generated beta catalog, including the required non-null allowedResourceActions in every role_permissions item of generated/beta/role-management/directory/role-definitions. Run terraform validate and terraform plan before upgrading. These exact bound findings cover input validations and nested requiredness, not unrelated source/catalog drift or publication changes. Owner decision, given in chat on 2026-10-27: extend this decision to the 777 beta and 4 further v1.0 findings that release run 40501437976 reported for the same change, approved by benhaspalace.
- Replace generated groups and service principals when a create-only input changes, and refuse invalid role-assignable group combinations
  - Decision: `2026-10-26-generated-groups-service-principals-immutables.json`, approved by benhaspalace.
  - Accepted changes by kind: precondition_changed: 2, replacement_changed: 4.
  - Accepted changes by catalog: v1.0: 3, beta: 3.
  - Migration notes: The generated groups modules (v1.0 and beta) now replace the group when isAssignableToRole changes, through a terraform_data.immutable replacement trigger: Microsoft Graph sets isAssignableToRole only at creation. They also add three lifecycle preconditions for a role-assignable group: no DynamicMembership in group_types, security_enabled = true, and visibility Private or unset. Each combination is one Microsoft Graph rejects, and because a replacement deletes the old group before the new one is created, the plan must stop first. The generated service principals modules (v1.0 and beta) now replace the service principal when app_id changes to a different application ID (compared lower-cased, so a change of case keeps it), because Graph cannot update appId. These are the rules the verified groups and service-principals modules already follow. Terraform plans a destroy and then a create: the new object has a new object ID, and anything that stored the old ID must read it again. Upgrading with unchanged inputs plans only the creation of terraform_data.immutable; Terraform does not replace in the apply that creates it, so upgrade first and change these inputs in a later apply. Owner decision, given in chat on 2026-10-26: accept these six findings for the next release.
- Add an opt-in clear_properties sidecar to generated users and guard conditional-access policies against a replication-error echo
  - Decision: `2026-10-26-generated-users-clear-sidecar-and-ca-replication-guard.json`, approved by benhaspalace.
  - Accepted changes by kind: precondition_changed: 3, replacement_changed: 2.
  - Accepted changes by catalog: v1.0: 3, beta: 2.
  - Migration notes: The generated users modules (v1.0 and beta) gain an optional clear_properties input (default empty) and a separate msgraph_update_resource that PATCHes the listed properties to null. Its precondition requires that a listed property is not also set through a typed input or additional_properties, and its replacement trigger re-creates the clearing request when the user is replaced. Both act only when clear_properties is set, so existing configurations plan no change. The generated v1.0 conditional-access policies module adds a precondition refusing a request body that contains the text of the reviewed named-location replication error, because the provider would otherwise retry a successful response that echoes it; no valid policy contains that text. Owner decision, given in chat on 2026-10-26: accept these five findings for the next release.
- Follow Microsoft Graph metadata additions: new optional nested attributes and newly read-only additional_properties keys
  - Decision: `2026-10-26-metadata-1fd0ef5-schema-additions.json`, approved by benhaspalace.
  - Accepted changes by kind: validation_changed: 2, variable_type_changed: 11.
  - Accepted changes by catalog: v1.0: 1, beta: 12.
  - Migration notes: The pinned Microsoft Graph metadata moved to commit 1fd0ef5. Ten input types only gain optional attributes: beta chats targeted_messages (reactionId), beta me and users profile positions and projects colleagues, manager and sponsors (relationshipLabel), beta security detection rules detection_action (incidentConfiguration and isExcludedFromIncidentCorrelation), and v1.0 file storage container types settings (isOfficeRestricted). Existing values stay valid. Two additional_properties validations now also reject keys the metadata marks as read-only or that became typed inputs, for example evaluationMode on beta device management assignment filters; a caller passing such a key through additional_properties gets a plan error, and should drop the key or use the typed input. Graph would ignore or refuse a read-only key anyway. Owner decision, given in chat on 2026-10-26: accept these thirteen findings for the next release.
- Replace three legacy cleanup provisioners with independently verified native destroy actions
  - Decision: `2026-10-26-native-destroy-cleanup.json`, approved by benhaspalace.
  - Accepted changes by kind: postcondition_changed: 3, precondition_changed: 3, provider_requirement_changed: 3, replacement_changed: 3.
  - Accepted changes by catalog: verified: 12.
  - Migration notes: All three modules require microsoft/msgraph &gt;= 0.6.0, &lt; 0.7.0; Terraform remains &gt;= 1.11.0. Back up state privately and run one unchanged apply before any change or destroy: retain the existing POST and legacy ownership resource IDs, independently verify identity, and confirm the native remove action has registered the old target. This sequencing is documented, not automatically enforced. After successful POST but failed verification, preserve state and retry unchanged apply without replaying POST; destroy before registration can orphan access. Accepted limitations: there is no destroy-time identity re-check or automatic absence proof, removal requests are asynchronous, and schedule adminRemove identifies a tuple rather than a unique creation generation; coordinate a single writer and reconcile other writers. Role-schedules no longer suppresses 404 or 400 DoesNotExist / NotFound after natural expiry with afterDateTime or afterDuration, or after out-of-band removal; native destroy can fail where the old script succeeded. Resource-role-scopes no longer suppresses DELETE 404 when the parent access package is already gone. The pinned action schema has no safe successful-error override. Independently prove the exact owned schedule is expired/ended or absent (and exclude an external replacement), or prove exact scope absence / exact parent-package GET 404 in the provider tenant; a configured expiry, denied/incomplete read or new-object replication 404 is not sufficient. Only after that proof, remove just the registered remove action using terraform state rm and finish terraform destroy -refresh=false; do not re-apply between state removal and completing destroy. State removal itself revokes no access. Verification data sources re-run on every refresh-enabled plan and apply, including after cleanup registration: later 404, missing/mismatched identity or a later request-status change can fail routine plans and require reconciliation. Catalog resource adminRemove retries matching error-envelope codes / explicit status diagnostics for 400, 409, 429 and 5xx for at most two minutes through the provider delete timeout, not the former six-attempt/20-second cadence; unrecognized errors or refusals outlasting that bound may need another destroy after packages are confirmed gone. Do not replay ambiguous accepted requests without checking delivery. Provider transport, beta parity, replication, expiry/absent cleanup and effective revocation still require owner-dispatched live acceptance; offline contracts and mocks do not establish live completion. Inputs and outputs are unchanged. This decision accepts only the twelve listed interface findings; it approves no other release blockers or runtime evidence.
- Add the optional name_pattern precondition to the custom directory role definitions module (#126)
  - Decision: `2026-10-26-role-definition-name-pattern.json`, approved by benhaspalace.
  - Accepted changes by kind: precondition_changed: 1.
  - Accepted changes by catalog: verified: 1.
  - Migration notes: The role definitions module (verified/roleManagement/directory/roleDefinitions) gains the optional name_pattern input that the other verified modules with a display name already take. It defaults to null, so existing callers keep their current behavior and see no plan change. To opt in, pass an RE2 expression; matching is unanchored unless the caller supplies anchors. A displayName that does not match fails the resource plan with the value and the pattern; a malformed expression fails variable validation. The input keeps the snake_case name of the other modules because it is a control of the module, not a Graph property. No Graph property casing, request body, replacement semantics or state changes. The naming module gains a role_definition kind, which only rejects a blank name because Microsoft Learn documents no length limit for a custom role's displayName.
- Add fifteen verified modules
  - Decision: `2026-10-26-verified-additions-27-to-42.json`, approved by benhaspalace.
  - Accepted changes by kind: inventory_shift: 1.
  - Accepted changes by catalog: without a module path: 1.
  - Migration notes: The verified catalog grows from 27 to 42 modules, more than the release gate's 10 percent inventory shift threshold. Every change is an addition and no verified module is removed or moved: modules/verified/applications/federatedIdentityCredentials, modules/verified/applications/passwordCredentials, modules/verified/identityGovernance/accessReviews/definitions, modules/verified/identityGovernance/entitlementManagement/assignments, modules/verified/identityGovernance/entitlementManagement/settings, modules/verified/identityGovernance/lifecycleWorkflows/customTaskExtensions, modules/verified/identityGovernance/lifecycleWorkflows/workflows, modules/verified/identityGovernance/privilegedAccess/group/assignmentScheduleRequests, modules/verified/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests, modules/verified/identityGovernance/termsOfUse/agreements, modules/verified/oauth2PermissionGrants, modules/verified/policies/authenticationStrengthPolicies, modules/verified/roleManagement/directory/roleAssignments, modules/verified/servicePrincipals/appRoleAssignedTo, modules/verified/servicePrincipals/passwordCredentials are new. Existing configurations need no change; each new module's README describes its inputs, permissions and lifecycle. modules/verified/applications/passwordCredentials and modules/verified/servicePrincipals/passwordCredentials carry a blocking security caveat: msgraph 0.6.0 stores the generated secretText in a nonsensitive resource output, so plan, show and state-show print it in clear text. Both modules refuse to plan unless acknowledge_secret_in_plan_output = true, which redacts nothing; use them only where all plan and show output and the state are treated as secret, with no CI plan logs or pull request plan comments. modules/verified/policies/authenticationStrengthPolicies (#427) creates only custom authentication strength policies; built-in strengths stay read-only and it changes no Conditional Access policy. Owner decision, given in chat on 2026-10-26: accept all fourteen additions, including both password credential modules with this caveat. Owner decision, given in chat on 2026-10-27: approve the fifteenth addition (#427), re-binding this inventory finding from 27 -&gt; 41 to 27 -&gt; 42, with approved_by benhaspalace.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Verified modules:

- Added: `modules/verified/applications/federatedIdentityCredentials`, `modules/verified/applications/passwordCredentials`, `modules/verified/identityGovernance/accessReviews/definitions`, `modules/verified/identityGovernance/entitlementManagement/assignments`, `modules/verified/identityGovernance/entitlementManagement/settings`, `modules/verified/identityGovernance/lifecycleWorkflows/customTaskExtensions`, `modules/verified/identityGovernance/lifecycleWorkflows/workflows`, `modules/verified/identityGovernance/privilegedAccess/group/assignmentScheduleRequests`, `modules/verified/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests`, `modules/verified/identityGovernance/termsOfUse/agreements`, `modules/verified/oauth2PermissionGrants`, `modules/verified/policies/authenticationStrengthPolicies`, `modules/verified/roleManagement/directory/roleAssignments`, `modules/verified/servicePrincipals/appRoleAssignedTo`, `modules/verified/servicePrincipals/passwordCredentials`.
- Interface-changed:
  - `modules/verified/groups`: postcondition_changed: 1, precondition_changed: 1, replacement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/access-packages/resource-role-scopes`: postcondition_changed: 1, precondition_changed: 1, provider_requirement_changed: 1, replacement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs/resources`: postcondition_changed: 1, precondition_changed: 1, provider_requirement_changed: 1, replacement_changed: 1.
  - `modules/verified/naming`: output_added: 1, variable_added: 1.
  - `modules/verified/role-management/directory/role-schedules`: postcondition_changed: 1, precondition_changed: 1, provider_requirement_changed: 1, replacement_changed: 1.
  - `modules/verified/roleManagement/directory/roleDefinitions`: precondition_changed: 1, variable_added: 1.
  - `modules/verified/security-baseline/authentication-methods`: precondition_changed: 1.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Microsoft Graph upstream:

- Microsoft Graph metadata commits: [`34b8e9c29032...1fd0ef510f79`](https://github.com/microsoftgraph/msgraph-metadata/compare/34b8e9c29032c82352a6fd7138be0a864a842bb2...1fd0ef510f79f3dadb3e083bdebc9496f939a11c).
- Microsoft Graph documentation commits: [`98a98cc88051...4b7867afe88f`](https://github.com/microsoftgraph/microsoft-graph-docs-contrib/compare/98a98cc88051a857c119a2e1bb61587633585284...4b7867afe88f98d2415ac2f0219debe86fcb5652).
- New changelog entries by version and change type: v1.0: Addition 21, Change 4; beta: Addition 47, Change 1, Deprecation 3.
- Deletion, Deprecation, Change and Removal entries:
  - beta Change: `coopEnforcement` in `authenticationBehaviors`
  - v1.0 Change: `coopEnforcement` in `authenticationBehaviors`
  - v1.0 Change: `maximumRetries` in `customExtensionClientConfiguration`
  - v1.0 Change: `singleValueLegacyExtendedProperty`
  - v1.0 Change: `timeoutInMilliseconds` in `customExtensionClientConfiguration`
  - beta Deprecation: `allowEdit` in `preview`
  - beta Deprecation: `chromeless` in `preview`
  - beta Deprecation: `viewer` in `preview`
- Entries are production-cloud changelog entries added between the two documentation commits. Details are in [Microsoft's changelog](https://learn.microsoft.com/graph/changelog).

Provenance:

- Generator commit: `d84f6624bc4e884b9c5fc0b72f00ab61c1bc7430`
- Microsoft Graph metadata commit: `1fd0ef510f79f3dadb3e083bdebc9496f939a11c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `050fac47c401bcbd7f824d244acdfee4f4b851660d3d91a6b90efdb931cf06ff`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 320/320, contract_reviewed 6/320, lifecycle_verified 0/320
- beta: schema_validated 633/633, contract_reviewed 6/633, lifecycle_verified 0/633

Contract/interface and evidence changes found by the release gate against `v3.0.0`:

- fallback_increased: 1 case where a module has more generator fallback warnings (untyped or documented-keys-only fields) for one cause, such as polymorphism or recursion, than before (notice).
- inventory_shift: 1 catalog whose module count grew or shrank by more than the gate's shift threshold, 10 percent by default (blocking).
- module_added: 17 modules added to the catalog (notice).
- output_added: 1 output added (notice).
- postcondition_changed: 4 modules whose resource or data source postconditions were added or changed (blocking).
- precondition_changed: 11 modules whose resource or data source lifecycle preconditions were added, removed or changed (blocking).
- provider_requirement_changed: 3 provider requirements whose local binding, source, aliases or version constraint changed without proof that every previously accepted version remains supported (blocking).
- replacement_changed: 10 modules whose replace_triggered_by triggers, the terraform_data values they reference, or their transitive local expressions changed, so a different set of input changes now replaces the object instead of updating it in place (blocking).
- validation_changed: 1166 inputs with a new or changed validation that may reject values accepted before (blocking).
- validation_relaxed: 1 input whose validation changed but provably still accepts every value accepted before (notice).
- variable_added: 1907 inputs added with a default, so existing configurations still plan (notice).
- variable_type_changed: 13 inputs whose Terraform type changed (blocking).
- warnings_increased: 94 modules with more generator warnings than before (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#readme): use `source = "satolap/modules/msgraph//<path>"` with `version = "4.0.0"`.
