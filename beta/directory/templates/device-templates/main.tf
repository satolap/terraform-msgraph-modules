# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime"                     = var.deleted_date_time
    "deviceAuthority"                     = var.device_authority
    "deviceInstances"                     = (var.device_instances == null ? null : [for item0 in var.device_instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accountEnabled" = item0["accountEnabled"], "alternativeNames" = (item0["alternativeNames"] == null ? null : [for item2 in item0["alternativeNames"] : item2 if item2 != null]), "alternativeSecurityIds" = (item0["alternativeSecurityIds"] == null ? null : [for item2 in item0["alternativeSecurityIds"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "identityProvider" = item2["identityProvider"], "key" = item2["key"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "cloudLicensing" = (item0["cloudLicensing"] == null ? null : { for key2, value2 in { "@odata.type" = item0["cloudLicensing"]["odata_type"], "assignments" = (item0["cloudLicensing"]["assignments"] == null ? null : [for item3 in item0["cloudLicensing"]["assignments"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "allotment" = item3["allotment"], "assignedTo" = item3["assignedTo"], "disabledServicePlanIds" = item3["disabledServicePlanIds"] } : key4 => value4 if value4 != null }) if item3 != null]), "usageRights" = (item0["cloudLicensing"]["usageRights"] == null ? null : [for item3 in item0["cloudLicensing"]["usageRights"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "allotments" = item3["allotments"], "assignments" = item3["assignments"], "externalServiceIdentifier" = item3["externalServiceIdentifier"] } : key4 => value4 if value4 != null }) if item3 != null]), "waitingMembers" = (item0["cloudLicensing"]["waitingMembers"] == null ? null : [for item3 in item0["cloudLicensing"]["waitingMembers"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "allotment" = item3["allotment"], "assignedTo" = item3["assignedTo"], "waitingSinceDateTime" = item3["waitingSinceDateTime"] } : key4 => value4 if value4 != null }) if item3 != null]) } : key2 => value2 if value2 != null }), "commands" = (item0["commands"] == null ? null : [for item2 in item0["commands"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "appServiceName" = item2["appServiceName"], "error" = item2["error"], "packageFamilyName" = item2["packageFamilyName"], "payload" = item2["payload"], "permissionTicket" = item2["permissionTicket"], "postBackUri" = item2["postBackUri"], "responsepayload" = item2["responsepayload"], "status" = item2["status"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "deviceCategory" = item0["deviceCategory"], "deviceId" = item0["deviceId"], "deviceMetadata" = item0["deviceMetadata"], "deviceOwnership" = item0["deviceOwnership"], "deviceVersion" = item0["deviceVersion"], "displayName" = item0["displayName"], "domainName" = item0["domainName"], "enrollmentProfileName" = item0["enrollmentProfileName"], "enrollmentType" = item0["enrollmentType"], "extensionAttributes" = (item0["extensionAttributes"] == null ? null : { for key2, value2 in { "@odata.type" = item0["extensionAttributes"]["odata_type"], "extensionAttribute1" = item0["extensionAttributes"]["extensionAttribute1"], "extensionAttribute10" = item0["extensionAttributes"]["extensionAttribute10"], "extensionAttribute11" = item0["extensionAttributes"]["extensionAttribute11"], "extensionAttribute12" = item0["extensionAttributes"]["extensionAttribute12"], "extensionAttribute13" = item0["extensionAttributes"]["extensionAttribute13"], "extensionAttribute14" = item0["extensionAttributes"]["extensionAttribute14"], "extensionAttribute15" = item0["extensionAttributes"]["extensionAttribute15"], "extensionAttribute2" = item0["extensionAttributes"]["extensionAttribute2"], "extensionAttribute3" = item0["extensionAttributes"]["extensionAttribute3"], "extensionAttribute4" = item0["extensionAttributes"]["extensionAttribute4"], "extensionAttribute5" = item0["extensionAttributes"]["extensionAttribute5"], "extensionAttribute6" = item0["extensionAttributes"]["extensionAttribute6"], "extensionAttribute7" = item0["extensionAttributes"]["extensionAttribute7"], "extensionAttribute8" = item0["extensionAttributes"]["extensionAttribute8"], "extensionAttribute9" = item0["extensionAttributes"]["extensionAttribute9"] } : key2 => value2 if value2 != null }), "hostnames" = (item0["hostnames"] == null ? null : [for item2 in item0["hostnames"] : item2 if item2 != null]), "isManaged" = item0["isManaged"], "isRooted" = item0["isRooted"], "kind" = item0["kind"], "managementType" = item0["managementType"], "name" = item0["name"], "operatingSystem" = item0["operatingSystem"], "operatingSystemVersion" = item0["operatingSystemVersion"], "physicalIds" = (item0["physicalIds"] == null ? null : [for item2 in item0["physicalIds"] : item2 if item2 != null]), "platform" = item0["platform"], "profileType" = item0["profileType"], "status" = item0["status"], "systemLabels" = (item0["systemLabels"] == null ? null : [for item2 in item0["systemLabels"] : item2 if item2 != null]), "transitiveMemberOf" = (item0["transitiveMemberOf"] == null ? null : [for item2 in item0["transitiveMemberOf"] : item2 if item2 != null]), "usageRights" = (item0["usageRights"] == null ? null : [for item2 in item0["usageRights"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "catalogId" = item2["catalogId"], "serviceIdentifier" = item2["serviceIdentifier"], "state" = item2["state"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "manufacturer"                        = var.manufacturer
    "model"                               = var.model
    "mutualTlsOauthConfigurationId"       = var.mutual_tls_oauth_configuration_id
    "mutualTlsOauthConfigurationTenantId" = var.mutual_tls_oauth_configuration_tenant_id
    "@odata.type"                         = var.odata_type
    "operatingSystem"                     = var.operating_system
    "owners"                              = (var.owners == null ? null : [for item0 in var.owners : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "directory/templates/deviceTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["deviceInstances", "owners"], name)])]))))] } : null

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
