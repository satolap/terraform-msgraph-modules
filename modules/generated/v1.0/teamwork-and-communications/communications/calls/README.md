# /communications/calls

Create call

[Catalog](../../../README.md) · [Teamwork and communications](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/call?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /communications/calls`, `GET/PATCH/DELETE /communications/calls/{call-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/communications/calls"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `audio_routing_groups` | `audioRoutingGroups` | `list(object({       odata_type = optional(string, "#microsoft.graph.audioRoutingGroup")       receivers = optional(list(string))       routingMode = optional(string)       sources = optional(list(string))     }))` | no | no |
| `call_chain_id` | `callChainId` | `string` | no | no |
| `call_options` | `callOptions` | `any` | no | no |
| `callback_uri` | `callbackUri` | `string` | no | no |
| `chat_info` | `chatInfo` | `any` | no | no |
| `content_sharing_sessions` | `contentSharingSessions` | `list(object({       odata_type = optional(string, "#microsoft.graph.contentSharingSession")     }))` | no | no |
| `graph_source` | `source` | `any` | no | no |
| `incoming_context` | `incomingContext` | `any` | no | no |
| `media_config` | `mediaConfig` | `any` | no | no |
| `meeting_info` | `meetingInfo` | `any` | no | no |
| `my_participant_id` | `myParticipantId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `operations` | `operations` | `list(object({       odata_type = optional(string, "#microsoft.graph.commsOperation")       clientContext = optional(string)       status = optional(string)     }))` | no | no |
| `participants` | `participants` | `list(object({       odata_type = optional(string, "#microsoft.graph.participant")       info = optional(object({       odata_type = optional(string, "#microsoft.graph.participantInfo")       identity = optional(object({       odata_type = optional(string, "#microsoft.graph.identitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))     }))       isInLobby = optional(bool)       isMuted = optional(bool)       mediaStreams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.mediaStream")       direction = optional(string)       label = optional(string)       mediaType = optional(string)       serverMuted = optional(bool)       sourceId = optional(string)     })))       metadata = optional(string)       recordingInfo = optional(any)       removedState = optional(any)       restrictedExperience = optional(any)       rosterSequenceNumber = optional(number)     }))` | no | no |
| `requested_modalities` | `requestedModalities` | `any` | no | no |
| `subject` | `subject` | `string` | no | no |
| `targets` | `targets` | `list(object({       odata_type = optional(string, "#microsoft.graph.invitationParticipantInfo")       hidden = optional(bool)       identity = optional(object({       odata_type = optional(string, "#microsoft.graph.identitySet")       application = optional(any)       device = optional(any)       user = optional(any)     }))       participantId = optional(string)       removeFromDefaultAudioRoutingGroup = optional(bool)       replacesCallId = optional(string)     }))` | no | no |
| `tenant_id` | `tenantId` | `string` | no | no |
| `tone_info` | `toneInfo` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- callOptions: polymorphic schema; accepts an untyped value
- chatInfo: polymorphic schema; accepts an untyped value
- incomingContext: polymorphic schema; accepts an untyped value
- mediaConfig: polymorphic schema; accepts an untyped value
- meetingInfo: polymorphic schema; accepts an untyped value
- participants[].info.identity.application: polymorphic schema; accepts an untyped value
- participants[].info.identity.device: polymorphic schema; accepts an untyped value
- participants[].info.identity.user: polymorphic schema; accepts an untyped value
- participants[].recordingInfo: polymorphic schema; accepts an untyped value
- participants[].removedState: polymorphic schema; accepts an untyped value
- participants[].restrictedExperience: polymorphic schema; accepts an untyped value
- requestedModalities[]: polymorphic schema; accepts an untyped value
- source: polymorphic schema; accepts an untyped value
- targets[].identity.application: polymorphic schema; accepts an untyped value
- targets[].identity.device: polymorphic schema; accepts an untyped value
- targets[].identity.user: polymorphic schema; accepts an untyped value
- toneInfo: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
