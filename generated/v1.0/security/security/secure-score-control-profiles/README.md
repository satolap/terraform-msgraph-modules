# /security/secureScoreControlProfiles

Create new navigation property to secureScoreControlProfiles for security

[Catalog](../../../README.md) · [Security](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/securescorecontrolprofile?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/secureScoreControlProfiles`, `GET/PATCH/DELETE /security/secureScoreControlProfiles/{secureScoreControlProfile-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/secure-score-control-profiles"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `action_type` | `actionType` | `string` | no | no |
| `action_url` | `actionUrl` | `string` | no | no |
| `azure_tenant_id` | `azureTenantId` | `string` | no | no |
| `compliance_information` | `complianceInformation` | `list(object({       odata_type = optional(string, "#microsoft.graph.complianceInformation")       certificationControls = optional(list(object({       odata_type = optional(string, "#microsoft.graph.certificationControl")       name = optional(string)       url = optional(string)     })))       certificationName = optional(string)     }))` | no | no |
| `control_category` | `controlCategory` | `string` | no | no |
| `control_state_updates` | `controlStateUpdates` | `list(object({       odata_type = optional(string, "#microsoft.graph.secureScoreControlStateUpdate")       assignedTo = optional(string)       comment = optional(string)       state = optional(string)       updatedBy = optional(string)       updatedDateTime = optional(string)     }))` | no | no |
| `deprecated` | `deprecated` | `bool` | no | no |
| `implementation_cost` | `implementationCost` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `max_score` | `maxScore` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `rank` | `rank` | `number` | no | no |
| `remediation` | `remediation` | `string` | no | no |
| `remediation_impact` | `remediationImpact` | `string` | no | no |
| `service` | `service` | `string` | no | no |
| `threats` | `threats` | `list(string)` | no | no |
| `tier` | `tier` | `string` | no | no |
| `title` | `title` | `string` | no | no |
| `user_impact` | `userImpact` | `string` | no | no |
| `vendor_information` | `vendorInformation` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- maxScore: polymorphic schema; accepts an untyped value
- vendorInformation: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
