Microsoft Graph modules for v1.0 and beta, plus curated modules.

Summary:

- v1.0: 1430 modules; 0 added, 0 removed, 2 interface-changed.
- beta: 2479 modules; 0 added, 0 removed, 2 interface-changed.
- curated: 12 modules; 0 added, 0 removed, 0 interface-changed.
- Accepted breaking changes: 8 in 4 modules, from 2 release decisions.

A module is interface-changed when the release gate reports an accepted or notice finding for it other than an added, removed or renamed module; other file changes do not count.

Breaking changes and migration, accepted by reviewed release decisions:

- Expose the writable properties of custom directory role definitions, with display_name, is_enabled and role_permissions as required inputs
  - Decision: `2026-09-30-directory-role-definition-inputs.json`, approved by benhaspalace.
  - Accepted changes by kind: variable_required: 6.
  - Accepted changes by catalog: v1.0: 3, beta: 3.
  - Migration notes: generated/v1.0/identity-and-access/role-management/directory/role-definitions and generated/beta/identity-and-access/role-management/directory/role-definitions now expose the writable properties of a custom directory role. New required inputs, without a default and not nullable: display_name (Graph displayName, string), is_enabled (isEnabled, bool) and role_permissions (rolePermissions, a list of objects with allowedResourceActions, condition and excludedResourceActions; each item needs allowedResourceActions, which the v1.0 documentation marks as required although the typed input declares it optional, and condition is documented as not supported for custom roles and excludedResourceActions, in v1.0, as not yet supported, so leave both unset). New optional inputs: description, template_id (templateId) and graph_version (Graph property version; version is a reserved Terraform module argument, so the input cannot have that name). Microsoft Graph requires displayName, isEnabled and rolePermissions to create a role definition (https://learn.microsoft.com/en-us/graph/api/rbacapplication-post-roledefinitions) and accepts these properties only on custom roles, where isBuiltIn is false (https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition and https://learn.microsoft.com/en-us/graph/api/unifiedroledefinition-update). Earlier releases exposed only odata_type and additional_properties, and additional_properties rejected description, displayName, isEnabled, rolePermissions, templateId and version as read-only keys, so no earlier configuration could create a role through these modules. After upgrading, terraform validate and terraform plan fail with 'Missing required argument' for display_name, is_enabled and role_permissions until a module call sets all three. Verified with Terraform 1.16.2: a module block without arguments validates against the previous release and fails with three Missing required argument errors against this one, in both API versions. Set the three inputs to the values of the role. For a role definition that was imported into the module, the request body now carries displayName, isEnabled and rolePermissions, so the next plan can show an in-place update of msgraph_resource.this; Microsoft Graph cannot update built-in roles, so do not manage a built-in role with these modules. resourceScopes stays excluded and remains a read-only key of additional_properties (Microsoft documents it as DO NOT USE; scope a custom role through the directoryScopeId of its role assignment), and in beta allowedPrincipalTypes and isPrivileged stay read-only as well. A custom role needs a Microsoft Entra ID P1 or P2 license and the RoleManagement.ReadWrite.Directory permission; Privileged Role Administrator is the least privileged Microsoft Entra role for the signed-in user. The inputs are covered by mocked tests only (Terraform 1.16.2 and 1.7.5 with a mocked msgraph provider), not by a live tenant. Inferred from the documentation and not tested: that Microsoft Graph accepts the request body, including the default @odata.type of #microsoft.graph.unifiedRolePermission that each role_permissions item carries, and the in-place update of an imported role.
- Replace change-notification subscriptions when an input other than expiration_date_time or notification_url changes
  - Decision: `2026-09-30-subscriptions-replace-on-change.json`, approved by benhaspalace.
  - Accepted changes by kind: replacement_changed: 2.
  - Accepted changes by catalog: v1.0: 1, beta: 1.
  - Migration notes: generated/v1.0/change-notifications/subscriptions and generated/beta/change-notifications/subscriptions now replace the subscription when any input other than expiration_date_time and notification_url changes: change_type, resource, client_state, encryption_certificate, encryption_certificate_id, include_resource_data, latest_supported_tls_version, lifecycle_notification_url, notification_query_options, notification_url_app_id and odata_type, in beta also notification_content_type, vapid_public_key, web_push_encryption_p256dh_public_key and web_push_encryption_secret, or the same Graph keys in additional_properties, and any other non-null key of additional_properties that is not a typed input, such as a writable property that the pinned schema lacks (expirationDateTime and notificationUrl stay in-place updates there too). A value of a replacing key that is unknown at plan time plans a replacement. Microsoft Graph updates only expirationDateTime and notificationUrl in place (https://learn.microsoft.com/en-us/graph/api/subscription-update); before this release a change to any other input planned an in-place update that Graph does not support. Terraform now plans a destroy and a create of msgraph_resource.this, in that order because create_before_destroy is not set: the old subscription is deleted first, so its notifications stop at that point until the new subscription exists, and the new subscription has a new id that anything which stored the old id must read again. terraform apply -replace is no longer needed. Each module adds terraform_data.immutable, which holds these values and makes no API call. Upgrading with unchanged inputs plans only the creation of terraform_data.immutable and no change to the subscription. Terraform does not replace in the apply that creates terraform_data.immutable, so a change to one of these inputs made in that same apply is still an in-place update: upgrade first, and change them in a later apply. Changing expiration_date_time or notification_url still updates the subscription in place. The nested subscription collections under drives, groups, shares and sites are not changed by this release. The replacement is covered by mocked tests only, not by a live tenant.

The exact accepted keys, with their decision, kind and detail digest, are in the `interface-changes.json` release asset, listed in `SHA256SUMS`. Each change kind is explained in the Contract/interface and evidence changes list under Provenance.

Provenance:

- Generator commit: `f058671c0fe02ccb6378d9d3d5cf4d8c7ec3af8e`
- Microsoft Graph metadata commit: `7b2914c8ad1340129f52aa785f13c074cb46fd7c`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.6.0`
- Input fingerprint: `763ef257f598c31191e1b5145058263981f00a7438c0e47818375e35a7422f33`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1430/1430, contract_reviewed 6/1430, lifecycle_verified 0/1430
- beta: schema_validated 2479/2479, contract_reviewed 6/2479, lifecycle_verified 0/2479

Contract/interface and evidence changes found by the release gate against `graphmodules-1804d66a728122848656`:

- replacement_changed: 2 modules whose replace_triggered_by triggers, or the terraform_data values they reference, were added, removed or changed, so a different set of input changes now replaces the object instead of updating it in place (blocking).
- validation_relaxed: 2 inputs whose validation changed but provably still accepts every value accepted before (notice).
- variable_added: 6 inputs added with a default, so existing configurations still plan (notice).
- variable_required: 6 inputs that callers must now set: added without a default, or with the default removed (blocking).
- warnings_increased: 4 modules with more generator warnings than before (notice).

Blocking kinds publish only when a reviewed release decision accepts them; notices never block publication.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

`sha256sum -c SHA256SUMS` checks every listed asset and fails for any you did not download; to check only the files you downloaded, run `sha256sum -c --ignore-missing SHA256SUMS`. For module sources and usage, see the [GraphModules README](https://github.com/benhaspalace/GraphModules#readme): pin `git::https://github.com/benhaspalace/GraphModules.git//modules/<path>?ref=graphmodules-763ef257f598c31191e1`.
