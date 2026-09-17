# /users/{user-id}/mailFolders/{mailFolder-id}/messageRules

Create new navigation property to messageRules for users

[Catalog](../../../../../../README.md) · [Mail](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/messagerule?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/mailFolders/{mailFolder-id}/messageRules`, `GET/PATCH/DELETE /users/{user-id}/mailFolders/{mailFolder-id}/messageRules/{messageRule-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./mail/users/by-user-id/mail-folders/by-mail-folder-id/message-rules"
  user_id = "parent-object-id"
  mail_folder_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `mail_folder_id` | URL parameter `mailFolder-id` | `string` | yes | no |
| `actions` | `actions` | `any` | no | no |
| `conditions` | `conditions` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `exceptions` | `exceptions` | `any` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `sequence` | `sequence` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- actions: polymorphic schema; accepts an untyped value
- conditions: polymorphic schema; accepts an untyped value
- exceptions: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
