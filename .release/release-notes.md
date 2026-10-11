Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1411 modules; 1 added, 0 removed, 9 renamed, 35 interface-changed.
- beta: 2400 modules; 1 added, 0 removed, 11 renamed, 51 interface-changed.
- curated: 17 modules; 4 added, 0 removed, 2 interface-changed.
- Accepted breaking changes: 90 in 69 modules, from 6 release decisions.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Assignment policies accept multiple choice and localized questions and optional access reviews, without changing the request body of existing callers
  - Decision: `2026-10-07-assignment-policy-reviews-questions.json`, approved by benhaspalace.
  - Accepted changes by kind: validation_changed: 1, variable_type_changed: 1.
  - Accepted changes by catalog: curated: 2.
  - Migration notes: The assignment policy module (modules/curated/identity-governance/entitlement-management/assignment-policies) adds multiple choice and localized requestor questions and optional access reviews. No caller needs to change anything: a caller that uses neither the new input nor a new question attribute sends a byte-identical request body, so the first plan after the upgrade shows no change of the policy. The questions input keeps text, is_required, is_answer_editable and sequence with their defaults, and its object type gains the optional attributes type ("text_input", the default, or "multiple_choice"), localizations ({ text, language_code }), is_single_line_question and regex_pattern for text questions, and is_multiple_selection_allowed and choices ({ text, actual_value, localizations }) for multiple choice questions. A new attribute that is null is left out of the body; a multiple choice question always sends isMultipleSelectionAllowed, false by default. A value of the earlier object type converts to the new one, so a configuration that passes questions through its own typed variable keeps working. The eight new validations on questions check only the new attributes: the type, at least one choice for a multiple choice question, attributes of one question type rejected on the other, distinct actual_value entries, non-empty choice and localized texts, language codes of two letters with an optional two-letter country, and each language at most once per localizations list. The new optional input review_settings (default null) configures recurring access reviews of the policy's assignments; the module sends reviewSettings only when it is set. Microsoft Learn does not say what an update without reviewSettings does to reviews configured in the admin center or by another tool, so to stop reviews set is_enabled = false and apply before removing the input. Access reviews of access package assignments need Microsoft Entra ID Governance or Microsoft Entra Suite. Verified with mocked providers only; not verified in a licensed tenant.
- Add the optional attributes that Microsoft Graph added to nested object types
  - Decision: `2026-10-10-added-nested-attributes.json`, approved by benhaspalace.
  - Accepted changes by kind: variable_type_changed: 30.
  - Accepted changes by catalog: v1.0: 7, beta: 23.
  - Migration notes: 30 object inputs of 26 modules, 7 in v1.0 and 23 in beta, gain optional attributes that Microsoft Graph added to the types they contain: cloudLicensing on user and device objects in beta, recapUrl on beta online meeting AI insights, and vapidPublicKey, webPushEncryptionP256dhPublicKey and webPushEncryptionSecret on subscription objects in v1.0, among others listed in interface-changes.json. No attribute is removed or changes its type. Existing values convert to the new types unchanged, the new attributes default to null, and null attributes are left out of requests, so no change is needed.
- Move 20 generated modules to the service categories of the current Microsoft Graph API reference
  - Decision: `2026-10-10-catalog-recategorization.json`, approved by benhaspalace.
  - Accepted changes by kind: module_renamed: 20.
  - Accepted changes by catalog: v1.0: 9, beta: 11.
  - Migration notes: Microsoft Graph's API reference navigation moved these endpoints to other service areas, so their modules moved to the matching catalog category: 9 in v1.0 and 11 in beta. Each module serves the same Graph endpoint as before. Change the module source to the new directory and keep the module block name, so Terraform keeps the existing state, then run terraform init -upgrade: modules/generated/beta/compliance/data-classification/sensitive-types -&gt; modules/generated/beta/security/data-classification/sensitive-types; modules/generated/beta/device-and-app-management/devices/by-device-id/usage-rights -&gt; modules/generated/beta/other/devices/by-device-id/usage-rights; modules/generated/beta/device-and-app-management/me/devices/by-device-id/usage-rights -&gt; modules/generated/beta/users/me/devices/by-device-id/usage-rights; modules/generated/beta/device-and-app-management/me/usage-rights -&gt; modules/generated/beta/users/me/usage-rights; modules/generated/beta/device-and-app-management/users/by-user-id/devices/by-device-id/usage-rights -&gt; modules/generated/beta/users/users/by-user-id/devices/by-device-id/usage-rights; modules/generated/beta/device-and-app-management/users/by-user-id/usage-rights -&gt; modules/generated/beta/users/users/by-user-id/usage-rights; modules/generated/beta/identity-and-access/directory/impacted-resources/by-impacted-resource-id/tags -&gt; modules/generated/beta/reports/directory/impacted-resources/by-impacted-resource-id/tags; modules/generated/beta/identity-and-access/directory/recommendations/by-recommendation-id/impacted-resources/by-impacted-resource-id/tags -&gt; modules/generated/beta/reports/directory/recommendations/by-recommendation-id/impacted-resources/by-impacted-resource-id/tags; modules/generated/beta/identity-and-access/directory/recommendations/by-recommendation-id/tags -&gt; modules/generated/beta/reports/directory/recommendations/by-recommendation-id/tags; modules/generated/beta/identity-and-access/directory/tenant-governance/governance-policy-templates -&gt; modules/generated/beta/tenants/directory/tenant-governance/governance-policy-templates; modules/generated/beta/tenants/approval-workflow-providers/by-approval-workflow-provider-id/policy-templates -&gt; modules/generated/beta/other/approval-workflow-providers/by-approval-workflow-provider-id/policy-templates; modules/generated/v1.0/identity-and-access/directory/tenant-governance/governance-invitations -&gt; modules/generated/v1.0/tenants/directory/tenant-governance/governance-invitations; modules/generated/v1.0/identity-and-access/directory/tenant-governance/governance-policy-templates -&gt; modules/generated/v1.0/tenants/directory/tenant-governance/governance-policy-templates; modules/generated/v1.0/identity-and-access/directory/tenant-governance/governance-relationships -&gt; modules/generated/v1.0/tenants/directory/tenant-governance/governance-relationships; modules/generated/v1.0/identity-and-access/directory/tenant-governance/governance-requests -&gt; modules/generated/v1.0/tenants/directory/tenant-governance/governance-requests; modules/generated/v1.0/identity-and-access/directory/tenant-governance/related-tenants -&gt; modules/generated/v1.0/tenants/directory/tenant-governance/related-tenants; modules/generated/v1.0/identity-and-access/policies/by-path-06eb97e19b87/m365-capabilities -&gt; modules/generated/v1.0/tenants/policies/by-path-06eb97e19b87/m365-capabilities; modules/generated/v1.0/identity-and-access/policies/cross-tenant-access-policy/default/m365-capabilities -&gt; modules/generated/v1.0/tenants/policies/cross-tenant-access-policy/default/m365-capabilities; modules/generated/v1.0/users/me/notes -&gt; modules/generated/v1.0/mail/me/notes; modules/generated/v1.0/users/users/by-user-id/notes -&gt; modules/generated/v1.0/mail/users/by-user-id/notes. A configuration that keeps the old directory fails terraform init, because that directory is not in this release. Some of these modules also change inputs; those changes are described in the other decisions of this release.
- Add four curated modules: administrative units, group members, connected organizations and naming
  - Decision: `2026-10-10-curated-additions.json`, approved by benhaspalace.
  - Accepted changes by kind: inventory_shift: 1.
  - Accepted changes by catalog: without a module path: 1.
  - Migration notes: The curated catalog grows from 13 to 17 modules, more than the release gate's 10 percent inventory shift threshold. Every change is an addition: modules/curated/directory/administrative-units, modules/curated/groups/members, modules/curated/identity-governance/entitlement-management/connected-organizations and modules/curated/naming are new, and no curated module is removed or moved. Existing configurations need no change; each new module's README describes its inputs, permissions and lifecycle.
- Stop accepting Microsoft Graph properties that the current metadata documents as read-only or no longer defines
  - Decision: `2026-10-10-read-only-properties.json`, approved by benhaspalace.
  - Accepted changes by kind: validation_changed: 8, variable_removed: 11, variable_type_changed: 17.
  - Accepted changes by catalog: v1.0: 28, beta: 8.
  - Migration notes: The current Microsoft Graph metadata documents these properties as read-only, or no longer defines them, so the service does not accept them in create or update requests. (1) Removed inputs (variable_removed, 7 v1.0 and 4 beta): permission of the 7 v1.0 access review decisions modules under identity-and-access/identity-governance (access-reviews/unified/decisions, access-reviews/unified/instances/by-access-review-instance-id/decisions and the five by-path-*/decisions modules); nist_classifications of beta reports/directory/recommendations; and capabilities of the beta cloud-pc-pools modules under device-and-app-management (device-management/virtual-endpoint, me and users/by-user-id), because the beta cloudPcPool type no longer has a capabilities property. Delete these arguments from your module blocks; a module block that still sets one fails at plan time with an unsupported argument error. (2) additional_properties now rejects these keys (validation_changed, 7 v1.0 and 1 beta): permission in the same 7 v1.0 decisions modules and nistClassifications in beta reports/directory/recommendations. Remove the key from additional_properties; leaving it fails the input validation at plan time. (3) Nested attributes removed from object inputs (variable_type_changed, 14 v1.0 and 3 beta): permission from the access review decision objects in 11 decisions, stages and instances inputs of 8 v1.0 access review modules, and groupDisplayName from the delegated administration role assignments in the delegated_administration_role_assignments and policy_snapshot inputs of the tenant-governance modules in v1.0 and beta (3 inputs each). Terraform drops an object attribute that the type no longer declares, so existing values still plan, and the attribute is no longer sent; no change is needed, but you can delete the attribute from your values. interface-changes.json lists every accepted key.
- Replace v1.0 change-notification subscriptions when the new web push inputs change
  - Decision: `2026-10-10-subscriptions-web-push-replacement.json`, approved by benhaspalace.
  - Accepted changes by kind: replacement_changed: 1.
  - Accepted changes by catalog: v1.0: 1.
  - Migration notes: generated/v1.0/change-notifications/subscriptions gains the optional inputs vapid_public_key, web_push_encryption_p256dh_public_key and web_push_encryption_secret, which Microsoft Graph added to subscriptions in v1.0. vapidPublicKey and webPushEncryptionSecret join the inputs whose change replaces the subscription, because Microsoft Graph updates only expirationDateTime and notificationUrl in place (https://learn.microsoft.com/en-us/graph/api/subscription-update). The first plan after upgrading replaces every existing subscription managed by this module once, even when the new inputs stay unset: the record of replacing inputs gains the two keys, which Terraform plans as an in-place update of terraform_data.immutable, and replace_triggered_by then replaces msgraph_resource.this. The old subscription is deleted before the new one is created, so notifications stop until the new subscription exists, and the new subscription has a new id that anything which stored the old id must read again. Checked with terraform plan against a state written by the previous release's record. Upgrade when a short notification gap is acceptable, for example together with a planned renewal.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Curated modules:

- Added: `modules/curated/directory/administrative-units`, `modules/curated/groups/members`, `modules/curated/identity-governance/entitlement-management/connected-organizations`, `modules/curated/naming`.
- Interface-changed:
  - `modules/curated/identity-governance/entitlement-management/assignment-policies`: validation_changed: 1, variable_added: 1, variable_type_changed: 1.
  - `modules/curated/identity-governance/entitlement-management/catalogs`: output_added: 1, variable_added: 1.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Microsoft Graph upstream:

- Microsoft Graph metadata commits: [`a2c1bebf415c...fd42f0e5bcd9`](https://github.com/microsoftgraph/msgraph-metadata/compare/a2c1bebf415c76589e5ad765d5c429134c1ffc81...fd42f0e5bcd96b0c5edd5e62e2956a1dc1c5d17a).
- Microsoft Graph documentation commits: [`4ad99fd37a9e...56602fde3f98`](https://github.com/microsoftgraph/microsoft-graph-docs-contrib/compare/4ad99fd37a9e2e8538275a0a9cdff7907052f3ec...56602fde3f9889e14ac89916234200ab881feb33).
- New changelog entries by version and change type: v1.0: Addition 208; beta: Addition 306, Deletion 6, Update 3.
- Deletion, Deprecation, Change and Removal entries:
  - beta Deletion: `Get member` in `distributionList`
  - beta Deletion: `List members` in `distributionList`
  - beta Deletion: `contactId` in `member`
  - beta Deletion: `members` in `distributionList`
  - beta Deletion: `recipientType` in `member`
  - beta Deletion: `routingType` in `member`
- Entries are production-cloud changelog entries added between the two documentation commits. Details are in [Microsoft's changelog](https://learn.microsoft.com/graph/changelog).

Provenance:

- Generator commit: `a390a82d11335b6b5509d48ac625255f3699d4b5`
- Microsoft Graph metadata commit: `fd42f0e5bcd96b0c5edd5e62e2956a1dc1c5d17a`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `6167eecc753d3a9eb84cdc44cc670f4bdce9a2b2b9afae9431de80a08581a9fa`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1411/1411, contract_reviewed 6/1411, lifecycle_verified 0/1411
- beta: schema_validated 2400/2400, contract_reviewed 6/2400, lifecycle_verified 0/2400

Contract/interface and evidence changes found by the release gate against `graphmodules-23d890654ff0004072ef`:

- fallback_increased: 33 cases where a module has more generator fallback warnings (untyped or documented-keys-only fields) for one cause, such as polymorphism or recursion, than before (notice).
- inventory_shift: 1 catalog whose module count grew or shrank by more than the gate's shift threshold, 10 percent by default (blocking).
- module_added: 6 modules added to the catalog (notice).
- module_renamed: 20 modules moved to a new path that serves the same Graph endpoint (blocking).
- output_added: 1 output added (notice).
- replacement_changed: 1 module whose replace_triggered_by triggers, or the terraform_data values they reference, were added, removed or changed, so a different set of input changes now replaces the object instead of updating it in place (blocking).
- validation_changed: 9 inputs with a new or changed validation that may reject values accepted before (blocking).
- validation_relaxed: 19 inputs whose validation changed but provably still accepts every value accepted before (notice).
- variable_added: 41 inputs added with a default, so existing configurations still plan (notice).
- variable_removed: 11 inputs removed; setting a removed input fails at plan time (blocking).
- variable_type_changed: 48 inputs whose Terraform type changed (blocking).
- warnings_increased: 22 modules with more generator warnings than before (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#readme): pin `git::https://github.com/satolap/terraform-msgraph-modules.git//modules/<path>?ref=graphmodules-6167eecc753d3a9eb84c`.
