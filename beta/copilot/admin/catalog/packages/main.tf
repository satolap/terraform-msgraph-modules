# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "acquireUsersAndGroups"    = (var.acquire_users_and_groups == null ? null : [for item0 in var.acquire_users_and_groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "resourceId" = item0["resourceId"], "resourceType" = item0["resourceType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "activeUsers"              = var.active_users
    "agentIdentityId"          = var.agent_identity_id
    "allowedUsersAndGroups"    = (var.allowed_users_and_groups == null ? null : [for item0 in var.allowed_users_and_groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "resourceId" = item0["resourceId"], "resourceType" = item0["resourceType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "appId"                    = var.app_id
    "assetId"                  = var.asset_id
    "availableTo"              = var.available_to
    "categories"               = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "createdDateTime"          = var.created_date_time
    "deployedTo"               = var.deployed_to
    "displayName"              = var.display_name
    "elementDetails"           = (var.element_details == null ? null : [for item0 in var.element_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "elementType" = item0["elementType"], "elements" = (item0["elements"] == null ? null : [for item2 in item0["elements"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "definition" = item2["definition"], "id" = item2["id"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "elementTypes"             = (var.element_types == null ? null : [for item0 in var.element_types : item0 if item0 != null])
    "exceptionRate"            = var.exception_rate
    "governanceMetadata"       = var.governance_metadata
    "version"                  = var.graph_version
    "isBlocked"                = var.is_blocked
    "lastModifiedDateTime"     = var.last_modified_date_time
    "lastUsedDateTime"         = var.last_used_date_time
    "longDescription"          = var.long_description
    "manifestId"               = var.manifest_id
    "manifestVersion"          = var.manifest_version
    "@odata.type"              = var.odata_type
    "ownerId"                  = var.owner_id
    "platform"                 = var.platform
    "publisher"                = var.publisher
    "requestStatus"            = var.request_status
    "requestType"              = var.request_type
    "sensitivity"              = var.sensitivity
    "sharedWithUsersAndGroups" = (var.shared_with_users_and_groups == null ? null : [for item0 in var.shared_with_users_and_groups : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "resourceId" = item0["resourceId"], "resourceType" = item0["resourceType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "shortDescription"         = var.short_description
    "supportedHosts"           = (var.supported_hosts == null ? null : [for item0 in var.supported_hosts : item0 if item0 != null])
    "totalRunTimeInHours"      = var.total_run_time_in_hours
    "totalSessions"            = var.total_sessions
    "type"                     = var.type
    "zipFile"                  = var.zip_file
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "copilot/admin/catalog/packages"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
