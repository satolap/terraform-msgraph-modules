# /communications/callRecords/{callRecord-id}/sessions/{session-id}/segments

Create new navigation property to segments for communications

[Catalog](../../../../../../../README.md) · [Teamwork and communications](../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /communications/callRecords/{callRecord-id}/sessions/{session-id}/segments`, `GET/PATCH/DELETE /communications/callRecords/{callRecord-id}/sessions/{session-id}/segments/{segment-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./teamwork-and-communications/communications/call-records/by-call-record-id/sessions/by-session-id/segments"
  call_record_id = "parent-object-id"
  session_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `call_record_id` | URL parameter `callRecord-id` | `string` | yes | no |
| `session_id` | URL parameter `session-id` | `string` | yes | no |
| `callee` | `callee` | `any` | no | no |
| `caller` | `caller` | `any` | no | no |
| `end_date_time` | `endDateTime` | `string` | no | no |
| `failure_info` | `failureInfo` | `any` | no | no |
| `media` | `media` | `list(object({       odata_type = optional(string, "#microsoft.graph.callRecords.media")       calleeDevice = optional(any)       calleeNetwork = optional(any)       callerDevice = optional(any)       callerNetwork = optional(any)       label = optional(string)       streams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.callRecords.mediaStream")       audioCodec = optional(any)       averageAudioDegradation = optional(any)       averageAudioNetworkJitter = optional(string)       averageBandwidthEstimate = optional(number)       averageFreezeDuration = optional(string)       averageJitter = optional(string)       averagePacketLossRate = optional(any)       averageRatioOfConcealedSamples = optional(any)       averageReceivedFrameRate = optional(any)       averageRoundTripTime = optional(string)       averageVideoFrameLossPercentage = optional(any)       averageVideoFrameRate = optional(any)       averageVideoPacketLossRate = optional(any)       endDateTime = optional(string)       isAudioForwardErrorCorrectionUsed = optional(bool)       lowFrameRateRatio = optional(any)       lowVideoProcessingCapabilityRatio = optional(any)       maxAudioNetworkJitter = optional(string)       maxJitter = optional(string)       maxPacketLossRate = optional(any)       maxRatioOfConcealedSamples = optional(any)       maxRoundTripTime = optional(string)       packetUtilization = optional(number)       postForwardErrorCorrectionPacketLossRate = optional(any)       rmsFreezeDuration = optional(string)       startDateTime = optional(string)       streamDirection = optional(string)       streamId = optional(string)       videoCodec = optional(any)       wasMediaBypassed = optional(bool)     })))     }))` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `start_date_time` | `startDateTime` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- callee: polymorphic schema; accepts an untyped value
- caller: polymorphic schema; accepts an untyped value
- failureInfo: polymorphic schema; accepts an untyped value
- media[].calleeDevice: polymorphic schema; accepts an untyped value
- media[].calleeNetwork: polymorphic schema; accepts an untyped value
- media[].callerDevice: polymorphic schema; accepts an untyped value
- media[].callerNetwork: polymorphic schema; accepts an untyped value
- media[].streams[].audioCodec: polymorphic schema; accepts an untyped value
- media[].streams[].averageAudioDegradation: polymorphic schema; accepts an untyped value
- media[].streams[].averagePacketLossRate: polymorphic schema; accepts an untyped value
- media[].streams[].averageRatioOfConcealedSamples: polymorphic schema; accepts an untyped value
- media[].streams[].averageReceivedFrameRate: polymorphic schema; accepts an untyped value
- media[].streams[].averageVideoFrameLossPercentage: polymorphic schema; accepts an untyped value
- media[].streams[].averageVideoFrameRate: polymorphic schema; accepts an untyped value
- media[].streams[].averageVideoPacketLossRate: polymorphic schema; accepts an untyped value
- media[].streams[].lowFrameRateRatio: polymorphic schema; accepts an untyped value
- media[].streams[].lowVideoProcessingCapabilityRatio: polymorphic schema; accepts an untyped value
- media[].streams[].maxPacketLossRate: polymorphic schema; accepts an untyped value
- media[].streams[].maxRatioOfConcealedSamples: polymorphic schema; accepts an untyped value
- media[].streams[].postForwardErrorCorrectionPacketLossRate: polymorphic schema; accepts an untyped value
- media[].streams[].videoCodec: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
