# /identity/b2xUserFlows

Create b2xIdentityUserFlow

[Catalog](../../../README.md) · [Identity and access](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/b2xidentityuserflow?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identity/b2xUserFlows`, `GET/PATCH/DELETE /identity/b2xUserFlows/{b2xIdentityUserFlow-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity/b2x-user-flows"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `api_connector_configuration` | `apiConnectorConfiguration` | `any` | no | no |
| `identity_providers` | `identityProviders` | `list(object({       odata_type = optional(string, "#microsoft.graph.identityProvider")       clientId = optional(string)       clientSecret = optional(string)       name = optional(string)       type = optional(string)     }))` | no | yes |
| `languages` | `languages` | `list(object({       odata_type = optional(string, "#microsoft.graph.userFlowLanguageConfiguration")       defaultPages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")     })))       isEnabled = optional(bool)       overridesPages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.userFlowLanguagePage")     })))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `user_attribute_assignments` | `userAttributeAssignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.identityUserFlowAttributeAssignment")       displayName = optional(string)       isOptional = optional(bool)       requiresVerification = optional(bool)       userAttribute = optional(any)       userAttributeValues = optional(list(object({       odata_type = optional(string, "#microsoft.graph.userAttributeValuesItem")       isDefault = optional(bool)       name = optional(string)       value = optional(string)     })))       userInputType = optional(string)     }))` | no | no |
| `user_flow_identity_providers` | `userFlowIdentityProviders` | `list(object({       odata_type = optional(string, "#microsoft.graph.identityProviderBase")       displayName = optional(string)     }))` | no | no |
| `user_flow_type` | `userFlowType` | `string` | no | no |
| `user_flow_type_version` | `userFlowTypeVersion` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- apiConnectorConfiguration: polymorphic schema; accepts an untyped value
- userAttributeAssignments[].userAttribute: polymorphic schema; accepts an untyped value
- userFlowTypeVersion: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
