# /me/mailFolders/{mailFolder-id}/childFolders/{mailFolder-id1}/messages

Create new navigation property to messages for me

[Catalog](../../../../../../../README.md) · [Mail](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /me/mailFolders/{mailFolder-id}/childFolders/{mailFolder-id1}/messages`, `GET/PATCH/DELETE /me/mailFolders/{mailFolder-id}/childFolders/{mailFolder-id1}/messages/{message-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/mail/me/mail-folders/by-mail-folder-id/child-folders/by-mail-folder-id1/messages?ref=<release-tag>"
  mail_folder_id = "parent-object-id"
  mail_folder_id1 = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `mail_folder_id` | URL parameter `mailFolder-id` | `string` | yes | no |
| `mail_folder_id1` | URL parameter `mailFolder-id1` | `string` | yes | no |
| `attachments` | `attachments` | `any` | no | no |
| `bcc_recipients` | `bccRecipients` | `any` | no | no |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no |
| `body_preview` | `bodyPreview` | `string` | no | no |
| `categories` | `categories` | `list(string)` | no | no |
| `cc_recipients` | `ccRecipients` | `any` | no | no |
| `conversation_id` | `conversationId` | `string` | no | no |
| `conversation_index` | `conversationIndex` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `extensions` | `extensions` | `any` | no | no |
| `flag` | `flag` | `object({       odata_type = optional(string, "#microsoft.graph.followupFlag")       completedDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       dueDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))       flagStatus = optional(string)       startDateTime = optional(object({       odata_type = optional(string, "#microsoft.graph.dateTimeTimeZone")       dateTime = optional(string)       timeZone = optional(string)     }))     })` | no | no |
| `from` | `from` | `any` | no | no |
| `has_attachments` | `hasAttachments` | `bool` | no | no |
| `importance` | `importance` | `string` | no | no |
| `inference_classification` | `inferenceClassification` | `string` | no | no |
| `internet_message_id` | `internetMessageId` | `string` | no | no |
| `is_delivery_receipt_requested` | `isDeliveryReceiptRequested` | `bool` | no | no |
| `is_draft` | `isDraft` | `bool` | no | no |
| `is_read` | `isRead` | `bool` | no | no |
| `is_read_receipt_requested` | `isReadReceiptRequested` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `mentions` | `mentions` | `list(object({       odata_type = optional(string, "#microsoft.graph.mention")       application = optional(string)       clientReference = optional(string)       createdBy = optional(any)       createdDateTime = optional(string)       deepLink = optional(string)       mentionText = optional(string)       mentioned = optional(any)       serverCreatedDateTime = optional(string)     }))` | no | no |
| `mentions_preview` | `mentionsPreview` | `object({       odata_type = optional(string, "#microsoft.graph.mentionsPreview")     })` | no | no |
| `multi_value_extended_properties` | `multiValueExtendedProperties` | `list(object({       odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")       value = optional(list(string))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `parent_folder_id` | `parentFolderId` | `string` | no | no |
| `received_date_time` | `receivedDateTime` | `string` | no | no |
| `reply_to` | `replyTo` | `any` | no | no |
| `sender` | `sender` | `any` | no | no |
| `sent_date_time` | `sentDateTime` | `string` | no | no |
| `single_value_extended_properties` | `singleValueExtendedProperties` | `list(object({       odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")       value = optional(string)     }))` | no | no |
| `subject` | `subject` | `string` | no | no |
| `to_recipients` | `toRecipients` | `any` | no | no |
| `unique_body` | `uniqueBody` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no |
| `unsubscribe_data` | `unsubscribeData` | `list(string)` | no | no |
| `unsubscribe_enabled` | `unsubscribeEnabled` | `bool` | no | no |
| `web_link` | `webLink` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- attachments[]: polymorphic schema; accepts an untyped value
- bccRecipients[]: polymorphic schema; accepts an untyped value
- ccRecipients[]: polymorphic schema; accepts an untyped value
- extensions[]: polymorphic schema; accepts an untyped value
- from: polymorphic schema; accepts an untyped value
- mentions[].createdBy: polymorphic schema; accepts an untyped value
- mentions[].mentioned: polymorphic schema; accepts an untyped value
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
