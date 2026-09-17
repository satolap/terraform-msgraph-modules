# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "deletedDateTime"                     = var.deleted_date_time
    "deviceAuthority"                     = var.device_authority
    "deviceInstances"                     = (var.device_instances == null ? null : [for item0 in var.device_instances : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "accountEnabled" = item0["accountEnabled"], "alternativeNames" = (item0["alternativeNames"] == null ? null : [for item2 in item0["alternativeNames"] : item2 if item2 != null]), "alternativeSecurityIds" = (item0["alternativeSecurityIds"] == null ? null : [for item2 in item0["alternativeSecurityIds"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "identityProvider" = item2["identityProvider"], "key" = item2["key"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "commands" = (item0["commands"] == null ? null : [for item2 in item0["commands"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "appServiceName" = item2["appServiceName"], "error" = item2["error"], "packageFamilyName" = item2["packageFamilyName"], "payload" = item2["payload"], "permissionTicket" = item2["permissionTicket"], "postBackUri" = item2["postBackUri"], "responsepayload" = item2["responsepayload"], "status" = item2["status"], "type" = item2["type"] } : key3 => value3 if value3 != null }) if item2 != null]), "deletedDateTime" = item0["deletedDateTime"], "deviceCategory" = item0["deviceCategory"], "deviceId" = item0["deviceId"], "deviceMetadata" = item0["deviceMetadata"], "deviceOwnership" = item0["deviceOwnership"], "deviceVersion" = item0["deviceVersion"], "displayName" = item0["displayName"], "domainName" = item0["domainName"], "enrollmentProfileName" = item0["enrollmentProfileName"], "enrollmentType" = item0["enrollmentType"], "extensionAttributes" = item0["extensionAttributes"], "hostnames" = (item0["hostnames"] == null ? null : [for item2 in item0["hostnames"] : item2 if item2 != null]), "isManaged" = item0["isManaged"], "isRooted" = item0["isRooted"], "kind" = item0["kind"], "managementType" = item0["managementType"], "name" = item0["name"], "operatingSystem" = item0["operatingSystem"], "operatingSystemVersion" = item0["operatingSystemVersion"], "physicalIds" = (item0["physicalIds"] == null ? null : [for item2 in item0["physicalIds"] : item2 if item2 != null]), "platform" = item0["platform"], "profileType" = item0["profileType"], "status" = item0["status"], "systemLabels" = (item0["systemLabels"] == null ? null : [for item2 in item0["systemLabels"] : item2 if item2 != null]), "transitiveMemberOf" = (item0["transitiveMemberOf"] == null ? null : [for item2 in item0["transitiveMemberOf"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "deletedDateTime" = item2["deletedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "usageRights" = (item0["usageRights"] == null ? null : [for item2 in item0["usageRights"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "catalogId" = item2["catalogId"], "serviceIdentifier" = item2["serviceIdentifier"], "state" = item2["state"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "manufacturer"                        = var.manufacturer
    "model"                               = var.model
    "mutualTlsOauthConfigurationId"       = var.mutual_tls_oauth_configuration_id
    "mutualTlsOauthConfigurationTenantId" = var.mutual_tls_oauth_configuration_tenant_id
    "@odata.type"                         = var.odata_type
    "operatingSystem"                     = var.operating_system
    "owners"                              = (var.owners == null ? null : [for item0 in var.owners : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "deletedDateTime" = item0["deletedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/templates/deviceTemplates"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
