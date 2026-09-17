# /security/cases/ediscoveryCases

Create ediscoveryCase

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycase?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/cases/ediscovery-cases"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `case_members` | `caseMembers` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryCaseMember")       displayName = optional(string)       recipientType = optional(any)       smtpAddress = optional(string)     }))` | no | no |
| `closed_by` | `closedBy` | `any` | no | no |
| `closed_date_time` | `closedDateTime` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custodians` | `custodians` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryCustodian")       acknowledgedDateTime = optional(string)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(any)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       siteSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentTypes = optional(any)       description = optional(string)       drive = optional(any)       drives = optional(any)       error = optional(any)       externalColumns = optional(any)       items = optional(any)       lists = optional(any)       name = optional(string)       onenote = optional(any)       operations = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       sites = optional(any)       termStore = optional(any)       termStores = optional(any)     }))     })))       status = optional(any)       unifiedGroupSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.unifiedGroupSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       group = optional(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(any)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(any)       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(any)       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       planner = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(any)       resourceProvisioningOptions = optional(any)       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)     }))       holdStatus = optional(any)       includedSources = optional(any)     })))       userSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(any)       includedSources = optional(any)     })))     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `noncustodial_data_sources` | `noncustodialDataSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")       createdDateTime = optional(string)       dataSource = optional(any)       displayName = optional(string)       holdStatus = optional(any)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       status = optional(any)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.caseOperation")       action = optional(any)       completedDateTime = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       percentProgress = optional(number)       resultInfo = optional(any)       status = optional(any)     }))` | no | no |
| `review_sets` | `reviewSets` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewSet")       description = optional(string)       displayName = optional(string)       queries = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewSetQuery")       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)     })))     }))` | no | no |
| `searches` | `searches` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoverySearch")       addToReviewSetOperation = optional(any)       additionalSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.dataSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)     })))       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       custodianSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.dataSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(any)     })))       dataSourceScopes = optional(any)       description = optional(string)       displayName = optional(string)       lastEstimateStatisticsOperation = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       noncustodialSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")       createdDateTime = optional(string)       dataSource = optional(any)       displayName = optional(string)       holdStatus = optional(any)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       status = optional(any)     })))     }))` | no | no |
| `settings` | `settings` | `any` | no | no |
| `status` | `status` | `any` | no | no |
| `tags` | `tags` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewTag")       childSelectability = optional(any)       childTags = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       parent = optional(any)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- caseMembers[].recipientType: polymorphic schema; accepts an untyped value
- closedBy: polymorphic schema; accepts an untyped value
- custodians[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].lastIndexOperation: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.analytics: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.columns: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.contentTypes: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.drive: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.drives: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.error: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.externalColumns: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.items: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.lists: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.onenote: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.operations: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.pages: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.parentReference: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.permissions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.sites: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.termStore: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.termStores: nested schema exceeds depth limit; accepts an untyped value
- custodians[].status: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.acceptedSenders: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.accessType: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.assignedLabels: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.conversations: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.events: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.groupTypes: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.infoCatalogs: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.members: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesExtensionAttributes: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesSyncBehavior: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onenote: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.owners: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.photo: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.planner: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.rejectedSenders: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.resourceBehaviorOptions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.resourceProvisioningOptions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.settings: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.sites: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.team: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.threads: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.transitiveMembers: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].includedSources: polymorphic schema; accepts an untyped value
- custodians[].userSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].userSources[].holdStatus: polymorphic schema; accepts an untyped value
- custodians[].userSources[].includedSources: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].dataSource: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].holdStatus: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].lastIndexOperation: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].status: polymorphic schema; accepts an untyped value
- operations[].action: polymorphic schema; accepts an untyped value
- operations[].createdBy: polymorphic schema; accepts an untyped value
- operations[].resultInfo: polymorphic schema; accepts an untyped value
- operations[].status: polymorphic schema; accepts an untyped value
- reviewSets[].queries[].createdBy: polymorphic schema; accepts an untyped value
- reviewSets[].queries[].lastModifiedBy: polymorphic schema; accepts an untyped value
- searches[].addToReviewSetOperation: polymorphic schema; accepts an untyped value
- searches[].additionalSources[].createdBy: polymorphic schema; accepts an untyped value
- searches[].additionalSources[].holdStatus: polymorphic schema; accepts an untyped value
- searches[].createdBy: polymorphic schema; accepts an untyped value
- searches[].custodianSources[].createdBy: polymorphic schema; accepts an untyped value
- searches[].custodianSources[].holdStatus: polymorphic schema; accepts an untyped value
- searches[].dataSourceScopes: polymorphic schema; accepts an untyped value
- searches[].lastEstimateStatisticsOperation: polymorphic schema; accepts an untyped value
- searches[].lastModifiedBy: polymorphic schema; accepts an untyped value
- searches[].noncustodialSources[].dataSource: polymorphic schema; accepts an untyped value
- searches[].noncustodialSources[].holdStatus: polymorphic schema; accepts an untyped value
- searches[].noncustodialSources[].lastIndexOperation: polymorphic schema; accepts an untyped value
- searches[].noncustodialSources[].status: polymorphic schema; accepts an untyped value
- settings: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- tags[].childSelectability: polymorphic schema; accepts an untyped value
- tags[].childTags[]: recursive schema; accepts an untyped value
- tags[].createdBy: polymorphic schema; accepts an untyped value
- tags[].parent: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
