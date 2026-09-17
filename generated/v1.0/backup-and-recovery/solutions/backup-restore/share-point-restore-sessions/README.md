# /solutions/backupRestore/sharePointRestoreSessions

Create sharePointRestoreSession

[Catalog](../../../../README.md) · [Backup and recovery](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/sharepointrestoresession?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /solutions/backupRestore/sharePointRestoreSessions`, `GET/PATCH/DELETE /solutions/backupRestore/sharePointRestoreSessions/{sharePointRestoreSession-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./backup-and-recovery/solutions/backup-restore/share-point-restore-sessions"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `completed_date_time` | `completedDateTime` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `error` | `error` | `any` | no | no |
| `granular_site_restore_artifacts` | `granularSiteRestoreArtifacts` | `list(object({       odata_type = optional(string, "#microsoft.graph.granularSiteRestoreArtifact")       browseSessionId = optional(string)       completionDateTime = optional(string)       restorePointDateTime = optional(string)       restoredItemKey = optional(string)       restoredItemPath = optional(string)       restoredItemWebUrl = optional(string)       siteId = optional(string)       startDateTime = optional(string)       status = optional(string)       webUrl = optional(string)     }))` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `restore_job_type` | `restoreJobType` | `any` | no | no |
| `restore_session_artifact_count` | `restoreSessionArtifactCount` | `any` | no | no |
| `site_restore_artifacts` | `siteRestoreArtifacts` | `list(object({       odata_type = optional(string, "#microsoft.graph.siteRestoreArtifact")       completionDateTime = optional(string)       destinationType = optional(any)       error = optional(any)       restorePoint = optional(any)       restoredSiteId = optional(string)       startDateTime = optional(string)       status = optional(any)     }))` | no | no |
| `site_restore_artifacts_bulk_addition_requests` | `siteRestoreArtifactsBulkAdditionRequests` | `list(object({       odata_type = optional(string, "#microsoft.graph.siteRestoreArtifactsBulkAdditionRequest")       createdBy = optional(any)       createdDateTime = optional(string)       destinationType = optional(any)       displayName = optional(string)       error = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       protectionTimePeriod = optional(any)       protectionUnitIds = optional(list(string))       restorePointPreference = optional(any)       siteIds = optional(list(string))       siteWebUrls = optional(list(string))       status = optional(string)       tags = optional(any)     }))` | no | no |
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
- error: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- restoreJobType: polymorphic schema; accepts an untyped value
- restoreSessionArtifactCount: polymorphic schema; accepts an untyped value
- siteRestoreArtifactsBulkAdditionRequests[].createdBy: polymorphic schema; accepts an untyped value
- siteRestoreArtifactsBulkAdditionRequests[].destinationType: polymorphic schema; accepts an untyped value
- siteRestoreArtifactsBulkAdditionRequests[].error: polymorphic schema; accepts an untyped value
- siteRestoreArtifactsBulkAdditionRequests[].lastModifiedBy: polymorphic schema; accepts an untyped value
- siteRestoreArtifactsBulkAdditionRequests[].protectionTimePeriod: polymorphic schema; accepts an untyped value
- siteRestoreArtifactsBulkAdditionRequests[].restorePointPreference: polymorphic schema; accepts an untyped value
- siteRestoreArtifactsBulkAdditionRequests[].tags: polymorphic schema; accepts an untyped value
- siteRestoreArtifacts[].destinationType: polymorphic schema; accepts an untyped value
- siteRestoreArtifacts[].error: polymorphic schema; accepts an untyped value
- siteRestoreArtifacts[].restorePoint: polymorphic schema; accepts an untyped value
- siteRestoreArtifacts[].status: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
