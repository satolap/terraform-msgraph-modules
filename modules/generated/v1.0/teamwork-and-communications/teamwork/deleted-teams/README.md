# /teamwork/deletedTeams

Create new navigation property to deletedTeams for teamwork

[Catalog](../../../README.md) · [Teamwork and communications](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teamwork/deletedTeams`, `GET/PATCH/DELETE /teamwork/deletedTeams/{deletedTeam-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/teamwork/deleted-teams"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `channels` | `channels` | `list(object({       odata_type = optional(string, "#microsoft.graph.channel")       allMembers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       description = optional(string)       displayName = optional(string)       enabledApps = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(any)       displayName = optional(string)       externalId = optional(string)     })))       filesFolder = optional(any)       isFavoriteByDefault = optional(bool)       layoutType = optional(any)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.conversationMember")       displayName = optional(string)       roles = optional(list(string))       visibleHistoryStartDateTime = optional(string)     })))       membershipType = optional(any)       messages = optional(list(object({       odata_type = optional(string, "#microsoft.graph.chatMessage")       attachments = optional(any)       body = optional(object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(any)     }))       channelIdentity = optional(any)       chatId = optional(string)       createdDateTime = optional(string)       from = optional(any)       hostedContents = optional(any)       importance = optional(string)       locale = optional(string)       mentions = optional(any)       messageHistory = optional(any)       messageType = optional(string)       policyViolation = optional(any)       reactions = optional(any)       replies = optional(any)       subject = optional(string)       summary = optional(string)     })))       migrationMode = optional(any)       originalCreatedDateTime = optional(string)       sharedWithTeams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     })))       summary = optional(any)       tabs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(any)       displayName = optional(string)       teamsApp = optional(any)     })))       tenantId = optional(string)     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

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

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
