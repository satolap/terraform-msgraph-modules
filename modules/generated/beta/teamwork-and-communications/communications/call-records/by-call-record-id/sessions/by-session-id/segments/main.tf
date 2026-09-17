# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "callee"        = var.callee
    "caller"        = var.caller
    "endDateTime"   = var.end_date_time
    "failureInfo"   = var.failure_info
    "media"         = (var.media == null ? null : [for item0 in var.media : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "calleeDevice" = item0["calleeDevice"], "calleeNetwork" = item0["calleeNetwork"], "callerDevice" = item0["callerDevice"], "callerNetwork" = item0["callerNetwork"], "label" = item0["label"], "streams" = (item0["streams"] == null ? null : [for item2 in item0["streams"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "audioCodec" = item2["audioCodec"], "averageAudioDegradation" = item2["averageAudioDegradation"], "averageAudioNetworkJitter" = item2["averageAudioNetworkJitter"], "averageBandwidthEstimate" = item2["averageBandwidthEstimate"], "averageFreezeDuration" = item2["averageFreezeDuration"], "averageJitter" = item2["averageJitter"], "averagePacketLossRate" = item2["averagePacketLossRate"], "averageRatioOfConcealedSamples" = item2["averageRatioOfConcealedSamples"], "averageReceivedFrameRate" = item2["averageReceivedFrameRate"], "averageRoundTripTime" = item2["averageRoundTripTime"], "averageVideoFrameLossPercentage" = item2["averageVideoFrameLossPercentage"], "averageVideoFrameRate" = item2["averageVideoFrameRate"], "averageVideoPacketLossRate" = item2["averageVideoPacketLossRate"], "endDateTime" = item2["endDateTime"], "isAudioForwardErrorCorrectionUsed" = item2["isAudioForwardErrorCorrectionUsed"], "lowFrameRateRatio" = item2["lowFrameRateRatio"], "lowVideoProcessingCapabilityRatio" = item2["lowVideoProcessingCapabilityRatio"], "maxAudioNetworkJitter" = item2["maxAudioNetworkJitter"], "maxJitter" = item2["maxJitter"], "maxPacketLossRate" = item2["maxPacketLossRate"], "maxRatioOfConcealedSamples" = item2["maxRatioOfConcealedSamples"], "maxRoundTripTime" = item2["maxRoundTripTime"], "packetUtilization" = item2["packetUtilization"], "postForwardErrorCorrectionPacketLossRate" = item2["postForwardErrorCorrectionPacketLossRate"], "rmsFreezeDuration" = item2["rmsFreezeDuration"], "startDateTime" = item2["startDateTime"], "streamDirection" = item2["streamDirection"], "streamId" = item2["streamId"], "videoCodec" = item2["videoCodec"], "wasMediaBypassed" = item2["wasMediaBypassed"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type"   = var.odata_type
    "startDateTime" = var.start_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/callRecords/${urlencode(var.call_record_id)}/sessions/${urlencode(var.session_id)}/segments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
