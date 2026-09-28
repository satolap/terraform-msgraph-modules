# /security/cases/ediscoveryCases/{ediscoveryCase-id}/legalHolds/{ediscoveryHoldPolicy-id}/siteSources

Create siteSource

[Catalog](../../../../../../../../README.md) · [Security](../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases/{ediscoveryCase-id}/legalHolds/{ediscoveryHoldPolicy-id}/siteSources`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}/legalHolds/{ediscoveryHoldPolicy-id}/siteSources/{siteSource-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/cases/ediscovery-cases/by-ediscovery-case-id/legal-holds/by-ediscovery-hold-policy-id/site-sources"
  ediscovery_case_id = "parent-object-id"
  ediscovery_hold_policy_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `ediscovery_case_id` | URL parameter `ediscoveryCase-id` | `string` | yes | no |
| `ediscovery_hold_policy_id` | URL parameter `ediscoveryHoldPolicy-id` | `string` | yes | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `hold_status` | `holdStatus` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `site` | `site` | `object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(list(string))       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       contentModels = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentModel")       modelType = optional(string)       name = optional(string)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(list(string))       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnLink")       name = optional(string)     })))       columnPositions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       description = optional(string)       documentSet = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSet")       allowedContentTypes = optional(any)       defaultContents = optional(any)       propagateWelcomePageChanges = optional(bool)       sharedColumns = optional(any)       shouldPrefixNameToFile = optional(bool)       welcomePageColumns = optional(any)       welcomePageUrl = optional(string)     }))       documentTemplate = optional(object({       odata_type = optional(string, "#microsoft.graph.documentSetContent")       contentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       fileName = optional(string)       folderName = optional(string)     }))       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       isBuiltIn = optional(bool)       name = optional(string)       order = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeOrder")       default = optional(bool)       position = optional(number)     }))       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       deleted = optional(object({       odata_type = optional(string, "#microsoft.graph.deleted")       state = optional(string)     }))       description = optional(string)       documentProcessingJobs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.documentProcessingJob")       jobType = optional(string)       listItemUniqueId = optional(string)       status = optional(string)     })))       drive = optional(any)       drives = optional(list(object({       odata_type = optional(string, "#microsoft.graph.drive")       activities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.itemActivityOLD")       action = optional(any)       actor = optional(any)       driveItem = optional(any)       listItem = optional(any)       times = optional(any)     })))       bundles = optional(list(object({       odata_type = optional(string, "#microsoft.graph.driveItem")       activities = optional(any)       analytics = optional(any)       content = optional(string)       contentStream = optional(string)       createdByUser = optional(any)       description = optional(string)       extensions = optional(any)       fileSystemInfo = optional(any)       lastModifiedByUser = optional(any)       media = optional(any)       name = optional(string)       parentReference = optional(any)       retentionLabel = optional(any)       root = optional(any)       subscriptions = optional(any)       webDavUrl = optional(string)       workbook = optional(any)     })))       createdByUser = optional(any)       description = optional(string)       following = optional(list(object({       odata_type = optional(string, "#microsoft.graph.driveItem")       activities = optional(any)       analytics = optional(any)       content = optional(string)       contentStream = optional(string)       createdByUser = optional(any)       description = optional(string)       extensions = optional(any)       fileSystemInfo = optional(any)       lastModifiedByUser = optional(any)       media = optional(any)       name = optional(string)       parentReference = optional(any)       retentionLabel = optional(any)       root = optional(any)       subscriptions = optional(any)       webDavUrl = optional(string)       workbook = optional(any)     })))       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       sharePointIds = optional(object({       odata_type = optional(string, "#microsoft.graph.sharepointIds")       listId = optional(string)       listItemId = optional(string)       listItemUniqueId = optional(string)       siteId = optional(string)       siteUrl = optional(string)       tenantId = optional(string)       webId = optional(string)     }))     })))       extensions = optional(any)       externalColumns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(object({       odata_type = optional(string, "#microsoft.graph.calculatedColumn")       format = optional(string)       formula = optional(string)       outputType = optional(string)     }))       choice = optional(object({       odata_type = optional(string, "#microsoft.graph.choiceColumn")       allowTextEntry = optional(bool)       choices = optional(list(string))       displayAs = optional(string)     }))       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(object({       odata_type = optional(string, "#microsoft.graph.currencyColumn")       locale = optional(string)     }))       dateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeColumn")       displayAs = optional(string)       format = optional(string)     }))       defaultValue = optional(object({       odata_type = optional(string, "#microsoft.graph.defaultColumnValue")       formula = optional(string)       value = optional(string)     }))       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(object({       odata_type = optional(string, "#microsoft.graph.hyperlinkOrPictureColumn")       isPicture = optional(bool)     }))       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(object({       odata_type = optional(string, "#microsoft.graph.lookupColumn")       allowMultipleValues = optional(bool)       allowUnlimitedLength = optional(bool)       columnName = optional(string)       listId = optional(string)       primaryLookupColumnId = optional(string)     }))       name = optional(string)       number = optional(object({       odata_type = optional(string, "#microsoft.graph.numberColumn")       decimalPlaces = optional(string)       displayAs = optional(string)       maximum = optional(any)       minimum = optional(any)     }))       personOrGroup = optional(object({       odata_type = optional(string, "#microsoft.graph.personOrGroupColumn")       allowMultipleSelection = optional(bool)       chooseFromType = optional(string)       displayAs = optional(string)     }))       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(object({       odata_type = optional(string, "#microsoft.graph.contentTypeInfo")       id = optional(string)       name = optional(string)     }))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.termColumn")       allowMultipleValues = optional(bool)       parentTerm = optional(any)       showFullyQualifiedName = optional(bool)       termSet = optional(any)     }))       text = optional(object({       odata_type = optional(string, "#microsoft.graph.textColumn")       allowMultipleLines = optional(bool)       appendChangesToExistingText = optional(bool)       linesForEditing = optional(number)       maxLength = optional(number)       textType = optional(string)     }))       thumbnail = optional(any)       validation = optional(object({       odata_type = optional(string, "#microsoft.graph.columnValidation")       defaultLanguage = optional(string)       descriptions = optional(any)       formula = optional(string)     }))     })))       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(list(object({       odata_type = optional(string, "#microsoft.graph.list")       activities = optional(list(object({       odata_type = optional(string, "#microsoft.graph.itemActivityOLD")       action = optional(any)       actor = optional(any)       driveItem = optional(any)       listItem = optional(any)       times = optional(any)     })))       columns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.columnDefinition")       boolean = optional(any)       calculated = optional(any)       choice = optional(any)       columnGroup = optional(string)       contentApprovalStatus = optional(any)       currency = optional(any)       dateTime = optional(any)       defaultValue = optional(any)       description = optional(string)       displayName = optional(string)       enforceUniqueValues = optional(bool)       geolocation = optional(any)       hidden = optional(bool)       hyperlinkOrPicture = optional(any)       indexed = optional(bool)       isDeletable = optional(bool)       isSealed = optional(bool)       isSearchable = optional(bool)       lookup = optional(any)       name = optional(string)       number = optional(any)       personOrGroup = optional(any)       propagateChanges = optional(bool)       readOnly = optional(bool)       required = optional(bool)       sourceColumn = optional(any)       sourceContentType = optional(any)       term = optional(any)       text = optional(any)       thumbnail = optional(any)       validation = optional(any)     })))       contentTypes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.contentType")       associatedHubsUrls = optional(any)       base = optional(any)       baseTypes = optional(any)       columnLinks = optional(any)       columnPositions = optional(any)       columns = optional(any)       description = optional(string)       documentSet = optional(any)       documentTemplate = optional(any)       group = optional(string)       hidden = optional(bool)       inheritedFrom = optional(any)       isBuiltIn = optional(bool)       name = optional(string)       order = optional(any)       parentId = optional(string)       propagateChanges = optional(bool)       readOnly = optional(bool)       sealed = optional(bool)     })))       createdByUser = optional(any)       description = optional(string)       displayName = optional(string)       drive = optional(any)       items = optional(list(object({       odata_type = optional(string, "#microsoft.graph.listItem")       activities = optional(any)       analytics = optional(any)       contentType = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentSetVersions = optional(any)       driveItem = optional(any)       fields = optional(any)       lastModifiedByUser = optional(any)       name = optional(string)       parentReference = optional(any)       versions = optional(any)     })))       lastModifiedByUser = optional(any)       list = optional(object({       odata_type = optional(string, "#microsoft.graph.listInfo")       contentTypesEnabled = optional(bool)       hidden = optional(bool)       template = optional(string)     }))       name = optional(string)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       subscriptions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.subscription")       changeType = optional(string)       clientState = optional(string)       encryptionCertificate = optional(string)       encryptionCertificateId = optional(string)       expirationDateTime = optional(string)       includeResourceData = optional(bool)       latestSupportedTlsVersion = optional(string)       lifecycleNotificationUrl = optional(string)       notificationContentType = optional(string)       notificationQueryOptions = optional(string)       notificationUrl = optional(string)       notificationUrlAppId = optional(string)       resource = optional(string)       vapidPublicKey = optional(string)       webPushEncryptionP256dhPublicKey = optional(string)       webPushEncryptionSecret = optional(string)     })))     })))       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(list(object({       odata_type = optional(string, "#microsoft.graph.richLongRunningOperation")       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.publicError")       code = optional(string)       details = optional(any)       innerError = optional(object({       odata_type = optional(string, "#microsoft.graph.publicInnerError")       code = optional(string)       details = optional(any)       message = optional(string)       target = optional(string)     }))       message = optional(string)       target = optional(string)     }))       lastActionDateTime = optional(string)       percentageComplete = optional(number)       resourceId = optional(string)       resourceLocation = optional(string)       status = optional(string)       statusDetail = optional(string)       type = optional(string)     })))       ownerIdentityToResolve = optional(object({       odata_type = optional(string, "#microsoft.graph.identityInput")       alias = optional(string)       email = optional(string)       objectId = optional(string)     }))       pageTemplates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.pageTemplate")       canvasLayout = optional(any)       createdByUser = optional(any)       description = optional(string)       lastModifiedByUser = optional(any)       name = optional(string)       pageLayout = optional(string)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       publishingState = optional(object({       odata_type = optional(string, "#microsoft.graph.publicationFacet")       checkedOutBy = optional(any)     }))       title = optional(string)       titleArea = optional(object({       odata_type = optional(string, "#microsoft.graph.titleArea")       alternativeText = optional(string)       enableGradientEffect = optional(bool)       imageWebUrl = optional(string)       layout = optional(string)       serverProcessedContent = optional(object({       odata_type = optional(string, "#microsoft.graph.serverProcessedContent")       componentDependencies = optional(any)       customMetadata = optional(any)       htmlStrings = optional(any)       imageSources = optional(any)       links = optional(any)       searchablePlainTexts = optional(any)     }))       showAuthor = optional(bool)       showPublishedDate = optional(bool)       showTextBlockAboveTitle = optional(bool)       textAboveTitle = optional(string)       textAlignment = optional(string)     }))       webParts = optional(any)     })))       pages = optional(any)       parentReference = optional(object({       odata_type = optional(string, "#microsoft.graph.itemReference")       driveType = optional(string)       shareId = optional(string)       siteId = optional(string)     }))       permissions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.permission")       expirationDateTime = optional(string)     })))       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     })` | no | yes |
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
- site.analytics: navigation property; accepts an untyped value
- site.columns[].boolean: polymorphic schema; accepts an untyped value
- site.columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.columns[].geolocation: polymorphic schema; accepts an untyped value
- site.columns[].number.maximum: polymorphic schema; accepts an untyped value
- site.columns[].number.minimum: polymorphic schema; accepts an untyped value
- site.columns[].sourceColumn: navigation property; accepts an untyped value
- site.columns[].term.parentTerm: navigation property; accepts an untyped value
- site.columns[].term.termSet: navigation property; accepts an untyped value
- site.columns[].thumbnail: polymorphic schema; accepts an untyped value
- site.columns[].validation.descriptions[]: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].base: navigation property; accepts an untyped value
- site.contentTypes[].baseTypes[]: recursive schema; accepts an untyped value
- site.contentTypes[].columnPositions[].boolean: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].calculated: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].choice: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].currency: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].dateTime: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].defaultValue: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].geolocation: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].hyperlinkOrPicture: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].lookup: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].number: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].personOrGroup: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].sourceColumn: navigation property; accepts an untyped value
- site.contentTypes[].columnPositions[].sourceContentType: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].term: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].text: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columnPositions[].thumbnail: polymorphic schema; accepts an untyped value
- site.contentTypes[].columnPositions[].validation: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].boolean: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].calculated: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].choice: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].currency: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].dateTime: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].defaultValue: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].geolocation: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].hyperlinkOrPicture: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].lookup: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].number: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].personOrGroup: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].sourceColumn: navigation property; accepts an untyped value
- site.contentTypes[].columns[].sourceContentType: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].term: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].text: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- site.contentTypes[].columns[].validation: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].documentSet.allowedContentTypes[]: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].documentSet.defaultContents[]: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].documentSet.sharedColumns[]: nested schema exceeds depth limit; accepts an untyped value
- site.contentTypes[].documentSet.welcomePageColumns[]: nested schema exceeds depth limit; accepts an untyped value
- site.createdByUser: polymorphic schema; accepts an untyped value
- site.drive: navigation property; accepts an untyped value
- site.drives[].activities[].action: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].activities[].actor: polymorphic schema; accepts an untyped value
- site.drives[].activities[].driveItem: navigation property; accepts an untyped value
- site.drives[].activities[].listItem: navigation property; accepts an untyped value
- site.drives[].activities[].times: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].activities: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].analytics: navigation property; accepts an untyped value
- site.drives[].bundles[].createdByUser: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].extensions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].fileSystemInfo: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].media: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].retentionLabel: navigation property; accepts an untyped value
- site.drives[].bundles[].root: polymorphic schema; accepts an untyped value
- site.drives[].bundles[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].bundles[].workbook: navigation property; accepts an untyped value
- site.drives[].createdByUser: polymorphic schema; accepts an untyped value
- site.drives[].following[].activities: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].analytics: navigation property; accepts an untyped value
- site.drives[].following[].createdByUser: polymorphic schema; accepts an untyped value
- site.drives[].following[].extensions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].fileSystemInfo: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.drives[].following[].media: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].retentionLabel: navigation property; accepts an untyped value
- site.drives[].following[].root: polymorphic schema; accepts an untyped value
- site.drives[].following[].subscriptions: nested schema exceeds depth limit; accepts an untyped value
- site.drives[].following[].workbook: navigation property; accepts an untyped value
- site.drives[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.extensions[]: polymorphic schema; accepts an untyped value
- site.externalColumns[].boolean: polymorphic schema; accepts an untyped value
- site.externalColumns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.externalColumns[].geolocation: polymorphic schema; accepts an untyped value
- site.externalColumns[].number.maximum: polymorphic schema; accepts an untyped value
- site.externalColumns[].number.minimum: polymorphic schema; accepts an untyped value
- site.externalColumns[].sourceColumn: navigation property; accepts an untyped value
- site.externalColumns[].term.parentTerm: navigation property; accepts an untyped value
- site.externalColumns[].term.termSet: navigation property; accepts an untyped value
- site.externalColumns[].thumbnail: polymorphic schema; accepts an untyped value
- site.externalColumns[].validation.descriptions[]: nested schema exceeds depth limit; accepts an untyped value
- site.informationProtection: navigation property; accepts an untyped value
- site.items[]: polymorphic schema; accepts an untyped value
- site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.lists[].activities[].action: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].activities[].actor: polymorphic schema; accepts an untyped value
- site.lists[].activities[].driveItem: navigation property; accepts an untyped value
- site.lists[].activities[].listItem: navigation property; accepts an untyped value
- site.lists[].activities[].times: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].boolean: polymorphic schema; accepts an untyped value
- site.lists[].columns[].calculated: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].choice: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].contentApprovalStatus: polymorphic schema; accepts an untyped value
- site.lists[].columns[].currency: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].dateTime: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].defaultValue: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].geolocation: polymorphic schema; accepts an untyped value
- site.lists[].columns[].hyperlinkOrPicture: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].lookup: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].number: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].personOrGroup: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].sourceColumn: navigation property; accepts an untyped value
- site.lists[].columns[].sourceContentType: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].term: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].text: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].columns[].thumbnail: polymorphic schema; accepts an untyped value
- site.lists[].columns[].validation: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].associatedHubsUrls: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].base: navigation property; accepts an untyped value
- site.lists[].contentTypes[].baseTypes: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].columnLinks: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].columnPositions: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].columns: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].documentSet: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].documentTemplate: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].inheritedFrom: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].contentTypes[].order: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].createdByUser: polymorphic schema; accepts an untyped value
- site.lists[].drive: navigation property; accepts an untyped value
- site.lists[].items[].activities: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].items[].analytics: navigation property; accepts an untyped value
- site.lists[].items[].contentType: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].items[].createdByUser: polymorphic schema; accepts an untyped value
- site.lists[].items[].deleted: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].items[].documentSetVersions: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].items[].driveItem: navigation property; accepts an untyped value
- site.lists[].items[].fields: navigation property; accepts an untyped value
- site.lists[].items[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.lists[].items[].parentReference: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].items[].versions: nested schema exceeds depth limit; accepts an untyped value
- site.lists[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.lists[].operations[].error: nested schema exceeds depth limit; accepts an untyped value
- site.onenote: navigation property; accepts an untyped value
- site.operations[].error.details[]: nested schema exceeds depth limit; accepts an untyped value
- site.operations[].error.innerError.details: nested schema exceeds depth limit; accepts an untyped value
- site.pageTemplates[].canvasLayout: navigation property; accepts an untyped value
- site.pageTemplates[].createdByUser: polymorphic schema; accepts an untyped value
- site.pageTemplates[].lastModifiedByUser: polymorphic schema; accepts an untyped value
- site.pageTemplates[].publishingState.checkedOutBy: polymorphic schema; accepts an untyped value
- site.pageTemplates[].titleArea.serverProcessedContent.componentDependencies: nested schema exceeds depth limit; accepts an untyped value
- site.pageTemplates[].titleArea.serverProcessedContent.customMetadata: nested schema exceeds depth limit; accepts an untyped value
- site.pageTemplates[].titleArea.serverProcessedContent.htmlStrings: nested schema exceeds depth limit; accepts an untyped value
- site.pageTemplates[].titleArea.serverProcessedContent.imageSources: nested schema exceeds depth limit; accepts an untyped value
- site.pageTemplates[].titleArea.serverProcessedContent.links: nested schema exceeds depth limit; accepts an untyped value
- site.pageTemplates[].titleArea.serverProcessedContent.searchablePlainTexts: nested schema exceeds depth limit; accepts an untyped value
- site.pageTemplates[].webParts[]: polymorphic schema; accepts an untyped value
- site.pages[]: polymorphic schema; accepts an untyped value
- site.recycleBin: navigation property; accepts an untyped value
- site.sites[]: recursive schema; accepts an untyped value
- site.termStore: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
