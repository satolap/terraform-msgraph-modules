# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "info"                    = (var.info == null ? null : { for key0, value0 in { "@odata.type" = var.info["odata_type"], "identity" = var.info["identity"], "nonAnonymizedIdentity" = var.info["nonAnonymizedIdentity"] } : key0 => value0 if value0 != null })
    "isIdentityAnonymized"    = var.is_identity_anonymized
    "isInLobby"               = var.is_in_lobby
    "isMuted"                 = var.is_muted
    "mediaStreams"            = (var.media_streams == null ? null : [for item0 in var.media_streams : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "direction" = item0["direction"], "label" = item0["label"], "mediaType" = item0["mediaType"], "serverMuted" = item0["serverMuted"], "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "metadata"                = var.metadata
    "@odata.type"             = var.odata_type
    "preferredDisplayName"    = var.preferred_display_name
    "recordingInfo"           = (var.recording_info == null ? null : { for key0, value0 in { "@odata.type" = var.recording_info["odata_type"], "initiatedBy" = (var.recording_info["initiatedBy"] == null ? null : { for key1, value1 in { "@odata.type" = var.recording_info["initiatedBy"]["odata_type"], "identity" = var.recording_info["initiatedBy"]["identity"], "nonAnonymizedIdentity" = var.recording_info["initiatedBy"]["nonAnonymizedIdentity"] } : key1 => value1 if value1 != null }), "initiator" = var.recording_info["initiator"], "recordingStatus" = var.recording_info["recordingStatus"] } : key0 => value0 if value0 != null })
    "removedState"            = (var.removed_state == null ? null : { for key0, value0 in { "@odata.type" = var.removed_state["odata_type"], "reason" = var.removed_state["reason"] } : key0 => value0 if value0 != null })
    "restrictedExperience"    = (var.restricted_experience == null ? null : { for key0, value0 in { "@odata.type" = var.restricted_experience["odata_type"], "contentSharingDisabled" = var.restricted_experience["contentSharingDisabled"], "videoDisabled" = var.restricted_experience["videoDisabled"] } : key0 => value0 if value0 != null })
    "rosterSequenceNumber"    = var.roster_sequence_number
    "syntheticMediaDetection" = (var.synthetic_media_detection == null ? null : { for key0, value0 in { "@odata.type" = var.synthetic_media_detection["odata_type"], "detectionId" = var.synthetic_media_detection["detectionId"], "detectorBot" = var.synthetic_media_detection["detectorBot"], "isParticipantTrusted" = var.synthetic_media_detection["isParticipantTrusted"], "syntheticConfidence" = var.synthetic_media_detection["syntheticConfidence"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/calls/${urlencode(var.call_id)}/participants"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
