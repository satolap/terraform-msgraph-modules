# /teamwork/deletedTeams/{deletedTeam-id}/channels

Create new navigation property to channels for teamwork

[Catalog](../../../../../README.md) · [Teamwork and communications](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/channel?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teamwork/deletedTeams/{deletedTeam-id}/channels`, `GET/PATCH/DELETE /teamwork/deletedTeams/{deletedTeam-id}/channels/{channel-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/teamwork/deleted-teams/by-deleted-team-id/channels"
  deleted_team_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `deleted_team_id` | URL parameter `deletedTeam-id` | `string` | yes | no |
| `all_members` | `allMembers` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enabled_apps` | `enabledApps` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppDefinition")       authorization = optional(any)       bot = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       publishingState = optional(any)       shortDescription = optional(string)       teamsAppId = optional(string)       version = optional(string)     })))       displayName = optional(string)       externalId = optional(string)     }))` | no | no |
| `files_folder` | `filesFolder` | `any` | no | no |
| `is_favorite_by_default` | `isFavoriteByDefault` | `bool` | no | no |
| `layout_type` | `layoutType` | `any` | no | no |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     }))` | no | no |
| `membership_type` | `membershipType` | `any` | no | no |
| `messages` | `messages` | `list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageAttachment")       content = optional(string)       contentType = optional(string)       contentUrl = optional(string)       name = optional(string)       teamsAppId = optional(string)       thumbnailUrl = optional(string)     })))       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hostedContents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHostedContent")       contentBytes = optional(string)       contentType = optional(string)     })))       importance = optional(string)       locale = optional(string)       mentions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageMention")       id = optional(number)       mentionText = optional(string)       mentioned = optional(any)     })))       messageHistory = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageHistoryItem")       actions = optional(string)       modifiedDateTime = optional(string)       reaction = optional(any)     })))       messageType = optional(string)       policyViolation = optional(any)       reactions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReaction")       createdDateTime = optional(string)       displayName = optional(string)       reactionContentUrl = optional(string)       reactionType = optional(string)       user = optional(object({       odata_type = optional(string, "#microsoft.graph.chatMessageReactionIdentitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     })))       replies = optional(any)       subject = optional(string)       summary = optional(string)     }))` | no | no |
| `migration_mode` | `migrationMode` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `original_created_date_time` | `originalCreatedDateTime` | `string` | no | no |
| `shared_with_teams` | `sharedWithTeams` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     }))` | no | no |
| `summary` | `summary` | `any` | no | no |
| `tabs` | `tabs` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       teamsApp = optional(any)     }))` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- enabledApps[].appDefinitions[].authorization: polymorphic schema; accepts an untyped value
- enabledApps[].appDefinitions[].bot: polymorphic schema; accepts an untyped value
- enabledApps[].appDefinitions[].createdBy: polymorphic schema; accepts an untyped value
- enabledApps[].appDefinitions[].publishingState: polymorphic schema; accepts an untyped value
- filesFolder: polymorphic schema; accepts an untyped value
- layoutType: polymorphic schema; accepts an untyped value
- membershipType: polymorphic schema; accepts an untyped value
- messages[].body.contentType: polymorphic schema; accepts an untyped value
- messages[].channelIdentity: polymorphic schema; accepts an untyped value
- messages[].from: polymorphic schema; accepts an untyped value
- messages[].mentions[].mentioned: polymorphic schema; accepts an untyped value
- messages[].messageHistory[].reaction: polymorphic schema; accepts an untyped value
- messages[].policyViolation: polymorphic schema; accepts an untyped value
- messages[].reactions[].user.application: polymorphic schema; accepts an untyped value
- messages[].reactions[].user.device: polymorphic schema; accepts an untyped value
- messages[].reactions[].user.user: polymorphic schema; accepts an untyped value
- messages[].replies[]: recursive schema; accepts an untyped value
- migrationMode: polymorphic schema; accepts an untyped value
- sharedWithTeams[].team: polymorphic schema; accepts an untyped value
- summary: polymorphic schema; accepts an untyped value
- tabs[].configuration: polymorphic schema; accepts an untyped value
- tabs[].teamsApp: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
