# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "contentMetadata" = (var.content_metadata == null ? null : { for key0, value0 in { "@odata.type" = var.content_metadata["odata_type"], "activityMetadata" = (var.content_metadata["activityMetadata"] == null ? null : { for key1, value1 in { "@odata.type" = var.content_metadata["activityMetadata"]["odata_type"], "activity" = var.content_metadata["activityMetadata"]["activity"], "participants" = (var.content_metadata["activityMetadata"]["participants"] == null ? null : [for item2 in var.content_metadata["activityMetadata"]["participants"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "value" = item2["value"] } : key3 => value3 if value3 != null }) if item2 != null]) } : key1 => value1 if value1 != null }), "contentEntries" = (var.content_metadata["contentEntries"] == null ? null : [for item1 in var.content_metadata["contentEntries"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "content" = item1["content"], "contentCategory" = item1["contentCategory"], "correlationId" = item1["correlationId"], "createdDateTime" = item1["createdDateTime"], "identifier" = item1["identifier"], "isTruncated" = item1["isTruncated"], "length" = item1["length"], "modifiedDateTime" = item1["modifiedDateTime"], "name" = item1["name"], "sequenceNumber" = item1["sequenceNumber"] } : key2 => value2 if value2 != null }) if item1 != null]), "contextMetadata" = var.content_metadata["contextMetadata"], "deviceMetadata" = (var.content_metadata["deviceMetadata"] == null ? null : { for key1, value1 in { "@odata.type" = var.content_metadata["deviceMetadata"]["odata_type"], "deviceType" = var.content_metadata["deviceMetadata"]["deviceType"], "ipAddress" = var.content_metadata["deviceMetadata"]["ipAddress"], "operatingSystemSpecifications" = var.content_metadata["deviceMetadata"]["operatingSystemSpecifications"] } : key1 => value1 if value1 != null }), "evaluationScope" = var.content_metadata["evaluationScope"], "integratedAppMetadata" = (var.content_metadata["integratedAppMetadata"] == null ? null : { for key1, value1 in { "@odata.type" = var.content_metadata["integratedAppMetadata"]["odata_type"], "name" = var.content_metadata["integratedAppMetadata"]["name"], "version" = var.content_metadata["integratedAppMetadata"]["version"] } : key1 => value1 if value1 != null }), "protectedAppMetadata" = var.content_metadata["protectedAppMetadata"] } : key0 => value0 if value0 != null })
    "@odata.type"     = var.odata_type
    "scopeIdentifier" = var.scope_identifier
    "userId"          = var.user_id_2
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/dataSecurityAndGovernance/activities/contentActivities"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
