# /security/tiIndicators

Create threat intelligence indicator (deprecated)

[Catalog](../../../README.md) · [Security](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tiindicator?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/tiIndicators`, `GET/PATCH/DELETE /security/tiIndicators/{tiIndicator-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/ti-indicators"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `action` | `action` | `any` | no | no |
| `activity_group_names` | `activityGroupNames` | `list(string)` | no | no |
| `additional_information` | `additionalInformation` | `string` | no | no |
| `azure_tenant_id` | `azureTenantId` | `string` | no | no |
| `confidence` | `confidence` | `number` | no | no |
| `description` | `description` | `string` | no | no |
| `diamond_model` | `diamondModel` | `any` | no | no |
| `domain_name` | `domainName` | `string` | no | no |
| `email_encoding` | `emailEncoding` | `string` | no | no |
| `email_language` | `emailLanguage` | `string` | no | no |
| `email_recipient` | `emailRecipient` | `string` | no | no |
| `email_sender_address` | `emailSenderAddress` | `string` | no | no |
| `email_sender_name` | `emailSenderName` | `string` | no | no |
| `email_source_domain` | `emailSourceDomain` | `string` | no | no |
| `email_source_ip_address` | `emailSourceIpAddress` | `string` | no | no |
| `email_subject` | `emailSubject` | `string` | no | no |
| `email_x_mailer` | `emailXMailer` | `string` | no | no |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `file_compile_date_time` | `fileCompileDateTime` | `string` | no | no |
| `file_created_date_time` | `fileCreatedDateTime` | `string` | no | no |
| `file_hash_type` | `fileHashType` | `any` | no | no |
| `file_hash_value` | `fileHashValue` | `string` | no | no |
| `file_mutex_name` | `fileMutexName` | `string` | no | no |
| `file_name` | `fileName` | `string` | no | no |
| `file_packer` | `filePacker` | `string` | no | no |
| `file_path` | `filePath` | `string` | no | no |
| `file_size` | `fileSize` | `number` | no | no |
| `file_type` | `fileType` | `string` | no | no |
| `ingested_date_time` | `ingestedDateTime` | `string` | no | no |
| `is_active` | `isActive` | `bool` | no | no |
| `kill_chain` | `killChain` | `list(string)` | no | no |
| `known_false_positives` | `knownFalsePositives` | `string` | no | no |
| `last_reported_date_time` | `lastReportedDateTime` | `string` | no | no |
| `malware_family_names` | `malwareFamilyNames` | `list(string)` | no | no |
| `network_cidr_block` | `networkCidrBlock` | `string` | no | no |
| `network_destination_asn` | `networkDestinationAsn` | `number` | no | no |
| `network_destination_cidr_block` | `networkDestinationCidrBlock` | `string` | no | no |
| `network_destination_i_pv4` | `networkDestinationIPv4` | `string` | no | no |
| `network_destination_i_pv6` | `networkDestinationIPv6` | `string` | no | no |
| `network_destination_port` | `networkDestinationPort` | `number` | no | no |
| `network_i_pv4` | `networkIPv4` | `string` | no | no |
| `network_i_pv6` | `networkIPv6` | `string` | no | no |
| `network_port` | `networkPort` | `number` | no | no |
| `network_protocol` | `networkProtocol` | `number` | no | no |
| `network_source_asn` | `networkSourceAsn` | `number` | no | no |
| `network_source_cidr_block` | `networkSourceCidrBlock` | `string` | no | no |
| `network_source_i_pv4` | `networkSourceIPv4` | `string` | no | no |
| `network_source_i_pv6` | `networkSourceIPv6` | `string` | no | no |
| `network_source_port` | `networkSourcePort` | `number` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `passive_only` | `passiveOnly` | `bool` | no | no |
| `severity` | `severity` | `number` | no | no |
| `tags` | `tags` | `list(string)` | no | no |
| `target_product` | `targetProduct` | `string` | no | no |
| `threat_type` | `threatType` | `string` | no | no |
| `tlp_level` | `tlpLevel` | `any` | no | no |
| `url` | `url` | `string` | no | no |
| `user_agent` | `userAgent` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- action: polymorphic schema; accepts an untyped value
- diamondModel: polymorphic schema; accepts an untyped value
- fileHashType: polymorphic schema; accepts an untyped value
- tlpLevel: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
