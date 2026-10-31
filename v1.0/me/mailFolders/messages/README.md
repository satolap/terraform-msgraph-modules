# /me/mailFolders/{mailFolder-id}/messages

Create message in a mailfolder

[Catalog](../../../README.md) Â· [Mail](../../../README.md#mail) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /me/mailFolders/{mailFolder-id}/messages`, `GET/PATCH/DELETE /me/mailFolders/{mailFolder-id}/messages/{message-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/me/mailFolders/messages"
  version = "<version>"

  mailFolder-id = "parent-object-id"
}
```

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

Select-only inputs: `uniqueBody`.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `mailFolder-id` | URL parameter `mailFolder-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `attachments` | `attachments` | `any` | no | no | in place |
| `bccRecipients` | `bccRecipients` | `any` | no | no | in place |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no | in place |
| `bodyPreview` | `bodyPreview` | `string` | no | no | in place |
| `categories` | `categories` | `list(string)` | no | no | in place |
| `ccRecipients` | `ccRecipients` | `any` | no | no | in place |
| `conversationId` | `conversationId` | `string` | no | no | in place |
| `conversationIndex` | `conversationIndex` | `string` | no | no | in place |
| `createdDateTime` | `createdDateTime` | `string` | no | no | in place |
| `extensions` | `extensions` | `any` | no | no | in place |
| `flag` | `flag` | `object({       odata_type = optional(string, "#microsoft.graph.followupFlag")       completedDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       dueDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       flagStatus = optional(string)       startDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))     })` | no | no | in place |
| `from` | `from` | `any` | no | no | in place |
| `hasAttachments` | `hasAttachments` | `bool` | no | no | in place |
| `importance` | `importance` | `string` | no | no | in place |
| `inferenceClassification` | `inferenceClassification` | `string` | no | no | in place |
| `internetMessageId` | `internetMessageId` | `string` | no | no | in place |
| `isDeliveryReceiptRequested` | `isDeliveryReceiptRequested` | `bool` | no | no | in place |
| `isDraft` | `isDraft` | `bool` | no | no | in place |
| `isRead` | `isRead` | `bool` | no | no | in place |
| `isReadReceiptRequested` | `isReadReceiptRequested` | `bool` | no | no | in place |
| `lastModifiedDateTime` | `lastModifiedDateTime` | `string` | no | no | in place |
| `multiValueExtendedProperties` | `multiValueExtendedProperties` | `list(object({       odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")       value = optional(list(string))     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `parentFolderId` | `parentFolderId` | `string` | no | no | in place |
| `receivedDateTime` | `receivedDateTime` | `string` | no | no | in place |
| `replyTo` | `replyTo` | `any` | no | no | in place |
| `sender` | `sender` | `any` | no | no | in place |
| `sentDateTime` | `sentDateTime` | `string` | no | no | in place |
| `singleValueExtendedProperties` | `singleValueExtendedProperties` | `list(object({       odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")       value = optional(string)     }))` | no | no | in place |
| `subject` | `subject` | `string` | no | no | in place |
| `toRecipients` | `toRecipients` | `any` | no | no | in place |
| `uniqueBody` | `uniqueBody` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no | in place |
| `webLink` | `webLink` | `string` | no | no | in place |
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

Server-assigned properties in `response`: `changeKey`, `id`, `internetMessageHeaders`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /me/mailFolders/{mailFolder-id}/messages` | DelegatedWork | `Mail.ReadWrite` | — |
| `POST /me/mailFolders/{mailFolder-id}/messages` | DelegatedPersonal | `Mail.ReadWrite` | — |
| `POST /me/mailFolders/{mailFolder-id}/messages` | Application | `Mail.ReadWrite` | — |
| `GET /me/mailFolders/{mailFolder-id}/messages/{message-id}` | DelegatedWork | `Mail.Read` | — |
| `GET /me/mailFolders/{mailFolder-id}/messages/{message-id}` | DelegatedPersonal | `Mail.Read` | — |
| `GET /me/mailFolders/{mailFolder-id}/messages/{message-id}` | Application | `Mail.Read` | — |
| `PATCH /me/mailFolders/{mailFolder-id}/messages/{message-id}` | DelegatedWork | `Mail.ReadWrite` | — |
| `PATCH /me/mailFolders/{mailFolder-id}/messages/{message-id}` | DelegatedPersonal | `Mail.ReadWrite` | — |
| `PATCH /me/mailFolders/{mailFolder-id}/messages/{message-id}` | Application | `Mail.ReadWrite` | — |
| `DELETE /me/mailFolders/{mailFolder-id}/messages/{message-id}` | DelegatedWork | `Mail.ReadWrite` | — |
| `DELETE /me/mailFolders/{mailFolder-id}/messages/{message-id}` | DelegatedPersonal | `Mail.ReadWrite` | — |
| `DELETE /me/mailFolders/{mailFolder-id}/messages/{message-id}` | Application | `Mail.ReadWrite` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- attachments[]: polymorphic schema; accepts an untyped value
- bccRecipients[]: polymorphic schema; accepts an untyped value
- ccRecipients[]: polymorphic schema; accepts an untyped value
- extensions[]: polymorphic schema; accepts an untyped value
- from: polymorphic schema; accepts an untyped value
- replyTo[]: polymorphic schema; accepts an untyped value
- sender: polymorphic schema; accepts an untyped value
- toRecipients[]: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
