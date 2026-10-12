# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "endDateTime"          = var.end_date_time
    "version"              = var.graph_version
    "joinWebUrl"           = var.join_web_url
    "lastModifiedDateTime" = var.last_modified_date_time
    "modalities"           = (var.modalities == null ? null : [for item0 in var.modalities : item0 if item0 != null])
    "@odata.type"          = var.odata_type
    "organizer"            = var.organizer
    "organizer_v2"         = var.organizer_v2
    "participants"         = (var.participants == null ? null : [for item0 in var.participants : item0 if item0 != null])
    "participants_v2"      = (var.participants_v2 == null ? null : [for item0 in var.participants_v2 : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "administrativeUnitInfos" = (item0["administrativeUnitInfos"] == null ? null : [for item2 in item0["administrativeUnitInfos"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "id" = item2["id"] } : key3 => value3 if value3 != null }) if item2 != null]), "identity" = (item0["identity"] == null ? null : { for key2, value2 in { "@odata.type" = item0["identity"]["odata_type"], "application" = item0["identity"]["application"], "applicationInstance" = item0["identity"]["applicationInstance"], "assertedIdentity" = item0["identity"]["assertedIdentity"], "azureCommunicationServicesUser" = item0["identity"]["azureCommunicationServicesUser"], "device" = item0["identity"]["device"], "encrypted" = item0["identity"]["encrypted"], "endpointType" = item0["identity"]["endpointType"], "guest" = item0["identity"]["guest"], "onPremises" = item0["identity"]["onPremises"], "phone" = item0["identity"]["phone"], "user" = item0["identity"]["user"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "startDateTime"        = var.start_date_time
    "type"                 = var.type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "communications/callRecords"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
