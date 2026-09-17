# /users/{user-id}/devices

Create new navigation property to devices for users

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/device?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/devices`, `GET/PATCH/DELETE /users/{user-id}/devices/{device-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/users/by-user-id/devices"
  user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `account_enabled` | `accountEnabled` | `bool` | no | no |
| `alternative_names` | `alternativeNames` | `list(string)` | no | no |
| `alternative_security_ids` | `alternativeSecurityIds` | `list(object({       odata_type = optional(string, "#microsoft.graph.alternativeSecurityId")       identityProvider = optional(string)       key = optional(string)       type = optional(number)     }))` | no | no |
| `commands` | `commands` | `list(object({       odata_type = optional(string, "#microsoft.graph.command")       appServiceName = optional(string)       error = optional(string)       packageFamilyName = optional(string)       payload = optional(any)       permissionTicket = optional(string)       postBackUri = optional(string)       responsepayload = optional(any)       status = optional(string)       type = optional(string)     }))` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `device_category` | `deviceCategory` | `string` | no | no |
| `device_id` | `deviceId` | `string` | no | no |
| `device_metadata` | `deviceMetadata` | `string` | no | no |
| `device_ownership` | `deviceOwnership` | `string` | no | no |
| `device_version` | `deviceVersion` | `number` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `domain_name` | `domainName` | `string` | no | no |
| `enrollment_profile_name` | `enrollmentProfileName` | `string` | no | no |
| `enrollment_type` | `enrollmentType` | `string` | no | no |
| `extension_attributes` | `extensionAttributes` | `any` | no | no |
| `hostnames` | `hostnames` | `list(string)` | no | no |
| `is_managed` | `isManaged` | `bool` | no | no |
| `is_rooted` | `isRooted` | `bool` | no | no |
| `kind` | `kind` | `string` | no | no |
| `management_type` | `managementType` | `string` | no | no |
| `name` | `name` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operating_system` | `operatingSystem` | `string` | no | no |
| `operating_system_version` | `operatingSystemVersion` | `string` | no | no |
| `physical_ids` | `physicalIds` | `list(string)` | no | no |
| `platform` | `platform` | `string` | no | no |
| `profile_type` | `profileType` | `string` | no | no |
| `status` | `status` | `string` | no | no |
| `system_labels` | `systemLabels` | `list(string)` | no | no |
| `transitive_member_of` | `transitiveMemberOf` | `list(object({       odata_type = optional(string, "#microsoft.graph.directoryObject")       deletedDateTime = optional(string)     }))` | no | no |
| `usage_rights` | `usageRights` | `list(object({       odata_type = optional(string, "#microsoft.graph.usageRight")       catalogId = optional(string)       serviceIdentifier = optional(string)       state = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- commands[].payload: polymorphic schema; accepts an untyped value
- commands[].responsepayload: polymorphic schema; accepts an untyped value
- extensionAttributes: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
