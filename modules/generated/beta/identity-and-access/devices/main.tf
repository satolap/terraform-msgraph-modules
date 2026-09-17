# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountEnabled"         = var.account_enabled
    "alternativeNames"       = (var.alternative_names == null ? null : [for item0 in var.alternative_names : item0 if item0 != null])
    "alternativeSecurityIds" = (var.alternative_security_ids == null ? null : [for item0 in var.alternative_security_ids : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "identityProvider" = item0["identityProvider"], "key" = item0["key"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "commands"               = (var.commands == null ? null : [for item0 in var.commands : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appServiceName" = item0["appServiceName"], "error" = item0["error"], "packageFamilyName" = item0["packageFamilyName"], "payload" = item0["payload"], "permissionTicket" = item0["permissionTicket"], "postBackUri" = item0["postBackUri"], "responsepayload" = item0["responsepayload"], "status" = item0["status"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime"        = var.deleted_date_time
    "deviceCategory"         = var.device_category
    "deviceId"               = var.device_id
    "deviceMetadata"         = var.device_metadata
    "deviceOwnership"        = var.device_ownership
    "deviceVersion"          = var.device_version
    "displayName"            = var.display_name
    "domainName"             = var.domain_name
    "enrollmentProfileName"  = var.enrollment_profile_name
    "enrollmentType"         = var.enrollment_type
    "extensionAttributes"    = var.extension_attributes
    "hostnames"              = (var.hostnames == null ? null : [for item0 in var.hostnames : item0 if item0 != null])
    "isManaged"              = var.is_managed
    "isRooted"               = var.is_rooted
    "kind"                   = var.kind
    "managementType"         = var.management_type
    "name"                   = var.name
    "@odata.type"            = var.odata_type
    "operatingSystem"        = var.operating_system
    "operatingSystemVersion" = var.operating_system_version
    "physicalIds"            = (var.physical_ids == null ? null : [for item0 in var.physical_ids : item0 if item0 != null])
    "platform"               = var.platform
    "profileType"            = var.profile_type
    "status"                 = var.status
    "systemLabels"           = (var.system_labels == null ? null : [for item0 in var.system_labels : item0 if item0 != null])
    "transitiveMemberOf"     = (var.transitive_member_of == null ? null : [for item0 in var.transitive_member_of : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "usageRights"            = (var.usage_rights == null ? null : [for item0 in var.usage_rights : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "catalogId" = item0["catalogId"], "serviceIdentifier" = item0["serviceIdentifier"], "state" = item0["state"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "devices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
