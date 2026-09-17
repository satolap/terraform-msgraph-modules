# /admin/windows/updates/policies

Create policy

[Catalog](../../../../../README.md) · [Device and app management](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/windowsupdates-policy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /admin/windows/updates/policies`, `GET/PATCH/DELETE /admin/windows/updates/policies/{policy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./device-and-app-management/admin/windows/updates/policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `applicable_content` | `applicableContent` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.applicableContent")       catalogEntry = optional(any)       catalogEntryId = optional(string)       matchedDevices = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.applicableContentDeviceMatch")       deviceId = optional(string)       recommendedBy = optional(list(string))     })))     }))` | no | no |
| `approval_rules` | `approvalRules` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.approvalRule")       deferralInDays = optional(number)     }))` | no | no |
| `approvals` | `approvals` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.policyApproval")       catalogEntryId = optional(string)       status = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `rings` | `rings` | `list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.ring")       deferralInDays = optional(number)       description = optional(string)       displayName = optional(string)       excludedGroupAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.excludedGroupAssignment")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.assignedGroup")       group = optional(any)     })))     }))       includedGroupAssignment = optional(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.includedGroupAssignment")       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.windowsUpdates.assignedGroup")       group = optional(any)     })))     }))       isPaused = optional(bool)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- applicableContent[].catalogEntry: polymorphic schema; accepts an untyped value
- rings[].excludedGroupAssignment.assignments[].group: polymorphic schema; accepts an untyped value
- rings[].includedGroupAssignment.assignments[].group: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
