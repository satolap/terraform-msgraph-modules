# /security/cases/ediscoveryCases

Create ediscoveryCase

[Catalog](../../../README.md) Â· [Security](../../../README.md#security) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycase?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/cases/ediscoveryCases`, `GET/PATCH/DELETE /security/cases/ediscoveryCases/{ediscoveryCase-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/security/cases/ediscovery-cases"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `case_members` | `caseMembers` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryCaseMember")       displayName = optional(string)       recipientType = optional(string)       smtpAddress = optional(string)     }))` | no | no | in place |
| `closed_by` | `closedBy` | `any` | no | no | in place |
| `closed_date_time` | `closedDateTime` | `string` | no | no | in place |
| `created_date_time` | `createdDateTime` | `string` | no | no | in place |
| `custodians` | `custodians` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryCustodian")       acknowledgedDateTime = optional(string)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(string)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       siteSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(string)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     }))     })))       status = optional(string)       unifiedGroupSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.unifiedGroupSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       group = optional(object({       odata_type = optional(string, "#microsoft.graph.group")       acceptedSenders = optional(any)       accessType = optional(string)       allowExternalSenders = optional(bool)       appRoleAssignments = optional(any)       assignedLabels = optional(any)       autoSubscribeNewMembers = optional(bool)       classification = optional(string)       cloudLicensing = optional(any)       conversations = optional(any)       deletedDateTime = optional(string)       description = optional(string)       displayName = optional(string)       events = optional(any)       groupTypes = optional(any)       hasMembersWithLicenseErrors = optional(bool)       hideFromAddressLists = optional(bool)       hideFromOutlookClients = optional(bool)       infoCatalogs = optional(any)       isAssignableToRole = optional(bool)       isFavorite = optional(bool)       isSubscribedByMail = optional(bool)       mailEnabled = optional(bool)       mailNickname = optional(string)       members = optional(any)       membershipRule = optional(string)       membershipRuleProcessingState = optional(string)       onPremisesExtensionAttributes = optional(any)       onPremisesProvisioningErrors = optional(any)       onPremisesSyncBehavior = optional(any)       onenote = optional(any)       organizationId = optional(string)       owners = optional(any)       permissionGrants = optional(any)       photo = optional(any)       preferredDataLocation = optional(string)       preferredLanguage = optional(string)       rejectedSenders = optional(any)       resourceBehaviorOptions = optional(any)       resourceProvisioningOptions = optional(any)       securityEnabled = optional(bool)       serviceProvisioningErrors = optional(any)       settings = optional(any)       sites = optional(any)       team = optional(any)       theme = optional(string)       threads = optional(any)       transitiveMemberOf = optional(any)       transitiveMembers = optional(any)       unseenConversationsCount = optional(number)       unseenCount = optional(number)       unseenMessagesCount = optional(number)       visibility = optional(string)       welcomeMessageEnabled = optional(bool)       writebackConfiguration = optional(any)     }))       holdStatus = optional(string)       includedSources = optional(string)     })))       userSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(string)       includedSources = optional(string)     })))     }))` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `external_id` | `externalId` | `string` | no | no | in place |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no | in place |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no | in place |
| `legal_holds` | `legalHolds` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryHoldPolicy")       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       errors = optional(list(string))       isEnabled = optional(bool)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       siteSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.siteSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       holdStatus = optional(string)       site = optional(object({       odata_type = optional(string, "#microsoft.graph.site")       analytics = optional(any)       columns = optional(any)       contentModels = optional(any)       contentTypes = optional(any)       createdByUser = optional(any)       deleted = optional(any)       description = optional(string)       documentProcessingJobs = optional(any)       drive = optional(any)       drives = optional(any)       extensions = optional(any)       externalColumns = optional(any)       informationProtection = optional(any)       isPersonalSite = optional(bool)       items = optional(any)       lastModifiedByUser = optional(any)       lists = optional(any)       locale = optional(string)       lockState = optional(string)       name = optional(string)       onenote = optional(any)       operations = optional(any)       ownerIdentityToResolve = optional(any)       pageTemplates = optional(any)       pages = optional(any)       parentReference = optional(any)       permissions = optional(any)       recycleBin = optional(any)       shareByEmailEnabled = optional(bool)       sites = optional(any)       template = optional(string)       termStore = optional(any)     }))     })))       status = optional(string)       userSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.userSource")       createdBy = optional(any)       createdDateTime = optional(string)       displayName = optional(string)       email = optional(string)       holdStatus = optional(string)       includedSources = optional(string)     })))     }))` | no | no | in place |
| `noncustodial_data_sources` | `noncustodialDataSources` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")       createdDateTime = optional(string)       dataSource = optional(any)       displayName = optional(string)       holdStatus = optional(string)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       status = optional(string)     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `operations` | `operations` | `any` | no | no | in place |
| `review_sets` | `reviewSets` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewSet")       description = optional(string)       displayName = optional(string)       files = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryFile")       content = optional(string)       custodian = optional(any)       dateTime = optional(string)       extension = optional(string)       extractedTextContent = optional(string)       mediaType = optional(string)       name = optional(string)       otherProperties = optional(any)       processingStatus = optional(string)       senderOrAuthors = optional(list(string))       size = optional(number)       sourceType = optional(string)       subjectTitle = optional(string)       tags = optional(any)     })))       queries = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewSetQuery")       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       description = optional(string)       displayName = optional(string)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)     })))     }))` | no | no | in place |
| `searches` | `searches` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoverySearch")       addToReviewSetOperation = optional(any)       additionalSources = optional(any)       contentQuery = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       custodianSources = optional(any)       dataSourceScopes = optional(string)       description = optional(string)       displayName = optional(string)       lastEstimateStatisticsOperation = optional(any)       lastModifiedBy = optional(any)       lastModifiedDateTime = optional(string)       noncustodialSources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryNoncustodialDataSource")       createdDateTime = optional(string)       dataSource = optional(any)       displayName = optional(string)       holdStatus = optional(string)       lastIndexOperation = optional(any)       lastModifiedDateTime = optional(string)       releasedDateTime = optional(string)       status = optional(string)     })))     }))` | no | no | in place |
| `settings` | `settings` | `any` | no | no | in place |
| `status` | `status` | `string` | no | no | in place |
| `tags` | `tags` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.ediscoveryReviewTag")       childSelectability = optional(string)       childTags = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       parent = optional(any)     }))` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- closedBy: polymorphic schema; accepts an untyped value
- custodians[].lastIndexOperation: navigation property; accepts an untyped value
- custodians[].siteSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.analytics: navigation property; accepts an untyped value
- custodians[].siteSources[].site.columns: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.contentModels: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.contentTypes: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.createdByUser: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.deleted: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.documentProcessingJobs: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.drive: navigation property; accepts an untyped value
- custodians[].siteSources[].site.drives: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.extensions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.externalColumns: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.informationProtection: navigation property; accepts an untyped value
- custodians[].siteSources[].site.items: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- custodians[].siteSources[].site.lists: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.onenote: navigation property; accepts an untyped value
- custodians[].siteSources[].site.operations: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.ownerIdentityToResolve: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.pageTemplates: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.pages: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.parentReference: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.permissions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.recycleBin: navigation property; accepts an untyped value
- custodians[].siteSources[].site.sites: nested schema exceeds depth limit; accepts an untyped value
- custodians[].siteSources[].site.termStore: navigation property; accepts an untyped value
- custodians[].unifiedGroupSources[].createdBy: polymorphic schema; accepts an untyped value
- custodians[].unifiedGroupSources[].group.acceptedSenders: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.appRoleAssignments: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.assignedLabels: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.cloudLicensing: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.conversations: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.events: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.groupTypes: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.infoCatalogs: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.members: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesExtensionAttributes: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onPremisesSyncBehavior: navigation property; accepts an untyped value
- custodians[].unifiedGroupSources[].group.onenote: navigation property; accepts an untyped value
- custodians[].unifiedGroupSources[].group.owners: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.permissionGrants: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.photo: navigation property; accepts an untyped value
- custodians[].unifiedGroupSources[].group.rejectedSenders: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.resourceBehaviorOptions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.resourceProvisioningOptions: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.serviceProvisioningErrors: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.settings: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.sites: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.team: navigation property; accepts an untyped value
- custodians[].unifiedGroupSources[].group.threads: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.transitiveMemberOf: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.transitiveMembers: nested schema exceeds depth limit; accepts an untyped value
- custodians[].unifiedGroupSources[].group.writebackConfiguration: nested schema exceeds depth limit; accepts an untyped value
- custodians[].userSources[].createdBy: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- legalHolds[].createdBy: polymorphic schema; accepts an untyped value
- legalHolds[].lastModifiedBy: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].createdBy: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.analytics: navigation property; accepts an untyped value
- legalHolds[].siteSources[].site.columns: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.contentModels: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.contentTypes: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.createdByUser: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.deleted: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.documentProcessingJobs: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.drive: navigation property; accepts an untyped value
- legalHolds[].siteSources[].site.drives: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.extensions: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.externalColumns: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.informationProtection: navigation property; accepts an untyped value
- legalHolds[].siteSources[].site.items: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.lastModifiedByUser: polymorphic schema; accepts an untyped value
- legalHolds[].siteSources[].site.lists: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.onenote: navigation property; accepts an untyped value
- legalHolds[].siteSources[].site.operations: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.ownerIdentityToResolve: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.pageTemplates: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.pages: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.parentReference: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.permissions: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.recycleBin: navigation property; accepts an untyped value
- legalHolds[].siteSources[].site.sites: nested schema exceeds depth limit; accepts an untyped value
- legalHolds[].siteSources[].site.termStore: navigation property; accepts an untyped value
- legalHolds[].userSources[].createdBy: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].dataSource: polymorphic schema; accepts an untyped value
- noncustodialDataSources[].lastIndexOperation: navigation property; accepts an untyped value
- operations[]: polymorphic schema; accepts an untyped value
- reviewSets[].files[].custodian: navigation property; accepts an untyped value
- reviewSets[].files[].otherProperties: polymorphic schema; accepts an untyped value
- reviewSets[].files[].tags[]: nested schema exceeds depth limit; accepts an untyped value
- reviewSets[].queries[].createdBy: polymorphic schema; accepts an untyped value
- reviewSets[].queries[].lastModifiedBy: polymorphic schema; accepts an untyped value
- searches[].addToReviewSetOperation: navigation property; accepts an untyped value
- searches[].additionalSources[]: polymorphic schema; accepts an untyped value
- searches[].createdBy: polymorphic schema; accepts an untyped value
- searches[].custodianSources[]: polymorphic schema; accepts an untyped value
- searches[].lastEstimateStatisticsOperation: navigation property; accepts an untyped value
- searches[].lastModifiedBy: polymorphic schema; accepts an untyped value
- searches[].noncustodialSources[].dataSource: polymorphic schema; accepts an untyped value
- searches[].noncustodialSources[].lastIndexOperation: navigation property; accepts an untyped value
- settings: navigation property; accepts an untyped value
- tags[].childTags[]: recursive schema; accepts an untyped value
- tags[].createdBy: polymorphic schema; accepts an untyped value
- tags[].parent: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
