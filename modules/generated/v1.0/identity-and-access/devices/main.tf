# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountEnabled"         = var.account_enabled
    "alternativeSecurityIds" = (var.alternative_security_ids == null ? null : [for item0 in var.alternative_security_ids : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "identityProvider" = item0["identityProvider"], "key" = item0["key"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime"        = var.deleted_date_time
    "deviceCategory"         = var.device_category
    "deviceId"               = var.device_id
    "deviceMetadata"         = var.device_metadata
    "deviceOwnership"        = var.device_ownership
    "deviceVersion"          = var.device_version
    "displayName"            = var.display_name
    "enrollmentProfileName"  = var.enrollment_profile_name
    "enrollmentType"         = var.enrollment_type
    "isManaged"              = var.is_managed
    "isRooted"               = var.is_rooted
    "managementType"         = var.management_type
    "@odata.type"            = var.odata_type
    "operatingSystem"        = var.operating_system
    "operatingSystemVersion" = var.operating_system_version
    "physicalIds"            = (var.physical_ids == null ? null : [for item0 in var.physical_ids : item0 if item0 != null])
    "profileType"            = var.profile_type
    "systemLabels"           = (var.system_labels == null ? null : [for item0 in var.system_labels : item0 if item0 != null])
    "transitiveMemberOf"     = (var.transitive_member_of == null ? null : [for item0 in var.transitive_member_of : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "devices"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
