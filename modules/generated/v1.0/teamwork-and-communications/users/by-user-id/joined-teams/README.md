# /users/{user-id}/joinedTeams

Create new navigation property to joinedTeams for users

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/team?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/joinedTeams`, `GET/PATCH/DELETE /users/{user-id}/joinedTeams/{team-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/teamwork-and-communications/users/by-user-id/joined-teams?ref=<release-tag>"
  user_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no |
| `all_channels` | `allChannels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(string)       members = optional(any)       membershipType = optional(string)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.channelSummary")       guestsCount = optional(number)       hasMembersFromOtherTenants = optional(bool)       membersCount = optional(number)       ownersCount = optional(number)     }))       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")       contentUrl = optional(string)       entityId = optional(string)       removeUrl = optional(string)       websiteUrl = optional(string)     }))       displayName = optional(string)       teamsApp = optional(any)     })))       tenantId = optional(string)     }))` | no | no |
| `channels` | `channels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(string)       members = optional(any)       membershipType = optional(string)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.channelSummary")       guestsCount = optional(number)       hasMembersFromOtherTenants = optional(bool)       membersCount = optional(number)       ownersCount = optional(number)     }))       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")       contentUrl = optional(string)       entityId = optional(string)       removeUrl = optional(string)       websiteUrl = optional(string)     }))       displayName = optional(string)       teamsApp = optional(any)     })))       tenantId = optional(string)     }))` | no | no |
| `classification` | `classification` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `first_channel_name` | `firstChannelName` | `string` | no | no |
| `fun_settings` | `funSettings` | `object({       odata_type = optional(string, "#microsoft.graph.teamFunSettings")       allowCustomMemes = optional(bool)       allowGiphy = optional(bool)       allowStickersAndMemes = optional(bool)       giphyContentRating = optional(string)     })` | no | no |
| `group` | `group` | `any` | no | no |
| `guest_settings` | `guestSettings` | `object({       odata_type = optional(string, "#microsoft.graph.teamGuestSettings")       allowCreateUpdateChannels = optional(bool)       allowDeleteChannels = optional(bool)     })` | no | no |
| `incoming_channels` | `incomingChannels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(any)       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(string)       members = optional(any)       membershipType = optional(string)       messages = optional(any)       migrationMode = optional(string)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(object({       odata_type = optional(string, "#microsoft.graph.channelSummary")       guestsCount = optional(number)       hasMembersFromOtherTenants = optional(bool)       membersCount = optional(number)       ownersCount = optional(number)     }))       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")       contentUrl = optional(string)       entityId = optional(string)       removeUrl = optional(string)       websiteUrl = optional(string)     }))       displayName = optional(string)       teamsApp = optional(any)     })))       tenantId = optional(string)     }))` | no | no |
| `installed_apps` | `installedApps` | `any` | no | no |
| `internal_id` | `internalId` | `string` | no | no |
| `member_settings` | `memberSettings` | `object({       odata_type = optional(string, "#microsoft.graph.teamMemberSettings")       allowAddRemoveApps = optional(bool)       allowCreatePrivateChannels = optional(bool)       allowCreateUpdateChannels = optional(bool)       allowCreateUpdateRemoveConnectors = optional(bool)       allowCreateUpdateRemoveTabs = optional(bool)       allowDeleteChannels = optional(bool)     })` | no | no |
| `members` | `members` | `any` | no | no |
| `messaging_settings` | `messagingSettings` | `object({       odata_type = optional(string, "#microsoft.graph.teamMessagingSettings")       allowChannelMentions = optional(bool)       allowOwnerDeleteMessages = optional(bool)       allowTeamMentions = optional(bool)       allowUserDeleteMessages = optional(bool)       allowUserEditMessages = optional(bool)     })` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAsyncOperation")       attemptsCount = optional(number)       createdDateTime = optional(string)       error = optional(object({       odata_type = optional(string, "#microsoft.graph.operationError")       code = optional(string)       message = optional(string)     }))       lastActionDateTime = optional(string)       operationType = optional(string)       status = optional(string)       targetResourceId = optional(string)       targetResourceLocation = optional(string)     }))` | no | no |
| `permission_grants` | `permissionGrants` | `list(object({       odata_type = optional(string, "#microsoft.graph.resourceSpecificPermissionGrant")       deletedDateTime = optional(string)     }))` | no | no |
| `photo` | `photo` | `any` | no | no |
| `primary_channel` | `primaryChannel` | `any` | no | no |
| `schedule` | `schedule` | `any` | no | no |
| `specialization` | `specialization` | `string` | no | no |
| `summary` | `summary` | `object({       odata_type = optional(string, "#microsoft.graph.teamSummary")       guestsCount = optional(number)       membersCount = optional(number)       ownersCount = optional(number)     })` | no | no |
| `tags` | `tags` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTag")       description = optional(string)       displayName = optional(string)       memberCount = optional(number)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamworkTagMember")       displayName = optional(string)       tenantId = optional(string)       userId = optional(string)     })))       tagType = optional(string)       teamId = optional(string)     }))` | no | no |
| `template` | `template` | `any` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `visibility` | `visibility` | `string` | no | no |
| `web_url` | `webUrl` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- allChannels[].allMembers[]: polymorphic schema; accepts an untyped value
- allChannels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].filesFolder: navigation property; accepts an untyped value
- allChannels[].members[]: polymorphic schema; accepts an untyped value
- allChannels[].messages[]: polymorphic schema; accepts an untyped value
- allChannels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- allChannels[].sharedWithTeams[].team: navigation property; accepts an untyped value
- allChannels[].tabs[].teamsApp: navigation property; accepts an untyped value
- channels[].allMembers[]: polymorphic schema; accepts an untyped value
- channels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].filesFolder: navigation property; accepts an untyped value
- channels[].members[]: polymorphic schema; accepts an untyped value
- channels[].messages[]: polymorphic schema; accepts an untyped value
- channels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- channels[].sharedWithTeams[].team: navigation property; accepts an untyped value
- channels[].tabs[].teamsApp: navigation property; accepts an untyped value
- group: navigation property; accepts an untyped value
- incomingChannels[].allMembers[]: polymorphic schema; accepts an untyped value
- incomingChannels[].enabledApps[].appDefinitions[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].filesFolder: navigation property; accepts an untyped value
- incomingChannels[].members[]: polymorphic schema; accepts an untyped value
- incomingChannels[].messages[]: polymorphic schema; accepts an untyped value
- incomingChannels[].sharedWithTeams[].allowedMembers[]: nested schema exceeds depth limit; accepts an untyped value
- incomingChannels[].sharedWithTeams[].team: navigation property; accepts an untyped value
- incomingChannels[].tabs[].teamsApp: navigation property; accepts an untyped value
- installedApps[]: polymorphic schema; accepts an untyped value
- members[]: polymorphic schema; accepts an untyped value
- photo: navigation property; accepts an untyped value
- primaryChannel: navigation property; accepts an untyped value
- schedule: navigation property; accepts an untyped value
- template: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
