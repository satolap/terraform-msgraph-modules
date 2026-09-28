# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "contentMetadata" = (var.content_metadata == null ? null : { for key0, value0 in { "@odata.type" = var.content_metadata["odata_type"], "activityMetadata" = (var.content_metadata["activityMetadata"] == null ? null : { for key1, value1 in { "@odata.type" = var.content_metadata["activityMetadata"]["odata_type"], "activity" = var.content_metadata["activityMetadata"]["activity"] } : key1 => value1 if value1 != null }), "contentEntries" = (var.content_metadata["contentEntries"] == null ? null : [for item1 in var.content_metadata["contentEntries"] : item1 if item1 != null]), "deviceMetadata" = (var.content_metadata["deviceMetadata"] == null ? null : { for key1, value1 in { "@odata.type" = var.content_metadata["deviceMetadata"]["odata_type"], "deviceType" = var.content_metadata["deviceMetadata"]["deviceType"], "ipAddress" = var.content_metadata["deviceMetadata"]["ipAddress"], "operatingSystemSpecifications" = (var.content_metadata["deviceMetadata"]["operatingSystemSpecifications"] == null ? null : { for key2, value2 in { "@odata.type" = var.content_metadata["deviceMetadata"]["operatingSystemSpecifications"]["odata_type"], "operatingSystemPlatform" = var.content_metadata["deviceMetadata"]["operatingSystemSpecifications"]["operatingSystemPlatform"], "operatingSystemVersion" = var.content_metadata["deviceMetadata"]["operatingSystemSpecifications"]["operatingSystemVersion"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }), "integratedAppMetadata" = var.content_metadata["integratedAppMetadata"], "protectedAppMetadata" = (var.content_metadata["protectedAppMetadata"] == null ? null : { for key1, value1 in { "@odata.type" = var.content_metadata["protectedAppMetadata"]["odata_type"], "applicationLocation" = var.content_metadata["protectedAppMetadata"]["applicationLocation"], "name" = var.content_metadata["protectedAppMetadata"]["name"], "version" = var.content_metadata["protectedAppMetadata"]["version"] } : key1 => value1 if value1 != null }) } : key0 => value0 if value0 != null })
    "@odata.type"     = var.odata_type
    "scopeIdentifier" = var.scope_identifier
    "userId"          = var.user_id_2
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/dataSecurityAndGovernance/activities/contentActivities"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
