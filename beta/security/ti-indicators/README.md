# /security/tiIndicators

Create threat intelligence indicator (deprecated)

[Catalog](../../README.md) Â· [Security](../../README.md#security) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tiindicator?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/tiIndicators`, `GET/PATCH/DELETE /security/tiIndicators/{tiIndicator-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/security/ti-indicators"
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
| `action` | `action` | `string` | no | no | in place |
| `activity_group_names` | `activityGroupNames` | `list(string)` | no | no | in place |
| `additional_information` | `additionalInformation` | `string` | no | no | in place |
| `azure_tenant_id` | `azureTenantId` | `string` | no | no | in place |
| `confidence` | `confidence` | `number` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `diamond_model` | `diamondModel` | `string` | no | no | in place |
| `domain_name` | `domainName` | `string` | no | no | in place |
| `email_encoding` | `emailEncoding` | `string` | no | no | in place |
| `email_language` | `emailLanguage` | `string` | no | no | in place |
| `email_recipient` | `emailRecipient` | `string` | no | no | in place |
| `email_sender_address` | `emailSenderAddress` | `string` | no | no | in place |
| `email_sender_name` | `emailSenderName` | `string` | no | no | in place |
| `email_source_domain` | `emailSourceDomain` | `string` | no | no | in place |
| `email_source_ip_address` | `emailSourceIpAddress` | `string` | no | no | in place |
| `email_subject` | `emailSubject` | `string` | no | no | in place |
| `email_x_mailer` | `emailXMailer` | `string` | no | no | in place |
| `expiration_date_time` | `expirationDateTime` | `string` | no | no | in place |
| `external_id` | `externalId` | `string` | no | no | in place |
| `file_compile_date_time` | `fileCompileDateTime` | `string` | no | no | in place |
| `file_created_date_time` | `fileCreatedDateTime` | `string` | no | no | in place |
| `file_hash_type` | `fileHashType` | `string` | no | no | in place |
| `file_hash_value` | `fileHashValue` | `string` | no | no | in place |
| `file_mutex_name` | `fileMutexName` | `string` | no | no | in place |
| `file_name` | `fileName` | `string` | no | no | in place |
| `file_packer` | `filePacker` | `string` | no | no | in place |
| `file_path` | `filePath` | `string` | no | no | in place |
| `file_size` | `fileSize` | `number` | no | no | in place |
| `file_type` | `fileType` | `string` | no | no | in place |
| `ingested_date_time` | `ingestedDateTime` | `string` | no | no | in place |
| `is_active` | `isActive` | `bool` | no | no | in place |
| `kill_chain` | `killChain` | `list(string)` | no | no | in place |
| `known_false_positives` | `knownFalsePositives` | `string` | no | no | in place |
| `last_reported_date_time` | `lastReportedDateTime` | `string` | no | no | in place |
| `malware_family_names` | `malwareFamilyNames` | `list(string)` | no | no | in place |
| `network_cidr_block` | `networkCidrBlock` | `string` | no | no | in place |
| `network_destination_asn` | `networkDestinationAsn` | `number` | no | no | in place |
| `network_destination_cidr_block` | `networkDestinationCidrBlock` | `string` | no | no | in place |
| `network_destination_i_pv4` | `networkDestinationIPv4` | `string` | no | no | in place |
| `network_destination_i_pv6` | `networkDestinationIPv6` | `string` | no | no | in place |
| `network_destination_port` | `networkDestinationPort` | `number` | no | no | in place |
| `network_i_pv4` | `networkIPv4` | `string` | no | no | in place |
| `network_i_pv6` | `networkIPv6` | `string` | no | no | in place |
| `network_port` | `networkPort` | `number` | no | no | in place |
| `network_protocol` | `networkProtocol` | `number` | no | no | in place |
| `network_source_asn` | `networkSourceAsn` | `number` | no | no | in place |
| `network_source_cidr_block` | `networkSourceCidrBlock` | `string` | no | no | in place |
| `network_source_i_pv4` | `networkSourceIPv4` | `string` | no | no | in place |
| `network_source_i_pv6` | `networkSourceIPv6` | `string` | no | no | in place |
| `network_source_port` | `networkSourcePort` | `number` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `passive_only` | `passiveOnly` | `bool` | no | no | in place |
| `severity` | `severity` | `number` | no | no | in place |
| `tags` | `tags` | `list(string)` | no | no | in place |
| `target_product` | `targetProduct` | `string` | no | no | in place |
| `threat_type` | `threatType` | `string` | no | no | in place |
| `tlp_level` | `tlpLevel` | `string` | no | no | in place |
| `url` | `url` | `string` | no | no | in place |
| `user_agent` | `userAgent` | `string` | no | no | in place |
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

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
