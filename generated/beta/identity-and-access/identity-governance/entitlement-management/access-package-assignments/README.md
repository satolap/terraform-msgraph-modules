# /identityGovernance/entitlementManagement/accessPackageAssignments

Create new navigation property to accessPackageAssignments for identityGovernance

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignment?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/accessPackageAssignments`, `GET/PATCH/DELETE /identityGovernance/entitlementManagement/accessPackageAssignments/{accessPackageAssignment-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/entitlement-management/access-package-assignments"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `access_package_assignment_requests` | `accessPackageAssignmentRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageAssignmentRequest")       accessPackageAssignment = optional(any)       answers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageAnswer")       displayValue = optional(string)     })))       customExtensionCalloutInstances = optional(list(object({       odata_type = optional(string, "#microsoft.graph.customExtensionCalloutInstance")       customExtensionId = optional(string)       detail = optional(string)       externalCorrelationId = optional(string)       status = optional(any)     })))       expirationDateTime = optional(string)       history = optional(list(object({       odata_type = optional(string, "#microsoft.graph.requestActivity")       action = optional(string)       actionDateTime = optional(string)       detail = optional(string)       scheduledDateTime = optional(string)       userDisplayName = optional(string)       userPrincipalName = optional(string)     })))       isValidationOnly = optional(bool)       justification = optional(string)       parameters = optional(any)     }))` | no | no |
| `custom_extension_callout_instances` | `customExtensionCalloutInstances` | `list(object({       odata_type = optional(string, "#microsoft.graph.customExtensionCalloutInstance")       customExtensionId = optional(string)       detail = optional(string)       externalCorrelationId = optional(string)       status = optional(any)     }))` | no | no |
| `expired_date_time` | `expiredDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- accessPackageAssignmentRequests[].accessPackageAssignment: polymorphic schema; accepts an untyped value
- accessPackageAssignmentRequests[].customExtensionCalloutInstances[].status: polymorphic schema; accepts an untyped value
- accessPackageAssignmentRequests[].parameters: polymorphic schema; accepts an untyped value
- customExtensionCalloutInstances[].status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
