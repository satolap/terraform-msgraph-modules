# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "actionRequiredByDateTime" = var.action_required_by_date_time
    "attachments"              = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "contentType" = item0["contentType"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "name" = item0["name"], "size" = item0["size"] } : key1 => value1 if value1 != null }) if item0 != null])
    "attachmentsArchive"       = var.attachments_archive
    "body"                     = (var.body == null ? null : { for key0, value0 in { "@odata.type" = var.body["odata_type"], "content" = var.body["content"], "contentType" = var.body["contentType"] } : key0 => value0 if value0 != null })
    "category"                 = var.category
    "details"                  = (var.details == null ? null : [for item0 in var.details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "value" = item0["value"] } : key1 => value1 if value1 != null }) if item0 != null])
    "endDateTime"              = var.end_date_time
    "hasAttachments"           = var.has_attachments
    "isMajorChange"            = var.is_major_change
    "lastModifiedDateTime"     = var.last_modified_date_time
    "@odata.type"              = var.odata_type
    "services"                 = (var.services == null ? null : [for item0 in var.services : item0 if item0 != null])
    "severity"                 = var.severity
    "startDateTime"            = var.start_date_time
    "tags"                     = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "title"                    = var.title
    "viewPoint"                = var.view_point
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/serviceAnnouncement/messages"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
