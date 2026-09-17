# /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/assignmentPolicies

Create new navigation property to assignmentPolicies for identityGovernance

[Catalog](../../../../../../README.md) · [Identity and access](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentpolicy?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/assignmentPolicies`, `GET/PATCH/DELETE /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/assignmentPolicies/{accessPackageAssignmentPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/entitlement-management/access-packages/by-access-package-id/assignment-policies"
  access_package_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `access_package_id` | URL parameter `accessPackage-id` | `string` | yes | no |
| `allowed_target_scope` | `allowedTargetScope` | `any` | no | no |
| `automatic_request_settings` | `automaticRequestSettings` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_extension_stage_settings` | `customExtensionStageSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.customExtensionStageSetting")       customExtension = optional(any)       stage = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `expiration` | `expiration` | `any` | no | no |
| `modified_date_time` | `modifiedDateTime` | `string` | no | no |
| `notification_settings` | `notificationSettings` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `questions` | `questions` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageQuestion")       isAnswerEditable = optional(bool)       isRequired = optional(bool)       localizations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageLocalizedText")       languageCode = optional(string)       text = optional(string)     })))       sequence = optional(number)       text = optional(string)     }))` | no | no |
| `request_approval_settings` | `requestApprovalSettings` | `any` | no | no |
| `requestor_settings` | `requestorSettings` | `any` | no | no |
| `review_settings` | `reviewSettings` | `any` | no | no |
| `specific_allowed_targets` | `specificAllowedTargets` | `list(object({       odata_type = optional(string, "#microsoft.graph.subjectSet")     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- allowedTargetScope: polymorphic schema; accepts an untyped value
- automaticRequestSettings: polymorphic schema; accepts an untyped value
- customExtensionStageSettings[].customExtension: polymorphic schema; accepts an untyped value
- expiration: polymorphic schema; accepts an untyped value
- notificationSettings: polymorphic schema; accepts an untyped value
- requestApprovalSettings: polymorphic schema; accepts an untyped value
- requestorSettings: polymorphic schema; accepts an untyped value
- reviewSettings: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
