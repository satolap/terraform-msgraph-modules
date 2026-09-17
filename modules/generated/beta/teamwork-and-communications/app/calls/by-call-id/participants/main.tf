# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "info"                    = (var.info == null ? null : { for key0, value0 in { "@odata.type" = var.info["odata_type"], "identity" = (var.info["identity"] == null ? null : { for key1, value1 in { "@odata.type" = var.info["identity"]["odata_type"], "application" = var.info["identity"]["application"], "device" = var.info["identity"]["device"], "user" = var.info["identity"]["user"] } : key1 => value1 if value1 != null }), "nonAnonymizedIdentity" = var.info["nonAnonymizedIdentity"] } : key0 => value0 if value0 != null })
    "isIdentityAnonymized"    = var.is_identity_anonymized
    "isInLobby"               = var.is_in_lobby
    "isMuted"                 = var.is_muted
    "mediaStreams"            = (var.media_streams == null ? null : [for item0 in var.media_streams : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "direction" = item0["direction"], "label" = item0["label"], "mediaType" = item0["mediaType"], "serverMuted" = item0["serverMuted"], "sourceId" = item0["sourceId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "metadata"                = var.metadata
    "@odata.type"             = var.odata_type
    "preferredDisplayName"    = var.preferred_display_name
    "recordingInfo"           = var.recording_info
    "removedState"            = var.removed_state
    "restrictedExperience"    = var.restricted_experience
    "rosterSequenceNumber"    = var.roster_sequence_number
    "syntheticMediaDetection" = var.synthetic_media_detection
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "app/calls/${urlencode(var.call_id)}/participants"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
