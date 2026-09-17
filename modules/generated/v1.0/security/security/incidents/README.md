# /security/incidents

Create new navigation property to incidents for security

[Catalog](../../../README.md) · [Security](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-incident?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/incidents`, `GET/PATCH/DELETE /security/incidents/{incident-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/incidents"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `alerts` | `alerts` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.alert")       actorDisplayName = optional(string)       additionalData = optional(any)       alertPolicyId = optional(string)       alertWebUrl = optional(string)       assignedTo = optional(string)       categories = optional(list(string))       category = optional(string)       classification = optional(any)       comments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.alertComment")       comment = optional(string)       createdByDisplayName = optional(string)       createdDateTime = optional(string)     })))       createdDateTime = optional(string)       customDetails = optional(any)       description = optional(string)       detectionSource = optional(any)       detectorId = optional(string)       determination = optional(any)       evidence = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.alertEvidence")       createdDateTime = optional(string)       detailedRoles = optional(list(string))       remediationStatus = optional(string)       remediationStatusDetails = optional(string)       roles = optional(list(string))       tags = optional(list(string))       verdict = optional(string)     })))       firstActivityDateTime = optional(string)       incidentId = optional(string)       incidentWebUrl = optional(string)       investigationState = optional(any)       lastActivityDateTime = optional(string)       lastUpdateDateTime = optional(string)       mitreTechniques = optional(list(string))       productName = optional(string)       providerAlertId = optional(string)       recommendedActions = optional(string)       resolvedDateTime = optional(string)       serviceSource = optional(string)       severity = optional(string)       status = optional(string)       systemTags = optional(list(string))       tenantId = optional(string)       threatDisplayName = optional(string)       threatFamilyName = optional(string)       title = optional(string)     }))` | no | no |
| `assigned_to` | `assignedTo` | `string` | no | no |
| `classification` | `classification` | `any` | no | no |
| `comments` | `comments` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.alertComment")       comment = optional(string)       createdByDisplayName = optional(string)       createdDateTime = optional(string)     }))` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_tags` | `customTags` | `list(string)` | no | no |
| `description` | `description` | `string` | no | no |
| `determination` | `determination` | `any` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `incident_web_url` | `incidentWebUrl` | `string` | no | no |
| `last_modified_by` | `lastModifiedBy` | `string` | no | no |
| `last_update_date_time` | `lastUpdateDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `priority_score` | `priorityScore` | `number` | no | no |
| `redirect_incident_id` | `redirectIncidentId` | `string` | no | no |
| `resolving_comment` | `resolvingComment` | `string` | no | no |
| `severity` | `severity` | `string` | no | no |
| `status` | `status` | `string` | no | no |
| `summary` | `summary` | `string` | no | no |
| `system_tags` | `systemTags` | `list(string)` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- alerts[].additionalData: polymorphic schema; accepts an untyped value
- alerts[].classification: polymorphic schema; accepts an untyped value
- alerts[].customDetails: polymorphic schema; accepts an untyped value
- alerts[].detectionSource: polymorphic schema; accepts an untyped value
- alerts[].determination: polymorphic schema; accepts an untyped value
- alerts[].investigationState: polymorphic schema; accepts an untyped value
- classification: polymorphic schema; accepts an untyped value
- determination: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
