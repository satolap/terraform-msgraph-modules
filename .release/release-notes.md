Microsoft Graph modules for v1.0 and beta, plus curated modules.

- Generator commit: `a759959139584853507a8382d4fc40f37ae1daaf`
- Microsoft Graph metadata commit: `b8cbef92f6959dca8150bf3edcc650863765e529`
- Tested provider `hashicorp/null`: `3.3.2`
- Tested provider `hashicorp/random`: `3.9.1`
- Tested provider `hashicorp/time`: `0.14.2`
- Tested provider `microsoft/msgraph`: `0.5.0`
- Input fingerprint: `4002ec490efccb9d78324e26efd5d4935f0e3641f7c4cab7721373d62ff17690`

Evidence coverage (all generated modules are in the denominator):

- v1.0: schema_validated 1430/1430, contract_reviewed 5/1430, lifecycle_verified 0/1430
- beta: schema_validated 2479/2479, contract_reviewed 5/2479, lifecycle_verified 0/2479

Contract/interface and evidence changes: fallback_increased: 2, module_removed: 2, precondition_changed: 2, variable_added: 6, variable_default_changed: 6, variable_nullable_tightened: 8, variable_required: 8, warnings_increased: 24.

Breaking changes and migration, accepted by reviewed release decisions:

- Accept curated application and service-principal collection defaults changing from [] to null so an explicit [] can clear a collection
  - Decision: `2026-09-25-curated-collection-defaults.json`, approved by benhaspalace.
  - Accepted changes:
    - `variable_default_changed:curated/applications:app_roles`
    - `variable_default_changed:curated/applications:public_client_redirect_uris`
    - `variable_default_changed:curated/applications:spa_redirect_uris`
    - `variable_default_changed:curated/applications:tags`
    - `variable_default_changed:curated/applications:web_redirect_uris`
    - `variable_default_changed:curated/service-principals:tags`
  - Migration notes: curated/applications (tags, app_roles, web_redirect_uris, spa_redirect_uris, public_client_redirect_uris) and curated/service-principals (tags) now default to null instead of []. Leaving these inputs unset still omits them from the request body, as graphmodules-067c9d13832914ce38d2 already did, so upgrading gives no plan change and values already on the Graph object stay unmanaged. The change is to an explicit []: the previous release silently dropped it, so it never cleared or enforced anything. It is now sent as an empty collection, and apply PATCHes that property to empty, removing values set outside Terraform or left behind by earlier releases. Before upgrading, find every argument that can evaluate to [] (a literal [], a wrapper variable that defaults to [], or cond ? [...] : []). To leave the Graph values untouched, pass null or omit the input. To enforce an empty collection, keep [] and expect an in-place update of body (+ tags = [], + appRoles = [], + web/spa/publicClient = { redirectUris = [] }); for that plan the module outputs app_id and display_name are known after apply, so dependents such as service-principals app_id also show as updated. Pass [] explicitly whenever you need a populated collection cleared. Removing the input or setting it to null after it was populated shows a removal in the plan, but msgraph provider 0.5.0 sends no PATCH for removed keys, so the values stay in Entra ID. app_roles = [] cannot delete enabled roles: first apply those roles with is_enabled = false, then remove them in a later apply. service-principals tags = [] also removes WindowsAzureActiveDirectoryIntegratedApp, which hides the enterprise application. An explicit null, which the previous release rejected with an evaluation error, is now accepted and means omit.
- Stop publishing the top-level Planner plan modules, whose update and delete cannot send the If-Match ETag that Microsoft Graph requires
  - Decision: `2026-09-25-planner-plans-etag-exclusion.json`, approved by benhaspalace.
  - Accepted changes:
    - `module_removed:generated/beta/tasks-and-plans/planner/plans`
    - `module_removed:generated/v1.0/tasks-and-plans/planner/plans`
  - Migration notes: modules/generated/v1.0/tasks-and-plans/planner/plans and modules/generated/beta/tasks-and-plans/planner/plans are no longer published. Microsoft Graph requires an If-Match header with the plan's current ETag on PATCH and DELETE /planner/plans/{id} (https://learn.microsoft.com/en-us/graph/api/plannerplan-update, https://learn.microsoft.com/en-us/graph/api/plannerplan-delete). msgraph_resource in the Microsoft/msgraph provider sends no request headers on update or delete, so these modules could create and read a plan, but later changes and destroys fail. No replacement module is published. The groups/by-group-id, me and users/by-user-id planner/plans modules are not a verified replacement: Microsoft Learn documents plan creation only at POST /planner/plans, and those modules also send no If-Match on update or delete. Before upgrading, stop managing each existing plan without deleting it. Either add a removed block with from = module.&lt;name&gt; and lifecycle { destroy = false } (Terraform &gt;= 1.7), or run terraform state rm module.&lt;name&gt;.msgraph_resource.this. Then delete the module block and manage the plan outside these modules. If you keep the old module block, terraform init fails on the new release with 'Unsupported argument'. This release does not change the modules under planner/plans/by-planner-plan-id.
- Require the four documented create inputs of the beta and v1.0 change-notification subscriptions modules
  - Decision: `2026-09-25-subscriptions-required-create-inputs.json`, approved by benhaspalace.
  - Accepted changes:
    - `variable_nullable_tightened:generated/beta/change-notifications/subscriptions:change_type`
    - `variable_nullable_tightened:generated/beta/change-notifications/subscriptions:expiration_date_time`
    - `variable_nullable_tightened:generated/beta/change-notifications/subscriptions:notification_url`
    - `variable_nullable_tightened:generated/beta/change-notifications/subscriptions:resource`
    - `variable_nullable_tightened:generated/v1.0/change-notifications/subscriptions:change_type`
    - `variable_nullable_tightened:generated/v1.0/change-notifications/subscriptions:expiration_date_time`
    - `variable_nullable_tightened:generated/v1.0/change-notifications/subscriptions:notification_url`
    - `variable_nullable_tightened:generated/v1.0/change-notifications/subscriptions:resource`
    - `variable_required:generated/beta/change-notifications/subscriptions:change_type`
    - `variable_required:generated/beta/change-notifications/subscriptions:expiration_date_time`
    - `variable_required:generated/beta/change-notifications/subscriptions:notification_url`
    - `variable_required:generated/beta/change-notifications/subscriptions:resource`
    - `variable_required:generated/v1.0/change-notifications/subscriptions:change_type`
    - `variable_required:generated/v1.0/change-notifications/subscriptions:expiration_date_time`
    - `variable_required:generated/v1.0/change-notifications/subscriptions:notification_url`
    - `variable_required:generated/v1.0/change-notifications/subscriptions:resource`
  - Migration notes: generated/v1.0/change-notifications/subscriptions and generated/beta/change-notifications/subscriptions: change_type, expiration_date_time, notification_url and resource are now required and may not be null. Microsoft Graph requires all four to create a subscription (https://learn.microsoft.com/en-us/graph/api/resources/subscription, https://learn.microsoft.com/en-us/graph/api/subscription-post-subscriptions). If you already set all four typed inputs, nothing changes: the request body is identical, so no update or replacement is planned. If you passed any of them through additional_properties (keys changeType, expirationDateTime, notificationUrl, resource) or set a typed input to null, terraform validate/plan now fails with 'Missing required argument' or 'Required variable not set' (required variable may not be set to null). Move each value to its typed input with the same value and remove the key from additional_properties. The body stays the same, so no API call results. If you omitted them entirely, the previous module sent a create request without them, which Microsoft Graph documents as invalid; set all four before applying. Unchanged limitations: Microsoft Graph updates only expirationDateTime and notificationUrl in place (https://learn.microsoft.com/en-us/graph/api/subscription-update). The module does not force replacement, so a change to resource or change_type becomes an in-place PATCH that Graph does not document as supported. Change them with terraform apply -replace=module.&lt;name&gt;.msgraph_resource.this. The module does not renew subscriptions; update expiration_date_time before it passes.
- Check at plan time that the users/users modules receive one complete creation profile through typed inputs or additional_properties
  - Decision: `2026-09-25-users-creation-profile-precondition.json`, approved by benhaspalace.
  - Accepted changes:
    - `precondition_changed:generated/beta/users/users`
    - `precondition_changed:generated/v1.0/users/users`
  - Migration notes: generated/v1.0/users/users and generated/beta/users/users now check at plan time that the request body holds one complete creation profile: either the standard profile (accountEnabled, displayName, mailNickname, passwordProfile, userPrincipalName) or identities. Each property can come from its typed input (account_enabled, display_name, mail_nickname, password_profile, user_principal_name, identities) or from an additional_properties key with the Graph property name; null values do not count. Microsoft Graph documents these properties as the ones required to create a user (https://learn.microsoft.com/en-us/graph/api/user-post-users). Without a complete profile, terraform plan fails with 'Resource precondition failed' and 'Provide one complete creation profile through typed inputs or additional_properties'. Terraform preconditions cannot distinguish create from update, so the check runs on every plan, including updates of existing users and users brought under management with terraform import or an import block. Before upgrading, make sure the configuration of every existing or imported user carries a complete profile. WARNING (inferred from provider behaviour, not tested against a live tenant): adding password_profile, or passwordProfile in additional_properties, to the configuration of a user whose Terraform state does not already hold it makes the provider send passwordProfile on the next apply. Microsoft Graph applies that as a password reset (https://learn.microsoft.com/en-us/graph/api/user-update), which can replace the user's password and force a password change at next sign-in. Review every plan before applying: the body argument is sensitive, so the plan shows only that msgraph_resource.this is updated in place; for an existing user whose configuration just gained password_profile, that update can reset the password. If an existing user cannot carry a complete profile without that risk, keep its module source on ?ref=graphmodules-067c9d13832914ce38d2 until it can. This release also adds the optional inputs business_phones, mobile_phone and on_premises_extension_attributes. Microsoft Graph accepts them only for cloud-only users: business_phones and mobile_phone are read-only for users synchronized from an on-premises directory (https://learn.microsoft.com/en-us/graph/api/resources/user), and on_premises_extension_attributes can be set only for cloud-only users that were never synchronized (https://learn.microsoft.com/en-us/graph/api/resources/onpremisesextensionattributes, https://learn.microsoft.com/en-us/graph/api/user-update). Left unset they stay out of the request body. Values already passed as businessPhones, mobilePhone or onPremisesExtensionAttributes in additional_properties keep working; a typed input takes precedence when both are set.

Python tests, Terraform validation, and available mocked Terraform tests pass before publication. Beta modules follow Microsoft Graph's preview API and may change incompatibly. Live tenant tests run separately on explicit request.

This release tags the GraphModules commit containing generated modules under `modules/generated/<api>` and curated modules under `modules/curated`. Git module sources use `//modules/generated/<api>/<category>/<module>?ref=<release-tag>` or `//modules/curated/<module>?ref=<release-tag>`. The module-only archives below preserve those same paths. Each module archive includes `release-manifest.json`. Verify downloads with `sha256sum -c SHA256SUMS`.

Example using this release's exact tag:

```hcl
module "application" {
  source       = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/applications/applications?ref=graphmodules-4002ec490efccb9d7832"
  display_name = "Example application"
}

module "curated_group" {
  source           = "git::https://github.com/benhaspalace/GraphModules.git//modules/curated/groups?ref=graphmodules-4002ec490efccb9d7832"
  display_name     = "Example group"
  mail_nickname    = "example-group"
  security_enabled = true
}
```
