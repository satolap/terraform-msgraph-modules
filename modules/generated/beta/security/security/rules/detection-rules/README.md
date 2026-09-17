# /security/rules/detectionRules

Create detectionRule

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-detectionrule?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/rules/detectionRules`, `GET/PATCH/DELETE /security/rules/detectionRules/{detectionRule-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/rules/detection-rules"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `description` | `description` | `string` | no | no |
| `detection_action` | `detectionAction` | `object({       odata_type = optional(string, "#microsoft.graph.security.detectionAction")       alertTemplate = optional(object({       odata_type = optional(string, "#microsoft.graph.security.alertTemplate")       category = optional(string)       customDetails = optional(any)       description = optional(string)       entityMappings = optional(object({       odata_type = optional(string, "#microsoft.graph.security.entityMappingConfiguration")       accounts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.accountEntityMapping")       aadUserIdColumn = optional(string)       dnsDomainColumn = optional(string)       nameColumn = optional(string)       ntDomainColumn = optional(string)       sidColumn = optional(string)       upnColumn = optional(string)       upnSuffixColumn = optional(string)     })))       amazonResources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.amazonResourceEntityMapping")       amazonResourceIdColumn = optional(string)     })))       azureResources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.azureResourceEntityMapping")       resourceIdColumn = optional(string)     })))       cloudApplications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.cloudApplicationEntityMapping")       appIdColumn = optional(string)       nameColumn = optional(string)     })))       dns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.dnsEntityMapping")       domainNameColumn = optional(string)       hostIpAddressColumn = optional(string)       serverIpColumn = optional(string)     })))       files = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.fileEntityMapping")       nameColumn = optional(string)       sha1Column = optional(string)       sha256Column = optional(string)     })))       googleCloudResources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.googleCloudResourceEntityMapping")       fullResourceNameColumn = optional(string)     })))       hosts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostEntityMapping")       deviceIdColumn = optional(string)       dnsDomainColumn = optional(string)       nameColumn = optional(string)       netBiosNameColumn = optional(string)       ntDomainColumn = optional(string)     })))       ips = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.ipEntityMapping")       addressColumn = optional(string)       scopeColumn = optional(string)     })))       mailClusters = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.mailClusterEntityMapping")       queryColumn = optional(string)       sourceColumn = optional(string)     })))       mailMessages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.mailMessageEntityMapping")       networkMessageIdColumn = optional(string)       recipientColumn = optional(string)       senderColumn = optional(string)       subjectColumn = optional(string)     })))       mailboxes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.mailboxEntityMapping")       primaryAddressColumn = optional(string)     })))       oAuthApplications = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.oAuthApplicationEntityMapping")       oAuthAppIdColumn = optional(string)     })))       processes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.processEntityMapping")       sha1Column = optional(string)       sha256Column = optional(string)     })))       registryValues = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.registryValueEntityMapping")       keyColumn = optional(string)       valueNameColumn = optional(string)     })))       securityGroups = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.securityGroupEntityMapping")       distinguishedNameColumn = optional(string)       objectIdColumn = optional(string)       sidColumn = optional(string)     })))       urls = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.urlEntityMapping")       addressColumn = optional(string)     })))     }))       impactedAssets = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.impactedAsset")     })))       mitreTechniques = optional(list(string))       recommendedActions = optional(string)       severity = optional(string)       tactics = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.mitreTactic")       tactic = optional(string)       techniques = optional(any)     })))       title = optional(string)     }))       automatedActions = optional(any)       organizationalScope = optional(any)       responseActions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.responseAction")     })))     })` | no | no |
| `detector_id` | `detectorId` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_enabled` | `isEnabled` | `bool` | no | no |
| `last_run_details` | `lastRunDetails` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `query_condition` | `queryCondition` | `object({       odata_type = optional(string, "#microsoft.graph.security.queryCondition")       lastModifiedDateTime = optional(string)       queryText = optional(string)     })` | no | no |
| `schedule` | `schedule` | `object({       odata_type = optional(string, "#microsoft.graph.security.ruleSchedule")       frequency = optional(string)       nextRunDateTime = optional(string)       period = optional(string)     })` | no | no |
| `status` | `status` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- detectionAction.alertTemplate.customDetails: polymorphic schema; accepts an untyped value
- detectionAction.alertTemplate.tactics[].techniques[]: nested schema exceeds depth limit; accepts an untyped value
- detectionAction.automatedActions: polymorphic schema; accepts an untyped value
- detectionAction.organizationalScope: polymorphic schema; accepts an untyped value
- lastRunDetails: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
