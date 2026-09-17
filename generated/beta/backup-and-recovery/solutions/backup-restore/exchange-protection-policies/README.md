# /solutions/backupRestore/exchangeProtectionPolicies

Create exchangeProtectionPolicy

[Catalog](../../../../README.md) · [Backup and recovery](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/exchangeprotectionpolicy?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /solutions/backupRestore/exchangeProtectionPolicies`, `GET/PATCH/DELETE /solutions/backupRestore/exchangeProtectionPolicies/{exchangeProtectionPolicy-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./backup-and-recovery/solutions/backup-restore/exchange-protection-policies"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `billing_policy_id` | `billingPolicyId` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `mailbox_exclusion_units` | `mailboxExclusionUnits` | `list(object({       odata_type = optional(string, "#microsoft.graph.mailboxExclusionUnit")       createdBy = optional(any)       createdDateTime = optional(string)       directoryObjectId = optional(string)       error = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       mailboxType = optional(any)       policyId = optional(string)     }))` | no | no |
| `mailbox_exclusion_units_bulk_addition_jobs` | `mailboxExclusionUnitsBulkAdditionJobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.mailboxExclusionUnitsBulkAdditionJob")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       error = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       mailboxes = optional(list(string))       status = optional(string)     }))` | no | no |
| `mailbox_inclusion_rules` | `mailboxInclusionRules` | `list(object({       odata_type = optional(string, "#microsoft.graph.mailboxProtectionRule")       createdBy = optional(any)       createdDateTime = optional(string)       error = optional(any)       isAutoApplyEnabled = optional(bool)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       mailboxExpression = optional(string)       status = optional(any)     }))` | no | no |
| `mailbox_protection_units` | `mailboxProtectionUnits` | `list(object({       odata_type = optional(string, "#microsoft.graph.mailboxProtectionUnit")       backupRetentionPeriodInDays = optional(number)       billingPolicyId = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       directoryObjectId = optional(string)       error = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       mailboxType = optional(any)       offboardRequestedDateTime = optional(string)       policyId = optional(string)       protectionSources = optional(string)       status = optional(any)     }))` | no | no |
| `mailbox_protection_units_bulk_addition_jobs` | `mailboxProtectionUnitsBulkAdditionJobs` | `list(object({       odata_type = optional(string, "#microsoft.graph.mailboxProtectionUnitsBulkAdditionJob")       createdBy = optional(any)       createdDateTime = optional(string)       directoryObjectIds = optional(list(string))       displayName = optional(string)       error = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       mailboxes = optional(list(string))       status = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `offboard_requested_date_time` | `offboardRequestedDateTime` | `string` | no | no |
| `protection_mode` | `protectionMode` | `any` | no | no |
| `protection_policy_artifact_count` | `protectionPolicyArtifactCount` | `any` | no | no |
| `retention_settings` | `retentionSettings` | `list(object({       odata_type = optional(string, "#microsoft.graph.retentionSetting")       interval = optional(string)       period = optional(string)     }))` | no | no |
| `status` | `status` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- createdBy: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- mailboxExclusionUnitsBulkAdditionJobs[].createdBy: polymorphic schema; accepts an untyped value
- mailboxExclusionUnitsBulkAdditionJobs[].error: polymorphic schema; accepts an untyped value
- mailboxExclusionUnitsBulkAdditionJobs[].lastModifiedBy: polymorphic schema; accepts an untyped value
- mailboxExclusionUnits[].createdBy: polymorphic schema; accepts an untyped value
- mailboxExclusionUnits[].error: polymorphic schema; accepts an untyped value
- mailboxExclusionUnits[].lastModifiedBy: polymorphic schema; accepts an untyped value
- mailboxExclusionUnits[].mailboxType: polymorphic schema; accepts an untyped value
- mailboxInclusionRules[].createdBy: polymorphic schema; accepts an untyped value
- mailboxInclusionRules[].error: polymorphic schema; accepts an untyped value
- mailboxInclusionRules[].lastModifiedBy: polymorphic schema; accepts an untyped value
- mailboxInclusionRules[].status: polymorphic schema; accepts an untyped value
- mailboxProtectionUnitsBulkAdditionJobs[].createdBy: polymorphic schema; accepts an untyped value
- mailboxProtectionUnitsBulkAdditionJobs[].error: polymorphic schema; accepts an untyped value
- mailboxProtectionUnitsBulkAdditionJobs[].lastModifiedBy: polymorphic schema; accepts an untyped value
- mailboxProtectionUnits[].createdBy: polymorphic schema; accepts an untyped value
- mailboxProtectionUnits[].error: polymorphic schema; accepts an untyped value
- mailboxProtectionUnits[].lastModifiedBy: polymorphic schema; accepts an untyped value
- mailboxProtectionUnits[].mailboxType: polymorphic schema; accepts an untyped value
- mailboxProtectionUnits[].status: polymorphic schema; accepts an untyped value
- protectionMode: polymorphic schema; accepts an untyped value
- protectionPolicyArtifactCount: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
