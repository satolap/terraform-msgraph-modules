# /security/securityCopilot/workspaces

Create new navigation property to workspaces for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-securitycopilot-workspace?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/securityCopilot/workspaces`, `GET/PATCH/DELETE /security/securityCopilot/workspaces/{workspace-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/security-copilot/workspaces"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `display_name` | `displayName` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `plugins` | `plugins` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.securityCopilot.plugin")       authorization = optional(any)       catalogScope = optional(string)       category = optional(string)       description = optional(string)       displayName = optional(string)       isEnabled = optional(bool)       name = optional(string)       previewState = optional(string)       settings = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.securityCopilot.pluginSetting")       acceptableValues = optional(list(string))       defaultValue = optional(string)       description = optional(string)       displayType = optional(string)       hintText = optional(string)       isRequired = optional(bool)       label = optional(string)       name = optional(string)       settingValue = optional(string)       value = optional(string)     })))       supportedAuthTypes = optional(string)     }))` | no | no |
| `sessions` | `sessions` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.securityCopilot.session")       createdDateTime = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       prompts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.securityCopilot.prompt")       content = optional(string)       createdDateTime = optional(string)       evaluations = optional(any)       inputs = optional(any)       lastModifiedDateTime = optional(string)       skillInputDescriptors = optional(any)       skillName = optional(string)       type = optional(string)     })))     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- plugins[].authorization: polymorphic schema; accepts an untyped value
- sessions[].prompts[].evaluations[]: nested schema exceeds depth limit; accepts an untyped value
- sessions[].prompts[].inputs: polymorphic schema; accepts an untyped value
- sessions[].prompts[].skillInputDescriptors[]: nested schema exceeds depth limit; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
