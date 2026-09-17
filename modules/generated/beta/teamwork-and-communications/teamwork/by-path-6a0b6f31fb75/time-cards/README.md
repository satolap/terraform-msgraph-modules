# /teamwork/teamTemplates/{teamTemplate-id}/definitions/{teamTemplateDefinition-id}/teamDefinition/schedule/timeCards

Create new navigation property to timeCards for teamwork

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/timecard?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /teamwork/teamTemplates/{teamTemplate-id}/definitions/{teamTemplateDefinition-id}/teamDefinition/schedule/timeCards`, `GET/PATCH/DELETE /teamwork/teamTemplates/{teamTemplate-id}/definitions/{teamTemplateDefinition-id}/teamDefinition/schedule/timeCards/{timeCard-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/teamwork/by-path-6a0b6f31fb75/time-cards"
  team_template_id = "parent-object-id"
  team_template_definition_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `team_template_id` | URL parameter `teamTemplate-id` | `string` | yes | no |
| `team_template_definition_id` | URL parameter `teamTemplateDefinition-id` | `string` | yes | no |
| `breaks` | `breaks` | `list(object({       odata_type = optional(string, "#microsoft.graph.timeCardBreak")       breakId = optional(string)       end = optional(any)       notes = optional(any)       start = optional(object({       odata_type = optional(string, "#microsoft.graph.timeCardEvent")       atApprovedLocation = optional(bool)       dateTime = optional(string)       isAtApprovedLocation = optional(bool)       notes = optional(any)     }))     }))` | no | no |
| `clock_in_event` | `clockInEvent` | `any` | no | no |
| `clock_out_event` | `clockOutEvent` | `any` | no | no |
| `confirmed_by` | `confirmedBy` | `any` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `notes` | `notes` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `original_entry` | `originalEntry` | `any` | no | no |
| `state` | `state` | `any` | no | no |
| `user_id` | `userId` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- breaks[].end: polymorphic schema; accepts an untyped value
- breaks[].notes: polymorphic schema; accepts an untyped value
- breaks[].start.notes: polymorphic schema; accepts an untyped value
- clockInEvent: polymorphic schema; accepts an untyped value
- clockOutEvent: polymorphic schema; accepts an untyped value
- confirmedBy: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- notes: polymorphic schema; accepts an untyped value
- originalEntry: polymorphic schema; accepts an untyped value
- state: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
