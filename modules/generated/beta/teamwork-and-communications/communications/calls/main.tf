# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "audioRoutingGroups"      = (var.audio_routing_groups == null ? null : [for item0 in var.audio_routing_groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "receivers" = (item0["receivers"] == null ? null : [for item2 in item0["receivers"] : item2 if item2 != null]), "routingMode" = item0["routingMode"], "sources" = (item0["sources"] == null ? null : [for item2 in item0["sources"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "callChainId"             = var.call_chain_id
    "callOptions"             = var.call_options
    "callbackUri"             = var.callback_uri
    "chatInfo"                = var.chat_info
    "contentSharingSessions"  = (var.content_sharing_sessions == null ? null : [for item0 in var.content_sharing_sessions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "pngOfCurrentSlide" = item0["pngOfCurrentSlide"], "presenterParticipantId" = item0["presenterParticipantId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "source"                  = var.graph_source
    "mediaConfig"             = var.media_config
    "meetingInfo"             = var.meeting_info
    "myParticipantId"         = var.my_participant_id
    "@odata.type"             = var.odata_type
    "operations"              = (var.operations == null ? null : [for item0 in var.operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "clientContext" = item0["clientContext"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "participants"            = (var.participants == null ? null : [for item0 in var.participants : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "info" = (item0["info"] == null ? null : { for key2, value2 in { "@odata.type" = item0["info"]["odata_type"], "identity" = (item0["info"]["identity"] == null ? null : { for key3, value3 in { "@odata.type" = item0["info"]["identity"]["odata_type"], "application" = item0["info"]["identity"]["application"], "device" = item0["info"]["identity"]["device"], "user" = item0["info"]["identity"]["user"] } : key3 => value3 if value3 != null }), "nonAnonymizedIdentity" = item0["info"]["nonAnonymizedIdentity"] } : key2 => value2 if value2 != null }), "isIdentityAnonymized" = item0["isIdentityAnonymized"], "isInLobby" = item0["isInLobby"], "isMuted" = item0["isMuted"], "mediaStreams" = (item0["mediaStreams"] == null ? null : [for item2 in item0["mediaStreams"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "direction" = item2["direction"], "label" = item2["label"], "mediaType" = item2["mediaType"], "serverMuted" = item2["serverMuted"], "sourceId" = item2["sourceId"] } : key3 => value3 if value3 != null }) if item2 != null]), "metadata" = item0["metadata"], "preferredDisplayName" = item0["preferredDisplayName"], "recordingInfo" = item0["recordingInfo"], "removedState" = item0["removedState"], "restrictedExperience" = item0["restrictedExperience"], "rosterSequenceNumber" = item0["rosterSequenceNumber"], "syntheticMediaDetection" = item0["syntheticMediaDetection"] } : key1 => value1 if value1 != null }) if item0 != null])
    "requestedModalities"     = (var.requested_modalities == null ? null : [for item0 in var.requested_modalities : item0 if item0 != null])
    "ringingTimeoutInSeconds" = var.ringing_timeout_in_seconds
    "routingPolicies"         = (var.routing_policies == null ? null : [for item0 in var.routing_policies : item0 if item0 != null])
    "subject"                 = var.subject
    "targets"                 = (var.targets == null ? null : [for item0 in var.targets : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "endpointType" = item0["endpointType"], "hidden" = item0["hidden"], "identity" = (item0["identity"] == null ? null : { for key2, value2 in { "@odata.type" = item0["identity"]["odata_type"], "application" = item0["identity"]["application"], "device" = item0["identity"]["device"], "user" = item0["identity"]["user"] } : key2 => value2 if value2 != null }), "participantId" = item0["participantId"], "removeFromDefaultAudioRoutingGroup" = item0["removeFromDefaultAudioRoutingGroup"], "replacesCallId" = item0["replacesCallId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "terminationReason"       = var.termination_reason
    "toneInfo"                = var.tone_info
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/calls"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
