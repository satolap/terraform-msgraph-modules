# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audioRoutingGroups"     = (var.audio_routing_groups == null ? null : [for item0 in var.audio_routing_groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "receivers" = (item0["receivers"] == null ? null : [for item2 in item0["receivers"] : item2 if item2 != null]), "routingMode" = item0["routingMode"], "sources" = (item0["sources"] == null ? null : [for item2 in item0["sources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "callChainId"            = var.call_chain_id
    "callOptions"            = var.call_options
    "callbackUri"            = var.callback_uri
    "chatInfo"               = (var.chat_info == null ? null : { for key0, value0 in { "@odata.type" = var.chat_info["odata_type"], "messageId" = var.chat_info["messageId"], "replyChainMessageId" = var.chat_info["replyChainMessageId"], "threadId" = var.chat_info["threadId"] } : key0 => value0 if value0 != null })
    "contentSharingSessions" = (var.content_sharing_sessions == null ? null : [for item0 in var.content_sharing_sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "source"                 = (var.graph_source == null ? null : { for key0, value0 in { "@odata.type" = var.graph_source["odata_type"], "identity" = var.graph_source["identity"] } : key0 => value0 if value0 != null })
    "incomingContext"        = (var.incoming_context == null ? null : { for key0, value0 in { "@odata.type" = var.incoming_context["odata_type"], "onBehalfOf" = var.incoming_context["onBehalfOf"], "transferor" = var.incoming_context["transferor"] } : key0 => value0 if value0 != null })
    "mediaConfig"            = var.media_config
    "meetingInfo"            = var.meeting_info
    "myParticipantId"        = var.my_participant_id
    "@odata.type"            = var.odata_type
    "operations"             = (var.operations == null ? null : [for item0 in var.operations : item0 if item0 != null])
    "participants"           = (var.participants == null ? null : [for item0 in var.participants : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "info" = (item0["info"] == null ? null : { for key2, value2 in { "@odata.type" = item0["info"]["odata_type"], "identity" = item0["info"]["identity"] } : key2 => value2 if value2 != null }), "isInLobby" = item0["isInLobby"], "isMuted" = item0["isMuted"], "mediaStreams" = (item0["mediaStreams"] == null ? null : [for item2 in item0["mediaStreams"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "direction" = item2["direction"], "label" = item2["label"], "mediaType" = item2["mediaType"], "serverMuted" = item2["serverMuted"], "sourceId" = item2["sourceId"] } : key3 => value3 if value3 != null }) if item2 != null]), "metadata" = item0["metadata"], "recordingInfo" = (item0["recordingInfo"] == null ? null : { for key2, value2 in { "@odata.type" = item0["recordingInfo"]["odata_type"], "initiator" = item0["recordingInfo"]["initiator"], "recordingStatus" = item0["recordingInfo"]["recordingStatus"] } : key2 => value2 if value2 != null }), "removedState" = (item0["removedState"] == null ? null : { for key2, value2 in { "@odata.type" = item0["removedState"]["odata_type"], "reason" = item0["removedState"]["reason"] } : key2 => value2 if value2 != null }), "restrictedExperience" = (item0["restrictedExperience"] == null ? null : { for key2, value2 in { "@odata.type" = item0["restrictedExperience"]["odata_type"], "contentSharingDisabled" = item0["restrictedExperience"]["contentSharingDisabled"], "videoDisabled" = item0["restrictedExperience"]["videoDisabled"] } : key2 => value2 if value2 != null }), "rosterSequenceNumber" = item0["rosterSequenceNumber"] } : key1 => value1 if value1 != null }) if item0 != null])
    "requestedModalities"    = (var.requested_modalities == null ? null : [for item0 in var.requested_modalities : item0 if item0 != null])
    "subject"                = var.subject
    "targets"                = (var.targets == null ? null : [for item0 in var.targets : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "hidden" = item0["hidden"], "identity" = item0["identity"], "participantId" = item0["participantId"], "removeFromDefaultAudioRoutingGroup" = item0["removeFromDefaultAudioRoutingGroup"], "replacesCallId" = item0["replacesCallId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "tenantId"               = var.tenant_id
    "toneInfo"               = (var.tone_info == null ? null : { for key0, value0 in { "@odata.type" = var.tone_info["odata_type"], "sequenceId" = var.tone_info["sequenceId"], "tone" = var.tone_info["tone"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/calls"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
