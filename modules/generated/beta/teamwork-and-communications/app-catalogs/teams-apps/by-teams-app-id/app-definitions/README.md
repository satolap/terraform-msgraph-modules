# /appCatalogs/teamsApps/{teamsApp-id}/appDefinitions

Update teamsApp

[Catalog](../../../../../README.md) · [Teamwork and communications](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /appCatalogs/teamsApps/{teamsApp-id}/appDefinitions`, `GET/PATCH/DELETE /appCatalogs/teamsApps/{teamsApp-id}/appDefinitions/{teamsAppDefinition-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/app-catalogs/teams-apps/by-teams-app-id/app-definitions"
  teams_app_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `teams_app_id` | URL parameter `teamsApp-id` | `string` | yes | no |
| `allowed_installation_scopes` | `allowedInstallationScopes` | `any` | no | no |
| `authorization` | `authorization` | `any` | no | no |
| `azure_ad_app_id` | `azureADAppId` | `string` | no | no |
| `bot` | `bot` | `any` | no | no |
| `color_icon` | `colorIcon` | `any` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `dashboard_cards` | `dashboardCards` | `list(object({       odata_type = optional(string, "#microsoft.graph.teamsAppDashboardCardDefinition")       contentSource = optional(any)       defaultSize = optional(any)       description = optional(string)       displayName = optional(string)       icon = optional(any)       pickerGroupId = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `graph_version` | `version` | `string` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `outline_icon` | `outlineIcon` | `any` | no | no |
| `publishing_state` | `publishingState` | `any` | no | no |
| `shortdescription` | `shortdescription` | `string` | no | no |
| `teams_app_id_2` | `teamsAppId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- allowedInstallationScopes: polymorphic schema; accepts an untyped value
- authorization: polymorphic schema; accepts an untyped value
- bot: polymorphic schema; accepts an untyped value
- colorIcon: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- dashboardCards[].contentSource: polymorphic schema; accepts an untyped value
- dashboardCards[].defaultSize: polymorphic schema; accepts an untyped value
- dashboardCards[].icon: polymorphic schema; accepts an untyped value
- outlineIcon: polymorphic schema; accepts an untyped value
- publishingState: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
