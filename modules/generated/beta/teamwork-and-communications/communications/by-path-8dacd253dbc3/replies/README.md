# /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}/starter/replies

Create new navigation property to replies for communications

[Catalog](../../../../README.md) · [Teamwork and communications](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}/starter/replies`, `GET/PATCH/DELETE /communications/onlineMeetingConversations/{onlineMeetingEngagementConversation-id}/starter/replies/{engagementConversationMessage-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/beta/teamwork-and-communications/communications/by-path-8dacd253dbc3/replies?ref=<release-tag>"
  online_meeting_engagement_conversation_id = "parent-object-id"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `online_meeting_engagement_conversation_id` | URL parameter `onlineMeetingEngagementConversation-id` | `string` | yes | no |
| `body` | `body` | `object({       odata_type = optional(string, "#microsoft.graph.itemBody")       content = optional(string)       contentType = optional(string)     })` | no | no |
| `conversation` | `conversation` | `any` | no | no |
| `creation_mode` | `creationMode` | `string` | no | no |
| `from` | `from` | `object({       odata_type = optional(string, "#microsoft.graph.engagementIdentitySet")       application = optional(any)       audience = optional(any)       device = optional(any)       group = optional(any)       user = optional(any)     })` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `reactions` | `reactions` | `list(object({       odata_type = optional(string, "#microsoft.graph.engagementConversationMessageReaction")     }))` | no | no |
| `replies` | `replies` | `any` | no | no |
| `reply_to` | `replyTo` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- conversation: polymorphic schema; accepts an untyped value
- from.application: polymorphic schema; accepts an untyped value
- from.audience: polymorphic schema; accepts an untyped value
- from.device: polymorphic schema; accepts an untyped value
- from.group: polymorphic schema; accepts an untyped value
- from.user: polymorphic schema; accepts an untyped value
- replies[]: polymorphic schema; accepts an untyped value
- replyTo: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
