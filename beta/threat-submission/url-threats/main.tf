# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "adminReview"     = (var.admin_review == null ? null : { for key0, value0 in { "@odata.type" = var.admin_review["odata_type"], "reviewBy" = var.admin_review["reviewBy"], "reviewDateTime" = var.admin_review["reviewDateTime"], "reviewResult" = var.admin_review["reviewResult"] } : key0 => value0 if value0 != null })
    "category"        = var.category
    "clientSource"    = var.client_source
    "contentType"     = var.content_type
    "createdBy"       = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "displayName" = var.created_by["displayName"], "email" = var.created_by["email"], "id" = var.created_by["id"] } : key0 => value0 if value0 != null })
    "createdDateTime" = var.created_date_time
    "source"          = var.graph_source
    "@odata.type"     = var.odata_type
    "result"          = (var.result == null ? null : { for key0, value0 in { "@odata.type" = var.result["odata_type"], "category" = var.result["category"], "detail" = var.result["detail"], "detectedFiles" = (var.result["detectedFiles"] == null ? null : [for item1 in var.result["detectedFiles"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "fileHash" = item1["fileHash"], "fileName" = item1["fileName"] } : key2 => value2 if value2 != null }) if item1 != null]), "detectedUrls" = (var.result["detectedUrls"] == null ? null : [for item1 in var.result["detectedUrls"] : item1 if item1 != null]), "userMailboxSetting" = var.result["userMailboxSetting"] } : key0 => value0 if value0 != null })
    "status"          = var.status
    "tenantId"        = var.tenant_id
    "webUrl"          = var.web_url
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "threatSubmission/urlThreats"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
