# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "accountEnabled"         = var.accountEnabled
    "alternativeNames"       = (var.alternativeNames == null ? null : [for item0 in var.alternativeNames : item0 if item0 != null])
    "alternativeSecurityIds" = (var.alternativeSecurityIds == null ? null : [for item0 in var.alternativeSecurityIds : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "identityProvider" = item0["identityProvider"], "key" = item0["key"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "cloudLicensing"         = (var.cloudLicensing == null ? null : { for key0, value0 in { "@odata.type" = var.cloudLicensing["odata_type"], "assignments" = (var.cloudLicensing["assignments"] == null ? null : [for item1 in var.cloudLicensing["assignments"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "allotment" = item1["allotment"], "assignedTo" = item1["assignedTo"], "disabledServicePlanIds" = (item1["disabledServicePlanIds"] == null ? null : [for item3 in item1["disabledServicePlanIds"] : item3 if item3 != null]) } : key2 => value2 if value2 != null }) if item1 != null]), "usageRights" = (var.cloudLicensing["usageRights"] == null ? null : [for item1 in var.cloudLicensing["usageRights"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "allotments" = (item1["allotments"] == null ? null : [for item3 in item1["allotments"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "assignableTo" = item3["assignableTo"], "assignments" = item3["assignments"], "externalServiceIdentifier" = item3["externalServiceIdentifier"], "subscriptions" = item3["subscriptions"], "waitingMembers" = item3["waitingMembers"] } : key4 => value4 if value4 != null }) if item3 != null]), "assignments" = (item1["assignments"] == null ? null : [for item3 in item1["assignments"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "allotment" = item3["allotment"], "assignedTo" = item3["assignedTo"], "disabledServicePlanIds" = item3["disabledServicePlanIds"] } : key4 => value4 if value4 != null }) if item3 != null]), "externalServiceIdentifier" = item1["externalServiceIdentifier"] } : key2 => value2 if value2 != null }) if item1 != null]), "waitingMembers" = (var.cloudLicensing["waitingMembers"] == null ? null : [for item1 in var.cloudLicensing["waitingMembers"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "allotment" = (item1["allotment"] == null ? null : { for key3, value3 in { "@odata.type" = item1["allotment"]["odata_type"], "assignableTo" = item1["allotment"]["assignableTo"], "assignments" = (item1["allotment"]["assignments"] == null ? null : [for item4 in item1["allotment"]["assignments"] : item4 if item4 != null]), "externalServiceIdentifier" = item1["allotment"]["externalServiceIdentifier"], "subscriptions" = (item1["allotment"]["subscriptions"] == null ? null : [for item4 in item1["allotment"]["subscriptions"] : item4 if item4 != null]), "waitingMembers" = (item1["allotment"]["waitingMembers"] == null ? null : [for item4 in item1["allotment"]["waitingMembers"] : item4 if item4 != null]) } : key3 => value3 if value3 != null }), "assignedTo" = item1["assignedTo"], "waitingSinceDateTime" = item1["waitingSinceDateTime"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "commands"               = (var.commands == null ? null : [for item0 in var.commands : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "appServiceName" = item0["appServiceName"], "error" = item0["error"], "packageFamilyName" = item0["packageFamilyName"], "payload" = item0["payload"], "permissionTicket" = item0["permissionTicket"], "postBackUri" = item0["postBackUri"], "responsepayload" = item0["responsepayload"], "status" = item0["status"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime"        = var.deletedDateTime
    "deviceCategory"         = var.deviceCategory
    "deviceId"               = var.deviceId
    "deviceMetadata"         = var.deviceMetadata
    "deviceOwnership"        = var.deviceOwnership
    "deviceVersion"          = var.deviceVersion
    "displayName"            = var.displayName
    "domainName"             = var.domainName
    "enrollmentProfileName"  = var.enrollmentProfileName
    "enrollmentType"         = var.enrollmentType
    "extensionAttributes"    = (var.extensionAttributes == null ? null : { for key0, value0 in { "@odata.type" = var.extensionAttributes["odata_type"], "extensionAttribute1" = var.extensionAttributes["extensionAttribute1"], "extensionAttribute10" = var.extensionAttributes["extensionAttribute10"], "extensionAttribute11" = var.extensionAttributes["extensionAttribute11"], "extensionAttribute12" = var.extensionAttributes["extensionAttribute12"], "extensionAttribute13" = var.extensionAttributes["extensionAttribute13"], "extensionAttribute14" = var.extensionAttributes["extensionAttribute14"], "extensionAttribute15" = var.extensionAttributes["extensionAttribute15"], "extensionAttribute2" = var.extensionAttributes["extensionAttribute2"], "extensionAttribute3" = var.extensionAttributes["extensionAttribute3"], "extensionAttribute4" = var.extensionAttributes["extensionAttribute4"], "extensionAttribute5" = var.extensionAttributes["extensionAttribute5"], "extensionAttribute6" = var.extensionAttributes["extensionAttribute6"], "extensionAttribute7" = var.extensionAttributes["extensionAttribute7"], "extensionAttribute8" = var.extensionAttributes["extensionAttribute8"], "extensionAttribute9" = var.extensionAttributes["extensionAttribute9"] } : key0 => value0 if value0 != null })
    "hostnames"              = (var.hostnames == null ? null : [for item0 in var.hostnames : item0 if item0 != null])
    "isManaged"              = var.isManaged
    "isRooted"               = var.isRooted
    "kind"                   = var.kind
    "managementType"         = var.managementType
    "name"                   = var.name
    "@odata.type"            = var.odata_type
    "operatingSystem"        = var.operatingSystem
    "operatingSystemVersion" = var.operatingSystemVersion
    "physicalIds"            = (var.physicalIds == null ? null : [for item0 in var.physicalIds : item0 if item0 != null])
    "platform"               = var.platform
    "profileType"            = var.profileType
    "status"                 = var.status
    "systemLabels"           = (var.systemLabels == null ? null : [for item0 in var.systemLabels : item0 if item0 != null])
    "transitiveMemberOf"     = (var.transitiveMemberOf == null ? null : [for item0 in var.transitiveMemberOf : item0 if item0 != null])
    "usageRights"            = (var.usageRights == null ? null : [for item0 in var.usageRights : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "catalogId" = item0["catalogId"], "serviceIdentifier" = item0["serviceIdentifier"], "state" = item0["state"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "devices"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["commands", "transitiveMemberOf", "usageRights"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
