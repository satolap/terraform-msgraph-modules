# /solutions/backupRestore/oneDriveForBusinessRestoreSessions

Create oneDriveForBusinessRestoreSession

[Catalog](../../../../README.md) · [Backup and recovery](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onedriveforbusinessrestoresession?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /solutions/backupRestore/oneDriveForBusinessRestoreSessions`, `GET/PATCH/DELETE /solutions/backupRestore/oneDriveForBusinessRestoreSessions/{oneDriveForBusinessRestoreSession-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./backup-and-recovery/solutions/backup-restore/one-drive-for-business-restore-sessions"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `completed_date_time` | `completedDateTime` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `drive_restore_artifacts` | `driveRestoreArtifacts` | `list(object({       odata_type = optional(string, "#microsoft.graph.driveRestoreArtifact")       completionDateTime = optional(string)       destinationType = optional(any)       error = optional(any)       restorePoint = optional(any)       restoredSiteId = optional(string)       startDateTime = optional(string)       status = optional(any)     }))` | no | no |
| `drive_restore_artifacts_bulk_addition_requests` | `driveRestoreArtifactsBulkAdditionRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.driveRestoreArtifactsBulkAdditionRequest")       createdBy = optional(any)       createdDateTime = optional(string)       destinationType = optional(any)       directoryObjectIds = optional(list(string))       displayName = optional(string)       drives = optional(list(string))       error = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       protectionTimePeriod = optional(any)       protectionUnitIds = optional(list(string))       restorePointPreference = optional(any)       status = optional(string)       tags = optional(any)     }))` | no | no |
| `error` | `error` | `any` | no | no |
| `granular_drive_restore_artifacts` | `granularDriveRestoreArtifacts` | `list(object({       odata_type = optional(string, "#microsoft.graph.granularDriveRestoreArtifact")       browseSessionId = optional(string)       completionDateTime = optional(string)       directoryObjectId = optional(string)       restorePointDateTime = optional(string)       restoredItemKey = optional(string)       restoredItemPath = optional(string)       restoredItemWebUrl = optional(string)       startDateTime = optional(string)       status = optional(string)       webUrl = optional(string)     }))` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `restore_job_type` | `restoreJobType` | `any` | no | no |
| `restore_session_artifact_count` | `restoreSessionArtifactCount` | `any` | no | no |
| `status` | `status` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- createdBy: polymorphic schema; accepts an untyped value
- driveRestoreArtifactsBulkAdditionRequests[].createdBy: polymorphic schema; accepts an untyped value
- driveRestoreArtifactsBulkAdditionRequests[].destinationType: polymorphic schema; accepts an untyped value
- driveRestoreArtifactsBulkAdditionRequests[].error: polymorphic schema; accepts an untyped value
- driveRestoreArtifactsBulkAdditionRequests[].lastModifiedBy: polymorphic schema; accepts an untyped value
- driveRestoreArtifactsBulkAdditionRequests[].protectionTimePeriod: polymorphic schema; accepts an untyped value
- driveRestoreArtifactsBulkAdditionRequests[].restorePointPreference: polymorphic schema; accepts an untyped value
- driveRestoreArtifactsBulkAdditionRequests[].tags: polymorphic schema; accepts an untyped value
- driveRestoreArtifacts[].destinationType: polymorphic schema; accepts an untyped value
- driveRestoreArtifacts[].error: polymorphic schema; accepts an untyped value
- driveRestoreArtifacts[].restorePoint: polymorphic schema; accepts an untyped value
- driveRestoreArtifacts[].status: polymorphic schema; accepts an untyped value
- error: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- restoreJobType: polymorphic schema; accepts an untyped value
- restoreSessionArtifactCount: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
