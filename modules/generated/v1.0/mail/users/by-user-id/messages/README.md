# /users/{user-id}/messages

Create new navigation property to messages for users

[Catalog](../../../../README.md) · [Mail](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/messages`, `GET/PATCH/DELETE /users/{user-id}/messages/{message-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/mail/users/by-user-id/messages?ref=<release-tag>"
  user_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
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
| `web_link` | `webLink` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`, `includeHiddenMessages`. This module manages an object; it does not implement listing or pagination.

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
