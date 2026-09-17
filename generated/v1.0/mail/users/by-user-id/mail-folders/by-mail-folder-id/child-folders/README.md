# /users/{user-id}/mailFolders/{mailFolder-id}/childFolders

Create new navigation property to childFolders for users

[Catalog](../../../../../../README.md) · [Mail](../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/mailfolder?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/mailFolders/{mailFolder-id}/childFolders`, `GET/PATCH/DELETE /users/{user-id}/mailFolders/{mailFolder-id}/childFolders/{mailFolder-id1}`.

## Usage

```hcl
module "graph_resource" {
  source = "./mail/users/by-user-id/mail-folders/by-mail-folder-id/child-folders"
  user_id = "parent-object-id"
  mail_folder_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `mail_folder_id` | URL parameter `mailFolder-id` | `string` | yes | no |
| `child_folder_count` | `childFolderCount` | `number` | no | no |
| `child_folders` | `childFolders` | `list(object({       odata_type = optional(string, "#microsoft.graph.mailFolder")       childFolderCount = optional(number)       childFolders = optional(any)       displayName = optional(string)       isHidden = optional(bool)       messageRules = optional(list(object({       odata_type = optional(string, "#microsoft.graph.messageRule")       actions = optional(any)       conditions = optional(any)       displayName = optional(string)       exceptions = optional(any)       isEnabled = optional(bool)       sequence = optional(number)     })))       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.message")       attachments = optional(any)       bccRecipients = optional(any)       body = optional(any)       bodyPreview = optional(string)       categories = optional(list(string))       ccRecipients = optional(any)       conversationId = optional(string)       conversationIndex = optional(string)       createdDateTime = optional(string)       extensions = optional(any)       flag = optional(any)       from = optional(any)       hasAttachments = optional(bool)       importance = optional(any)       inferenceClassification = optional(any)       internetMessageId = optional(string)       isDeliveryReceiptRequested = optional(bool)       isDraft = optional(bool)       isRead = optional(bool)       isReadReceiptRequested = optional(bool)       lastModifiedDateTime = optional(string)       multiValueExtendedProperties = optional(any)       parentFolderId = optional(string)       receivedDateTime = optional(string)       replyTo = optional(any)       sender = optional(any)       sentDateTime = optional(string)       singleValueExtendedProperties = optional(any)       subject = optional(string)       toRecipients = optional(any)       uniqueBody = optional(any)       webLink = optional(string)     })))       parentFolderId = optional(string)       totalItemCount = optional(number)       unreadItemCount = optional(number)     }))` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_hidden` | `isHidden` | `bool` | no | no |
| `message_rules` | `messageRules` | `list(object({       odata_type = optional(string, "#microsoft.graph.messageRule")       actions = optional(any)       conditions = optional(any)       displayName = optional(string)       exceptions = optional(any)       isEnabled = optional(bool)       sequence = optional(number)     }))` | no | no |
| `messages` | `messages` | `list(object({       odata_type = optional(string, "#microsoft.graph.message")       attachments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.attachment")       contentType = optional(string)       isInline = optional(bool)       lastModifiedDateTime = optional(string)       name = optional(string)       size = optional(number)     })))       bccRecipients = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       body = optional(any)       bodyPreview = optional(string)       categories = optional(list(string))       ccRecipients = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       conversationId = optional(string)       conversationIndex = optional(string)       createdDateTime = optional(string)       extensions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.extension")     })))       flag = optional(any)       from = optional(any)       hasAttachments = optional(bool)       importance = optional(any)       inferenceClassification = optional(any)       internetMessageId = optional(string)       isDeliveryReceiptRequested = optional(bool)       isDraft = optional(bool)       isRead = optional(bool)       isReadReceiptRequested = optional(bool)       lastModifiedDateTime = optional(string)       multiValueExtendedProperties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.multiValueLegacyExtendedProperty")       value = optional(list(string))     })))       parentFolderId = optional(string)       receivedDateTime = optional(string)       replyTo = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       sender = optional(any)       sentDateTime = optional(string)       singleValueExtendedProperties = optional(list(object({       odata_type = optional(string, "#microsoft.graph.singleValueLegacyExtendedProperty")       value = optional(string)     })))       subject = optional(string)       toRecipients = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recipient")       emailAddress = optional(any)     })))       uniqueBody = optional(any)       webLink = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `parent_folder_id` | `parentFolderId` | `string` | no | no |
| `total_item_count` | `totalItemCount` | `number` | no | no |
| `unread_item_count` | `unreadItemCount` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`, `includeHiddenFolders`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- childFolders[].childFolders[]: recursive schema; accepts an untyped value
- childFolders[].messageRules[].actions: polymorphic schema; accepts an untyped value
- childFolders[].messageRules[].conditions: polymorphic schema; accepts an untyped value
- childFolders[].messageRules[].exceptions: polymorphic schema; accepts an untyped value
- childFolders[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].bccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].body: polymorphic schema; accepts an untyped value
- childFolders[].messages[].ccRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].extensions[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].flag: polymorphic schema; accepts an untyped value
- childFolders[].messages[].from: polymorphic schema; accepts an untyped value
- childFolders[].messages[].importance: polymorphic schema; accepts an untyped value
- childFolders[].messages[].inferenceClassification: polymorphic schema; accepts an untyped value
- childFolders[].messages[].multiValueExtendedProperties[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].replyTo[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].sender: polymorphic schema; accepts an untyped value
- childFolders[].messages[].singleValueExtendedProperties[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].toRecipients[]: nested schema exceeds depth limit; accepts an untyped value
- childFolders[].messages[].uniqueBody: polymorphic schema; accepts an untyped value
- messageRules[].actions: polymorphic schema; accepts an untyped value
- messageRules[].conditions: polymorphic schema; accepts an untyped value
- messageRules[].exceptions: polymorphic schema; accepts an untyped value
- messages[].bccRecipients[].emailAddress: polymorphic schema; accepts an untyped value
- messages[].body: polymorphic schema; accepts an untyped value
- messages[].ccRecipients[].emailAddress: polymorphic schema; accepts an untyped value
- messages[].flag: polymorphic schema; accepts an untyped value
- messages[].from: polymorphic schema; accepts an untyped value
- messages[].importance: polymorphic schema; accepts an untyped value
- messages[].inferenceClassification: polymorphic schema; accepts an untyped value
- messages[].replyTo[].emailAddress: polymorphic schema; accepts an untyped value
- messages[].sender: polymorphic schema; accepts an untyped value
- messages[].toRecipients[].emailAddress: polymorphic schema; accepts an untyped value
- messages[].uniqueBody: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
