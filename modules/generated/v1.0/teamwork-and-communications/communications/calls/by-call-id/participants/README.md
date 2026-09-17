# /communications/calls/{call-id}/participants

Create new navigation property to participants for communications

[Catalog](../../../../../README.md) · [Teamwork and communications](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/participant?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /communications/calls/{call-id}/participants`, `GET/PATCH/DELETE /communications/calls/{call-id}/participants/{participant-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/communications/calls/by-call-id/participants"
  call_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `call_id` | URL parameter `call-id` | `string` | yes | no |
| `info` | `info` | `object({       odata_type = optional(string, "#microsoft.graph.participantInfo")       identity = optional(object({       odata_type = optional(string, "#microsoft.graph.identitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     })` | no | no |
| `is_in_lobby` | `isInLobby` | `bool` | no | no |
| `is_muted` | `isMuted` | `bool` | no | no |
| `media_streams` | `mediaStreams` | `list(object({       odata_type = optional(string, "#microsoft.graph.mediaStream")       direction = optional(string)       label = optional(string)       mediaType = optional(string)       serverMuted = optional(bool)       sourceId = optional(string)     }))` | no | no |
| `metadata` | `metadata` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `recording_info` | `recordingInfo` | `any` | no | no |
| `removed_state` | `removedState` | `any` | no | no |
| `restricted_experience` | `restrictedExperience` | `any` | no | no |
| `roster_sequence_number` | `rosterSequenceNumber` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- info.identity.application: polymorphic schema; accepts an untyped value
- info.identity.device: polymorphic schema; accepts an untyped value
- info.identity.user: polymorphic schema; accepts an untyped value
- recordingInfo: polymorphic schema; accepts an untyped value
- removedState: polymorphic schema; accepts an untyped value
- restrictedExperience: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
