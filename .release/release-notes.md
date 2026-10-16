Microsoft Graph modules for v1.0 and beta, plus verified modules.

Summary:

- v1.0: 1411 modules; 0 added, 0 removed, 1013 renamed, 0 interface-changed.
- beta: 2400 modules; 0 added, 0 removed, 1562 renamed, 0 interface-changed.
- verified: 17 modules; 0 added, 17 removed, 5 interface-changed.
- Accepted breaking changes: 2600 in 2597 modules, from 1 release decision.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Rename the curated collection to verified and publish generated modules at their Graph route without placeholder folders
  - Decision: `2026-10-15-verified-rename-and-route-names.json`, approved by benhaspalace.
  - Accepted changes by kind: inventory_shift: 1, module_removed: 17, module_renamed: 2575, precondition_changed: 1, replacement_changed: 4, validation_changed: 2.
  - Accepted changes by catalog: v1.0: 1013, beta: 1562, verified: 24, without a module path: 1.
  - Migration notes: This is a breaking release of the Terraform Registry module satolap/modules/msgraph. The curated collection is now verified: change every source of the form satolap/modules/msgraph//curated/&lt;module-path&gt; to satolap/modules/msgraph//verified/&lt;module-path&gt;; the module paths under it are unchanged. Generated modules are now at their Microsoft Graph route in kebab-case without its ID parameters: a source that has a by-&lt;id&gt; placeholder folder or a by-path-&lt;hash&gt; folder in v1.1.0 loses it, so /chats/{chat-id}/messages moves from &lt;api-version&gt;/chats/by-chat-id/messages to &lt;api-version&gt;/chats/messages. A route over 150 characters also drops the words a folder repeats from its parent folder. No folder in the new paths is a placeholder or a hash. To find the new address of a module, look up its Graph route under v1.0/ or beta/ in the GraphModules repository; each module README names its route. Each renamed module keeps its inputs and outputs, so only the source address changes. Upgrading from v1.1.0 also brings the interface changes below to the verified modules; they were reviewed in their own pull requests and are carried forward here because their decisions name an earlier release. Read them before the first plan, because several replace objects.

Groups and service principals: verified/groups now replaces the group when is_assignable_to_role changes between true and false or null, or when visibility changes to or from "HiddenMembership": Microsoft Graph sets isAssignableToRole and HiddenMembership only at creation (https://learn.microsoft.com/en-us/graph/api/resources/group), so before this release such a change planned an in-place update that Graph does not apply. A change between null and false keeps the group and sends nothing, because the module now sends isAssignableToRole only when it is true; a state written with is_assignable_to_role = false plans one in-place update that drops the key from the stored body, and the provider sends no request for it. Public and Private stay in-place updates. Because the old group is deleted before Graph sees the new one, verified/groups adds two lifecycle preconditions for combinations Learn documents as invalid: a role-assignable group must leave visibility null or set it to "Private", and "HiddenMembership" needs "Unified" in group_types. A configuration that fails them could not have been created before either. verified/service-principals now replaces the service principal when app_id changes to a different GUID, because Graph cannot update appId (https://learn.microsoft.com/en-us/graph/api/serviceprincipal-update); a change of only the GUID's case keeps it and sends no PATCH, because the module now ignores appId in an in-place update and sends it only on create. In both modules Terraform plans a destroy and then a create, so the old object is deleted before the new one exists: the new object has a new object ID, and role assignments, app role assignments, catalog resources and anything else that stored the old ID must read it again. Group owners and members are bound again from owner_ids and member_ids, and members added outside them are not. A deleted Microsoft 365 group or cloud security group can be restored for 30 days, and Learn does not say whether it keeps its mail nickname meanwhile; if the new group is refused on the nickname, permanently delete the old one or choose another mail_nickname. Each module adds terraform_data.immutable, which makes no API call. Upgrading with unchanged inputs plans only its creation and no change to the group or service principal, checked with terraform test against a state written by the previous release. Terraform does not replace in the apply that creates terraform_data.immutable, so upgrade first and change these inputs in a later apply. verified/groups also rejects a mail_nickname with a non-ASCII character or more than 64 characters, as Learn's group resource and create group pages document; Learn documents that Graph refuses such a value, so the plan now fails where the apply failed before. A period stays allowed. The replacements are covered by mocked tests only, not by a live tenant.

Entitlement management: verified/identity-governance/entitlement-management/catalogs no longer sends catalogType, because the create request (https://learn.microsoft.com/en-us/graph/api/entitlementmanagement-post-catalogs) documents only displayName, description, state and isExternallyVisible. The catalog_type output still reads the type back. The catalog_type input is deprecated and ignored: it keeps its default "userManaged" and accepts only that value, so configurations that leave it out or set "userManaged" need no change; remove it. A configuration that sets "serviceDefault" now fails validation; remove the input. An existing catalog plans one in-place update after upgrading, because the request body loses catalogType; its PATCH sends no property and the catalog keeps its type. verified/identity-governance/entitlement-management/access-packages now replaces the access package when catalog_id changes, because Microsoft Learn documents the catalog relationship as required on create and read-only, and the update (https://learn.microsoft.com/en-us/graph/api/accesspackage-update) accepts only displayName, description and isHidden. Before this release such a change planned an in-place PATCH that cannot move the package. The new package is created in the new catalog before the old one is deleted and has a new id; assignment policies, resource role scopes and anything else that references the old id must follow it, existing assignments are not moved, and Microsoft Graph may refuse to delete the old package while it still has assignments or policies. catalog_id is compared as written, so a change of letter case alone also replaces the package. The module adds terraform_data.immutable, which makes no API call. Upgrading with unchanged inputs plans only its creation; Terraform does not replace in the apply that creates it, so change catalog_id in a later apply. verified/identity-governance/entitlement-management/catalogs/resources now replaces time_sleep.wait_for_delivery when catalog_id, resource_origin_id, resource_origin_system or api_version changes, through the new terraform_data.add_target. Each of these changes submits a new adminAdd; before this release the sleep was created once, so the verification read ran at plan time against the new catalog or resource, before the new request, and with fail_on_verification_mismatch failed the plan. The read now runs during apply after verification_delay_seconds. A change of resource_display_name alone keeps the sleep, so the captured resource id and the destroy cleanup hook are unchanged. Upgrading with unchanged inputs plans only the creation of terraform_data.add_target and does not replace the sleep or the destroy cleanup hook, which a mocked upgrade test with the real null provider checks. These changes are covered by mocked tests only, not by a live tenant.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Verified modules:

- Removed: `modules/curated/applications`, `modules/curated/directory/administrative-units`, `modules/curated/groups/members`, `modules/curated/groups`, `modules/curated/identity-governance/entitlement-management/access-packages/resource-role-scopes`, `modules/curated/identity-governance/entitlement-management/access-packages`, `modules/curated/identity-governance/entitlement-management/assignment-policies`, `modules/curated/identity-governance/entitlement-management/catalogs/custom-extensions`, `modules/curated/identity-governance/entitlement-management/catalogs/resources`, `modules/curated/identity-governance/entitlement-management/catalogs`, `modules/curated/identity-governance/entitlement-management/connected-organizations`, `modules/curated/identity/conditional-access/named-locations/countries`, `modules/curated/identity/conditional-access/named-locations/ip-ranges`, `modules/curated/identity/conditional-access/policies`, `modules/curated/naming`, `modules/curated/service-principals`, `modules/curated/users`.
- Interface-changed:
  - `modules/verified/groups`: precondition_changed: 1, replacement_changed: 1, validation_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/access-packages`: replacement_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs`: validation_changed: 1.
  - `modules/verified/identity-governance/entitlement-management/catalogs/resources`: replacement_changed: 1.
  - `modules/verified/service-principals`: replacement_changed: 1.

Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `e6b363d58f7008a29d2ec91ad671498ed0394e9c`
- Microsoft Graph metadata commit: `fd42f0e5bcd96b0c5edd5e62e2956a1dc1c5d17a`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `084e0a66ce07566db32a2ce9cb5d852c3aa312900a06a88fbf94a942e52421c8`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1411/1411, contract_reviewed 6/1411, lifecycle_verified 0/1411
- beta: schema_validated 2400/2400, contract_reviewed 6/2400, lifecycle_verified 0/2400

Contract/interface and evidence changes found by the release gate against `v1.1.0`:

- inventory_shift: 1 catalog whose module count grew or shrank by more than the gate's shift threshold, 10 percent by default (blocking).
- module_removed: 17 modules removed from the catalog (blocking).
- module_renamed: 2575 modules moved to a new path that serves the same Graph endpoint (blocking).
- precondition_changed: 1 module whose resource or data source lifecycle preconditions were added, removed or changed (blocking).
- replacement_changed: 4 modules whose replace_triggered_by triggers, or the terraform_data values they reference, were added, removed or changed, so a different set of input changes now replaces the object instead of updating it in place (blocking).
- validation_changed: 2 inputs with a new or changed validation that may reject values accepted before (blocking).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#readme): use `source = "satolap/modules/msgraph//<path>"` with `version = "2.0.0"`.
