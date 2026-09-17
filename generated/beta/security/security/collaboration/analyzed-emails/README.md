# /security/collaboration/analyzedEmails

Create new navigation property to analyzedEmails for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-analyzedemail?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/collaboration/analyzedEmails`, `GET/PATCH/DELETE /security/collaboration/analyzedEmails/{analyzedEmail-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/collaboration/analyzed-emails"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `alert_ids` | `alertIds` | `list(string)` | no | no |
| `attachments` | `attachments` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.analyzedEmailAttachment")       detonationDetails = optional(any)       fileExtension = optional(string)       fileName = optional(string)       fileSize = optional(number)       fileType = optional(string)       malwareFamily = optional(string)       sha256 = optional(string)       tenantAllowBlockListDetailInfo = optional(string)       threatType = optional(any)     }))` | no | no |
| `authentication_details` | `authenticationDetails` | `any` | no | no |
| `bulk_complaint_level` | `bulkComplaintLevel` | `string` | no | no |
| `client_type` | `clientType` | `string` | no | no |
| `contexts` | `contexts` | `list(string)` | no | no |
| `detection_methods` | `detectionMethods` | `list(string)` | no | no |
| `directionality` | `directionality` | `any` | no | no |
| `distribution_list` | `distributionList` | `string` | no | no |
| `dlp_rules` | `dlpRules` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.analyzedEmailDlpRuleInfo")       name = optional(string)       ruleId = optional(string)     }))` | no | no |
| `email_cluster_id` | `emailClusterId` | `string` | no | no |
| `exchange_transport_rules` | `exchangeTransportRules` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.analyzedEmailExchangeTransportRuleInfo")       name = optional(string)       ruleId = optional(string)     }))` | no | no |
| `forwarding_detail` | `forwardingDetail` | `string` | no | no |
| `inbound_connector_formatted_name` | `inboundConnectorFormattedName` | `string` | no | no |
| `internet_message_id` | `internetMessageId` | `string` | no | no |
| `language` | `language` | `string` | no | no |
| `latest_delivery` | `latestDelivery` | `any` | no | no |
| `logged_date_time` | `loggedDateTime` | `string` | no | no |
| `network_message_id` | `networkMessageId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `original_delivery` | `originalDelivery` | `any` | no | no |
| `override_sources` | `overrideSources` | `list(string)` | no | no |
| `phish_confidence_level` | `phishConfidenceLevel` | `string` | no | no |
| `policy` | `policy` | `string` | no | no |
| `policy_action` | `policyAction` | `string` | no | no |
| `policy_type` | `policyType` | `string` | no | no |
| `primary_override_source` | `primaryOverrideSource` | `string` | no | no |
| `recipient_detail` | `recipientDetail` | `any` | no | no |
| `recipient_email_address` | `recipientEmailAddress` | `string` | no | no |
| `return_path` | `returnPath` | `string` | no | no |
| `sender_detail` | `senderDetail` | `any` | no | no |
| `size_in_bytes` | `sizeInBytes` | `number` | no | no |
| `spam_confidence_level` | `spamConfidenceLevel` | `string` | no | no |
| `subject` | `subject` | `string` | no | no |
| `threat_detection_details` | `threatDetectionDetails` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.threatDetectionDetail")       confidenceLevel = optional(string)       priorityAccountProtection = optional(string)       threats = optional(string)     }))` | no | no |
| `threat_types` | `threatTypes` | `any` | no | no |
| `timeline_events` | `timelineEvents` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.timelineEvent")       eventDateTime = optional(string)       eventDetails = optional(string)       eventResult = optional(string)       eventSource = optional(any)       eventThreats = optional(list(string))       eventType = optional(any)     }))` | no | no |
| `urls` | `urls` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.analyzedEmailUrl")       detectionMethod = optional(string)       detonationDetails = optional(any)       tenantAllowBlockListDetailInfo = optional(string)       threatType = optional(any)       url = optional(string)     }))` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- attachments[].detonationDetails: polymorphic schema; accepts an untyped value
- attachments[].threatType: polymorphic schema; accepts an untyped value
- authenticationDetails: polymorphic schema; accepts an untyped value
- directionality: polymorphic schema; accepts an untyped value
- latestDelivery: polymorphic schema; accepts an untyped value
- originalDelivery: polymorphic schema; accepts an untyped value
- recipientDetail: polymorphic schema; accepts an untyped value
- senderDetail: polymorphic schema; accepts an untyped value
- threatTypes[]: polymorphic schema; accepts an untyped value
- timelineEvents[].eventSource: polymorphic schema; accepts an untyped value
- timelineEvents[].eventType: polymorphic schema; accepts an untyped value
- urls[].detonationDetails: polymorphic schema; accepts an untyped value
- urls[].threatType: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
