# /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/accessPackageAssignmentPolicies

Create new navigation property to accessPackageAssignmentPolicies for identityGovernance

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/accessPackageAssignmentPolicies`, `GET/PATCH/DELETE /identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/accessPackageAssignmentPolicies/{accessPackageAssignmentPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/identity-governance/by-path-3c0a934e2214/access-package-assignment-policies"
  access_package_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `access_package_id` | URL parameter `accessPackage-id` | `string` | yes | no |
| `access_package_catalog` | `accessPackageCatalog` | `any` | no | no |
| `access_package_id_2` | `accessPackageId` | `string` | no | no |
| `access_package_notification_settings` | `accessPackageNotificationSettings` | `any` | no | no |
| `access_review_settings` | `accessReviewSettings` | `any` | no | no |
| `can_extend` | `canExtend` | `bool` | no | no |
| `created_by` | `createdBy` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_extension_handlers` | `customExtensionHandlers` | `list(object({       odata_type = optional(string, "#microsoft.graph.customExtensionHandler")       customExtension = optional(any)       stage = optional(any)     }))` | no | no |
| `custom_extension_stage_settings` | `customExtensionStageSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.customExtensionStageSetting")       customExtension = optional(any)       stage = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `duration_in_days` | `durationInDays` | `number` | no | no |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no |
| `modified_by` | `modifiedBy` | `string` | no | no |
| `modified_date_time` | `modifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `questions` | `questions` | `list(object({       odata_type = optional(string, "#microsoft.graph.accessPackageQuestion")       id = optional(string)       isAnswerEditable = optional(bool)       isRequired = optional(bool)       sequence = optional(number)       text = optional(any)     }))` | no | no |
| `request_approval_settings` | `requestApprovalSettings` | `any` | no | no |
| `requestor_settings` | `requestorSettings` | `any` | no | no |
| `verifiable_credential_settings` | `verifiableCredentialSettings` | `any` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- accessPackageCatalog: polymorphic schema; accepts an untyped value
- accessPackageNotificationSettings: polymorphic schema; accepts an untyped value
- accessReviewSettings: polymorphic schema; accepts an untyped value
- customExtensionHandlers[].customExtension: polymorphic schema; accepts an untyped value
- customExtensionHandlers[].stage: polymorphic schema; accepts an untyped value
- customExtensionStageSettings[].customExtension: polymorphic schema; accepts an untyped value
- questions[].text: polymorphic schema; accepts an untyped value
- requestApprovalSettings: polymorphic schema; accepts an untyped value
- requestorSettings: polymorphic schema; accepts an untyped value
- verifiableCredentialSettings: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
