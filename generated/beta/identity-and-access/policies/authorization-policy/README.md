# /policies/authorizationPolicy

Create new navigation property to authorizationPolicy for policies

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/authorizationpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /policies/authorizationPolicy`, `GET/PATCH/DELETE /policies/authorizationPolicy/{authorizationPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/policies/authorization-policy"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `allow_email_verified_users_to_join_organization` | `allowEmailVerifiedUsersToJoinOrganization` | `bool` | no | no |
| `allow_invites_from` | `allowInvitesFrom` | `any` | no | no |
| `allow_user_consent_for_risky_apps` | `allowUserConsentForRiskyApps` | `bool` | no | no |
| `allowed_to_sign_up_email_based_subscriptions` | `allowedToSignUpEmailBasedSubscriptions` | `bool` | no | no |
| `allowed_to_use_sspr` | `allowedToUseSSPR` | `bool` | no | no |
| `block_msol_power_shell` | `blockMsolPowerShell` | `bool` | no | no |
| `default_user_role_overrides` | `defaultUserRoleOverrides` | `list(object({       odata_type = optional(string, "#microsoft.graph.defaultUserRoleOverride")       isDefault = optional(bool)       rolePermissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRolePermission")       allowedResourceActions = optional(list(string))       condition = optional(string)       excludedResourceActions = optional(list(string))     })))     }))` | no | no |
| `default_user_role_permissions` | `defaultUserRolePermissions` | `object({       odata_type = optional(string, "#microsoft.graph.defaultUserRolePermissions")       allowedToCreateApps = optional(bool)       allowedToCreateSecurityGroups = optional(bool)       allowedToCreateTenants = optional(bool)       allowedToReadBitlockerKeysForOwnedDevice = optional(bool)       allowedToReadOtherUsers = optional(bool)     })` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enabled_preview_features` | `enabledPreviewFeatures` | `list(string)` | no | no |
| `guest_user_role_id` | `guestUserRoleId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `permission_grant_policy_ids_assigned_to_default_user_role` | `permissionGrantPolicyIdsAssignedToDefaultUserRole` | `list(string)` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- allowInvitesFrom: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
