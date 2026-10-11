# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountEnabled"         = var.account_enabled
    "alternativeNames"       = (var.alternative_names == null ? null : [for item0 in var.alternative_names : item0 if item0 != null])
    "alternativeSecurityIds" = (var.alternative_security_ids == null ? null : [for item0 in var.alternative_security_ids : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "identityProvider" = item0["identityProvider"], "key" = item0["key"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "cloudLicensing"         = (var.cloud_licensing == null ? null : { for key0, value0 in { "@odata.type" = var.cloud_licensing["odata_type"], "assignments" = (var.cloud_licensing["assignments"] == null ? null : [for item1 in var.cloud_licensing["assignments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "allotment" = item1["allotment"], "assignedTo" = item1["assignedTo"], "disabledServicePlanIds" = (item1["disabledServicePlanIds"] == null ? null : [for item3 in item1["disabledServicePlanIds"] : item3 if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]), "usageRights" = (var.cloud_licensing["usageRights"] == null ? null : [for item1 in var.cloud_licensing["usageRights"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "allotments" = (item1["allotments"] == null ? null : [for item3 in item1["allotments"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "assignableTo" = item3["assignableTo"], "assignments" = item3["assignments"], "externalServiceIdentifier" = item3["externalServiceIdentifier"], "subscriptions" = item3["subscriptions"], "waitingMembers" = item3["waitingMembers"] } : key4 => value4 if value4 != null }) if item3 != null]), "assignments" = (item1["assignments"] == null ? null : [for item3 in item1["assignments"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "allotment" = item3["allotment"], "assignedTo" = item3["assignedTo"], "disabledServicePlanIds" = item3["disabledServicePlanIds"] } : key4 => value4 if value4 != null }) if item3 != null]), "externalServiceIdentifier" = item1["externalServiceIdentifier"] } : key2 => value2 if value2 != null }) if item1 != null]), "waitingMembers" = (var.cloud_licensing["waitingMembers"] == null ? null : [for item1 in var.cloud_licensing["waitingMembers"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "allotment" = (item1["allotment"] == null ? null : { for key3, value3 in { "@odata.type" = item1["allotment"]["odata_type"], "assignableTo" = item1["allotment"]["assignableTo"], "assignments" = (item1["allotment"]["assignments"] == null ? null : [for item4 in item1["allotment"]["assignments"] : item4 if item4 != null]), "externalServiceIdentifier" = item1["allotment"]["externalServiceIdentifier"], "subscriptions" = (item1["allotment"]["subscriptions"] == null ? null : [for item4 in item1["allotment"]["subscriptions"] : item4 if item4 != null]), "waitingMembers" = (item1["allotment"]["waitingMembers"] == null ? null : [for item4 in item1["allotment"]["waitingMembers"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "assignedTo" = item1["assignedTo"], "waitingSinceDateTime" = item1["waitingSinceDateTime"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
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
    "extensionAttributes"    = (var.extension_attributes == null ? null : { for key0, value0 in { "@odata.type" = var.extension_attributes["odata_type"], "extensionAttribute1" = var.extension_attributes["extensionAttribute1"], "extensionAttribute10" = var.extension_attributes["extensionAttribute10"], "extensionAttribute11" = var.extension_attributes["extensionAttribute11"], "extensionAttribute12" = var.extension_attributes["extensionAttribute12"], "extensionAttribute13" = var.extension_attributes["extensionAttribute13"], "extensionAttribute14" = var.extension_attributes["extensionAttribute14"], "extensionAttribute15" = var.extension_attributes["extensionAttribute15"], "extensionAttribute2" = var.extension_attributes["extensionAttribute2"], "extensionAttribute3" = var.extension_attributes["extensionAttribute3"], "extensionAttribute4" = var.extension_attributes["extensionAttribute4"], "extensionAttribute5" = var.extension_attributes["extensionAttribute5"], "extensionAttribute6" = var.extension_attributes["extensionAttribute6"], "extensionAttribute7" = var.extension_attributes["extensionAttribute7"], "extensionAttribute8" = var.extension_attributes["extensionAttribute8"], "extensionAttribute9" = var.extension_attributes["extensionAttribute9"] } : key0 => value0 if value0 != null })
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
    "transitiveMemberOf"     = (var.transitive_member_of == null ? null : [for item0 in var.transitive_member_of : item0 if item0 != null])
    "usageRights"            = (var.usage_rights == null ? null : [for item0 in var.usage_rights : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "catalogId" = item0["catalogId"], "serviceIdentifier" = item0["serviceIdentifier"], "state" = item0["state"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/devices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
