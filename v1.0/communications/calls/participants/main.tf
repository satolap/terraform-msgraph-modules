# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "info"                 = (var.info == null ? null : { for key0, value0 in { "@odata.type" = var.info["odata_type"], "identity" = var.info["identity"] } : key0 => value0 if value0 != null })
    "isInLobby"            = var.is_in_lobby
    "isMuted"              = var.is_muted
    "mediaStreams"         = (var.media_streams == null ? null : [for item0 in var.media_streams : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "direction" = item0["direction"], "label" = item0["label"], "mediaType" = item0["mediaType"], "serverMuted" = item0["serverMuted"], "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "metadata"             = var.metadata
    "@odata.type"          = var.odata_type
    "recordingInfo"        = (var.recording_info == null ? null : { for key0, value0 in { "@odata.type" = var.recording_info["odata_type"], "initiator" = var.recording_info["initiator"], "recordingStatus" = var.recording_info["recordingStatus"] } : key0 => value0 if value0 != null })
    "removedState"         = (var.removed_state == null ? null : { for key0, value0 in { "@odata.type" = var.removed_state["odata_type"], "reason" = var.removed_state["reason"] } : key0 => value0 if value0 != null })
    "restrictedExperience" = (var.restricted_experience == null ? null : { for key0, value0 in { "@odata.type" = var.restricted_experience["odata_type"], "contentSharingDisabled" = var.restricted_experience["contentSharingDisabled"], "videoDisabled" = var.restricted_experience["videoDisabled"] } : key0 => value0 if value0 != null })
    "rosterSequenceNumber" = var.roster_sequence_number
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/calls/${urlencode(var.call_id)}/participants"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
