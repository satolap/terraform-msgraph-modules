# /identity/conditionalAccess/policies

Create conditionalAccessPolicy

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccesspolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identity/conditionalAccess/policies`, `GET/PATCH/DELETE /identity/conditionalAccess/policies/{conditionalAccessPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity/conditional-access/policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `conditions` | `conditions` | `object({       odata_type = optional(string, "#microsoft.graph.conditionalAccessConditionSet")       agentContext = optional(any)       agentIdRiskLevels = optional(any)       agents = optional(any)       applications = optional(any)       authenticationFlows = optional(any)       clientAppTypes = optional(list(string))       clientApplications = optional(any)       deviceStates = optional(any)       devices = optional(any)       insiderRiskLevels = optional(any)       locations = optional(any)       platforms = optional(any)       servicePrincipalRiskLevels = optional(list(string))       signInRiskLevels = optional(list(string))       userRiskLevels = optional(list(string))       users = optional(any)     })` | no | no |
| `deleted_date_time` | `deletedDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `grant_controls` | `grantControls` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `session_controls` | `sessionControls` | `any` | no | no |
| `state` | `state` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- conditions.agentContext: polymorphic schema; accepts an untyped value
- conditions.agentIdRiskLevels: polymorphic schema; accepts an untyped value
- conditions.agents: polymorphic schema; accepts an untyped value
- conditions.applications: polymorphic schema; accepts an untyped value
- conditions.authenticationFlows: polymorphic schema; accepts an untyped value
- conditions.clientApplications: polymorphic schema; accepts an untyped value
- conditions.deviceStates: polymorphic schema; accepts an untyped value
- conditions.devices: polymorphic schema; accepts an untyped value
- conditions.insiderRiskLevels: polymorphic schema; accepts an untyped value
- conditions.locations: polymorphic schema; accepts an untyped value
- conditions.platforms: polymorphic schema; accepts an untyped value
- conditions.users: polymorphic schema; accepts an untyped value
- grantControls: polymorphic schema; accepts an untyped value
- sessionControls: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
