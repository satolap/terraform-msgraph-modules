# /roleManagement/directory/roleDefinitions

Create roleDefinitions

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /roleManagement/directory/roleDefinitions`, `GET/PATCH/DELETE /roleManagement/directory/roleDefinitions/{unifiedRoleDefinition-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/identity-and-access/role-management/directory/role-definitions?ref=<release-tag>"
  display_name = "example"
  is_enabled = false
  role_permissions = []
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | yes | no |
| `is_enabled` | `isEnabled` | `bool` | yes | no |
| `role_permissions` | `rolePermissions` | `list(object({       odata_type = optional(string, "#microsoft.graph.unifiedRolePermission")       allowedResourceActions = optional(list(string))       condition = optional(string)       excludedResourceActions = optional(list(string))     }))` | yes | no |
| `description` | `description` | `string` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `template_id` | `templateId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Creating a custom directory role requires a Microsoft Entra ID P1 or P2 license and the RoleManagement.ReadWrite.Directory permission; the least-privileged Microsoft Entra role is Privileged Role Administrator.
- Each rolePermissions item needs allowedResourceActions: the v1.0 documentation marks it as required, but the typed role_permissions input declares every item attribute as optional, so an item without it passes Terraform validation. Microsoft documents condition as not supported for custom roles, and the v1.0 documentation lists excludedResourceActions as not yet supported, so leave both unset. See https://learn.microsoft.com/en-us/graph/api/resources/unifiedrolepermission.
- Microsoft Graph beta contracts can change without notice.
- Reviewed create-required correction: displayName, isEnabled, rolePermissions.
- Reviewed writable correction: description. Custom roles only (isBuiltIn false); read-only when isBuiltIn is true. See https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition.
- Reviewed writable correction: displayName. Custom roles only (isBuiltIn false); read-only when isBuiltIn is true. See https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition.
- Reviewed writable correction: isEnabled. Custom roles only (isBuiltIn false); read-only when isBuiltIn is true. See https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition.
- Reviewed writable correction: rolePermissions. Custom roles only (isBuiltIn false); read-only when isBuiltIn is true. See https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition.
- Reviewed writable correction: templateId. Custom roles only (isBuiltIn false); can be set when isBuiltIn is false and is read-only when isBuiltIn is true. See https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition.
- Reviewed writable correction: version. Custom roles only (isBuiltIn false); read-only when isBuiltIn is true. See https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition.
- resourceScopes stays excluded: Microsoft documents it as DO NOT USE and soon deprecated, and the property tables of the create and update pages do not list it. Scope a custom role through its role assignment's directoryScopeId instead.

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
