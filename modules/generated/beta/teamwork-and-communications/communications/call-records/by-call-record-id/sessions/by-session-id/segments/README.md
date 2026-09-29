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
| `failure_info` | `failureInfo` | `object({       odata_type = optional(string, "#microsoft.graph.callRecords.failureInfo")       reason = optional(string)       stage = optional(string)     })` | no | no |
| `media` | `media` | `list(object({       odata_type = optional(string, "#microsoft.graph.callRecords.media")       calleeDevice = optional(object({       odata_type = optional(string, "#microsoft.graph.callRecords.deviceInfo")       captureDeviceDriver = optional(string)       captureDeviceName = optional(string)       captureNotFunctioningEventRatio = optional(any)       cpuInsufficentEventRatio = optional(any)       deviceClippingEventRatio = optional(any)       deviceGlitchEventRatio = optional(any)       howlingEventCount = optional(number)       initialSignalLevelRootMeanSquare = optional(any)       lowSpeechLevelEventRatio = optional(any)       lowSpeechToNoiseEventRatio = optional(any)       micGlitchRate = optional(any)       receivedNoiseLevel = optional(number)       receivedSignalLevel = optional(number)       renderDeviceDriver = optional(string)       renderDeviceName = optional(string)       renderMuteEventRatio = optional(any)       renderNotFunctioningEventRatio = optional(any)       renderZeroVolumeEventRatio = optional(any)       sentNoiseLevel = optional(number)       sentSignalLevel = optional(number)       speakerGlitchRate = optional(any)     }))       calleeNetwork = optional(object({       odata_type = optional(string, "#microsoft.graph.callRecords.networkInfo")       bandwidthLowEventRatio = optional(any)       basicServiceSetIdentifier = optional(string)       connectionType = optional(string)       delayEventRatio = optional(any)       dnsSuffix = optional(string)       ipAddress = optional(string)       linkSpeed = optional(number)       macAddress = optional(string)       networkTransportProtocol = optional(string)       port = optional(number)       receivedQualityEventRatio = optional(any)       reflexiveIPAddress = optional(string)       relayIPAddress = optional(string)       relayPort = optional(number)       sentQualityEventRatio = optional(any)       subnet = optional(string)       traceRouteHops = optional(list(object({       odata_type = optional(string, "#microsoft.graph.callRecords.traceRouteHop")       hopCount = optional(number)       ipAddress = optional(string)       roundTripTime = optional(string)     })))       wifiBand = optional(string)       wifiBatteryCharge = optional(number)       wifiChannel = optional(number)       wifiMicrosoftDriver = optional(string)       wifiMicrosoftDriverVersion = optional(string)       wifiRadioType = optional(string)       wifiSignalStrength = optional(number)       wifiVendorDriver = optional(string)       wifiVendorDriverVersion = optional(string)     }))       callerDevice = optional(object({       odata_type = optional(string, "#microsoft.graph.callRecords.deviceInfo")       captureDeviceDriver = optional(string)       captureDeviceName = optional(string)       captureNotFunctioningEventRatio = optional(any)       cpuInsufficentEventRatio = optional(any)       deviceClippingEventRatio = optional(any)       deviceGlitchEventRatio = optional(any)       howlingEventCount = optional(number)       initialSignalLevelRootMeanSquare = optional(any)       lowSpeechLevelEventRatio = optional(any)       lowSpeechToNoiseEventRatio = optional(any)       micGlitchRate = optional(any)       receivedNoiseLevel = optional(number)       receivedSignalLevel = optional(number)       renderDeviceDriver = optional(string)       renderDeviceName = optional(string)       renderMuteEventRatio = optional(any)       renderNotFunctioningEventRatio = optional(any)       renderZeroVolumeEventRatio = optional(any)       sentNoiseLevel = optional(number)       sentSignalLevel = optional(number)       speakerGlitchRate = optional(any)     }))       callerNetwork = optional(object({       odata_type = optional(string, "#microsoft.graph.callRecords.networkInfo")       bandwidthLowEventRatio = optional(any)       basicServiceSetIdentifier = optional(string)       connectionType = optional(string)       delayEventRatio = optional(any)       dnsSuffix = optional(string)       ipAddress = optional(string)       linkSpeed = optional(number)       macAddress = optional(string)       networkTransportProtocol = optional(string)       port = optional(number)       receivedQualityEventRatio = optional(any)       reflexiveIPAddress = optional(string)       relayIPAddress = optional(string)       relayPort = optional(number)       sentQualityEventRatio = optional(any)       subnet = optional(string)       traceRouteHops = optional(list(object({       odata_type = optional(string, "#microsoft.graph.callRecords.traceRouteHop")       hopCount = optional(number)       ipAddress = optional(string)       roundTripTime = optional(string)     })))       wifiBand = optional(string)       wifiBatteryCharge = optional(number)       wifiChannel = optional(number)       wifiMicrosoftDriver = optional(string)       wifiMicrosoftDriverVersion = optional(string)       wifiRadioType = optional(string)       wifiSignalStrength = optional(number)       wifiVendorDriver = optional(string)       wifiVendorDriverVersion = optional(string)     }))       label = optional(string)       streams = optional(list(object({       odata_type = optional(string, "#microsoft.graph.callRecords.mediaStream")       audioCodec = optional(string)       averageAudioDegradation = optional(any)       averageAudioNetworkJitter = optional(string)       averageBandwidthEstimate = optional(number)       averageFreezeDuration = optional(string)       averageJitter = optional(string)       averagePacketLossRate = optional(any)       averageRatioOfConcealedSamples = optional(any)       averageReceivedFrameRate = optional(any)       averageRoundTripTime = optional(string)       averageVideoFrameLossPercentage = optional(any)       averageVideoFrameRate = optional(any)       averageVideoPacketLossRate = optional(any)       endDateTime = optional(string)       isAudioForwardErrorCorrectionUsed = optional(bool)       lowFrameRateRatio = optional(any)       lowVideoProcessingCapabilityRatio = optional(any)       maxAudioNetworkJitter = optional(string)       maxJitter = optional(string)       maxPacketLossRate = optional(any)       maxRatioOfConcealedSamples = optional(any)       maxRoundTripTime = optional(string)       packetUtilization = optional(number)       postForwardErrorCorrectionPacketLossRate = optional(any)       rmsFreezeDuration = optional(string)       startDateTime = optional(string)       streamDirection = optional(string)       streamId = optional(string)       videoCodec = optional(string)       wasMediaBypassed = optional(bool)     })))     }))` | no | no |
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
- media[].calleeDevice.captureNotFunctioningEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.cpuInsufficentEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.deviceClippingEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.deviceGlitchEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.initialSignalLevelRootMeanSquare: polymorphic schema; accepts an untyped value
- media[].calleeDevice.lowSpeechLevelEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.lowSpeechToNoiseEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.micGlitchRate: polymorphic schema; accepts an untyped value
- media[].calleeDevice.renderMuteEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.renderNotFunctioningEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.renderZeroVolumeEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeDevice.speakerGlitchRate: polymorphic schema; accepts an untyped value
- media[].calleeNetwork.bandwidthLowEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeNetwork.delayEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeNetwork.receivedQualityEventRatio: polymorphic schema; accepts an untyped value
- media[].calleeNetwork.sentQualityEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.captureNotFunctioningEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.cpuInsufficentEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.deviceClippingEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.deviceGlitchEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.initialSignalLevelRootMeanSquare: polymorphic schema; accepts an untyped value
- media[].callerDevice.lowSpeechLevelEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.lowSpeechToNoiseEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.micGlitchRate: polymorphic schema; accepts an untyped value
- media[].callerDevice.renderMuteEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.renderNotFunctioningEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.renderZeroVolumeEventRatio: polymorphic schema; accepts an untyped value
- media[].callerDevice.speakerGlitchRate: polymorphic schema; accepts an untyped value
- media[].callerNetwork.bandwidthLowEventRatio: polymorphic schema; accepts an untyped value
- media[].callerNetwork.delayEventRatio: polymorphic schema; accepts an untyped value
- media[].callerNetwork.receivedQualityEventRatio: polymorphic schema; accepts an untyped value
- media[].callerNetwork.sentQualityEventRatio: polymorphic schema; accepts an untyped value
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

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
