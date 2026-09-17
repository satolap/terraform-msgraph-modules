# /users/{user-id}/joinedTeams

Create new navigation property to joinedTeams for users

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/team?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/joinedTeams`, `GET/PATCH/DELETE /users/{user-id}/joinedTeams/{team-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/users/by-user-id/joined-teams"
  user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `all_channels` | `allChannels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       membershipType = optional(any)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(any)       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       teamsApp = optional(any)     })))       tenantId = optional(string)     }))` | no | no |
| `channels` | `channels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       membershipType = optional(any)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(any)       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       teamsApp = optional(any)     })))       tenantId = optional(string)     }))` | no | no |
| `classification` | `classification` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `first_channel_name` | `firstChannelName` | `string` | no | no |
| `fun_settings` | `funSettings` | `any` | no | no |
| `group` | `group` | `any` | no | no |
| `guest_settings` | `guestSettings` | `any` | no | no |
| `incoming_channels` | `incomingChannels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       membershipType = optional(any)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(any)       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       teamsApp = optional(any)     })))       tenantId = optional(string)     }))` | no | no |
| `installed_apps` | `installedApps` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppInstallation")       consentedPermissionSet = optional(any)       teamsApp = optional(any)       teamsAppDefinition = optional(any)     }))` | no | no |
| `internal_id` | `internalId` | `string` | no | no |
| `member_settings` | `memberSettings` | `any` | no | no |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     }))` | no | no |
| `messaging_settings` | `messagingSettings` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(any)       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     }))` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `photo` | `photo` | `any` | no | no |
| `primary_channel` | `primaryChannel` | `any` | no | no |
| `schedule` | `schedule` | `any` | no | no |
| `specialization` | `specialization` | `any` | no | no |
| `summary` | `summary` | `any` | no | no |
| `tags` | `tags` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTag")       description = optional(string)       displayName = optional(string)       memberCount = optional(number)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTagMember")       displayName = optional(string)       tenantId = optional(string)       userId = optional(string)     })))       tagType = optional(any)       teamId = optional(string)     }))` | no | no |
| `template` | `template` | `any` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `visibility` | `visibility` | `any` | no | no |
| `web_url` | `webUrl` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- allChannels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].filesFolder: polymorphic schema; accepts an untyped value
- allChannels[].layoutType: polymorphic schema; accepts an untyped value
- allChannels[].membershipType: polymorphic schema; accepts an untyped value
- allChannels[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- allChannels[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- allChannels[].messages[].from: polymorphic schema; accepts an untyped value
- allChannels[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- allChannels[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].messages[].replies[]: recursive schema; accepts an untyped value
- allChannels[].migrationMode: polymorphic schema; accepts an untyped value
- allChannels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].sharedWithTeams[].team: polymorphic schema; accepts an untyped value
- allChannels[].summary: polymorphic schema; accepts an untyped value
- allChannels[].tabs[].configuration: polymorphic schema; accepts an untyped value
- allChannels[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- channels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].filesFolder: polymorphic schema; accepts an untyped value
- channels[].layoutType: polymorphic schema; accepts an untyped value
- channels[].membershipType: polymorphic schema; accepts an untyped value
- channels[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- channels[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- channels[].messages[].from: polymorphic schema; accepts an untyped value
- channels[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- channels[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].messages[].replies[]: recursive schema; accepts an untyped value
- channels[].migrationMode: polymorphic schema; accepts an untyped value
- channels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].sharedWithTeams[].team: polymorphic schema; accepts an untyped value
- channels[].summary: polymorphic schema; accepts an untyped value
- channels[].tabs[].configuration: polymorphic schema; accepts an untyped value
- channels[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- funSettings: polymorphic schema; accepts an untyped value
- group: polymorphic schema; accepts an untyped value
- guestSettings: polymorphic schema; accepts an untyped value
- incomingChannels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].filesFolder: polymorphic schema; accepts an untyped value
- incomingChannels[].layoutType: polymorphic schema; accepts an untyped value
- incomingChannels[].membershipType: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].attachments[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].body.contentType: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].channelIdentity: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].from: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].hostedContents[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].mentions[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].messageHistory[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].policyViolation: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[].reactions[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].messages[].replies[]: recursive schema; accepts an untyped value
- incomingChannels[].migrationMode: polymorphic schema; accepts an untyped value
- incomingChannels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].sharedWithTeams[].team: polymorphic schema; accepts an untyped value
- incomingChannels[].summary: polymorphic schema; accepts an untyped value
- incomingChannels[].tabs[].configuration: polymorphic schema; accepts an untyped value
- incomingChannels[].tabs[].teamsApp: polymorphic schema; accepts an untyped value
- installedApps[].consentedPermissionSet: polymorphic schema; accepts an untyped value
- installedApps[].teamsApp: polymorphic schema; accepts an untyped value
- installedApps[].teamsAppDefinition: polymorphic schema; accepts an untyped value
- memberSettings: polymorphic schema; accepts an untyped value
- messagingSettings: polymorphic schema; accepts an untyped value
- operations[].error: polymorphic schema; accepts an untyped value
- photo: polymorphic schema; accepts an untyped value
- primaryChannel: polymorphic schema; accepts an untyped value
- schedule: polymorphic schema; accepts an untyped value
- specialization: polymorphic schema; accepts an untyped value
- summary: polymorphic schema; accepts an untyped value
- tags[].tagType: polymorphic schema; accepts an untyped value
- template: polymorphic schema; accepts an untyped value
- visibility: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
