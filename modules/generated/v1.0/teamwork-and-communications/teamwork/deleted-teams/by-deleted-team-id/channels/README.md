# /teamwork/deletedTeams/{deletedTeam-id}/channels

Create new navigation property to channels for teamwork

[Catalog](../../../../../README.md) · [Teamwork and communications](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/channel?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teamwork/deletedTeams/{deletedTeam-id}/channels`, `GET/PATCH/DELETE /teamwork/deletedTeams/{deletedTeam-id}/channels/{channel-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/teamwork-and-communications/teamwork/deleted-teams/by-deleted-team-id/channels?ref=<release-tag>"
  deleted_team_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `deleted_team_id` | URL parameter `deletedTeam-id` | `string` | yes | no |
| `all_members` | `allMembers` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `enabled_apps` | `enabledApps` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsApp")       appDefinitions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppDefinition")       authorization = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsAppAuthorization")       clientAppId = optional(string)       requiredPermissionSet = optional(any)     }))       bot = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       lastModifiedDateTime = optional(string)       publishingState = optional(string)       shortDescription = optional(string)       teamsAppId = optional(string)       version = optional(string)     })))       displayName = optional(string)       externalId = optional(string)     }))` | no | no |
| `files_folder` | `filesFolder` | `any` | no | no |
| `is_favorite_by_default` | `isFavoriteByDefault` | `bool` | no | no |
| `layout_type` | `layoutType` | `string` | no | no |
| `members` | `members` | `any` | no | no |
| `membership_type` | `membershipType` | `string` | no | no |
| `messages` | `messages` | `any` | no | no |
| `migration_mode` | `migrationMode` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `original_created_date_time` | `originalCreatedDateTime` | `string` | no | no |
| `shared_with_teams` | `sharedWithTeams` | `list(object({       odata_type = optional(string, "#microsoft.graph.sharedWithChannelTeamInfo")       allowedMembers = optional(any)       displayName = optional(string)       isHostTeam = optional(bool)       team = optional(any)       tenantId = optional(string)     }))` | no | no |
| `summary` | `summary` | `object({       odata_type = optional(string, "#microsoft.graph.channelSummary")       guestsCount = optional(number)       hasMembersFromOtherTenants = optional(bool)       membersCount = optional(number)       ownersCount = optional(number)     })` | no | no |
| `tabs` | `tabs` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsTab")       configuration = optional(object({       odata_type = optional(string, "#microsoft.graph.teamsTabConfiguration")       contentUrl = optional(string)       entityId = optional(string)       removeUrl = optional(string)       websiteUrl = optional(string)     }))       displayName = optional(string)       teamsApp = optional(any)     }))` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- allMembers[]: polymorphic schema; accepts an untyped value
- enabledApps[].appDefinitions[].authorization.requiredPermissionSet: nested schema exceeds depth limit; accepts an untyped value
- enabledApps[].appDefinitions[].bot: navigation property; accepts an untyped value
- enabledApps[].appDefinitions[].createdBy: polymorphic schema; accepts an untyped value
- filesFolder: navigation property; accepts an untyped value
- members[]: polymorphic schema; accepts an untyped value
- messages[]: polymorphic schema; accepts an untyped value
- sharedWithTeams[].allowedMembers[]: polymorphic schema; accepts an untyped value
- sharedWithTeams[].team: navigation property; accepts an untyped value
- tabs[].teamsApp: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
