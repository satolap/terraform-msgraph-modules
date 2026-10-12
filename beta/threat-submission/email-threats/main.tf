# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "@odata.type"                  = var.odata_type
    "adminReview"                  = (var.admin_review == null ? null : { for key0, value0 in { "@odata.type" = var.admin_review["odata_type"], "reviewBy" = var.admin_review["reviewBy"], "reviewDateTime" = var.admin_review["reviewDateTime"], "reviewResult" = var.admin_review["reviewResult"] } : key0 => value0 if value0 != null })
    "attackSimulationInfo"         = (var.attack_simulation_info == null ? null : { for key0, value0 in { "@odata.type" = var.attack_simulation_info["odata_type"], "attackSimDateTime" = var.attack_simulation_info["attackSimDateTime"], "attackSimDurationTime" = var.attack_simulation_info["attackSimDurationTime"], "attackSimId" = var.attack_simulation_info["attackSimId"], "attackSimUserId" = var.attack_simulation_info["attackSimUserId"] } : key0 => value0 if value0 != null })
    "category"                     = var.category
    "clientSource"                 = var.client_source
    "contentType"                  = var.content_type
    "createdBy"                    = (var.created_by == null ? null : { for key0, value0 in { "@odata.type" = var.created_by["odata_type"], "displayName" = var.created_by["displayName"], "email" = var.created_by["email"], "id" = var.created_by["id"] } : key0 => value0 if value0 != null })
    "createdDateTime"              = var.created_date_time
    "source"                       = var.graph_source
    "internetMessageId"            = var.internet_message_id
    "originalCategory"             = var.original_category
    "receivedDateTime"             = var.received_date_time
    "recipientEmailAddress"        = var.recipient_email_address
    "result"                       = (var.result == null ? null : { for key0, value0 in { "@odata.type" = var.result["odata_type"], "category" = var.result["category"], "detail" = var.result["detail"], "detectedFiles" = (var.result["detectedFiles"] == null ? null : [for item1 in var.result["detectedFiles"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "fileHash" = item1["fileHash"], "fileName" = item1["fileName"] } : key2 => value2 if value2 != null }) if item1 != null]), "detectedUrls" = (var.result["detectedUrls"] == null ? null : [for item1 in var.result["detectedUrls"] : item1 if item1 != null]), "userMailboxSetting" = var.result["userMailboxSetting"] } : key0 => value0 if value0 != null })
    "sender"                       = var.sender
    "senderIP"                     = var.sender_ip
    "status"                       = var.status
    "subject"                      = var.subject
    "tenantAllowOrBlockListAction" = (var.tenant_allow_or_block_list_action == null ? null : { for key0, value0 in { "@odata.type" = var.tenant_allow_or_block_list_action["odata_type"], "action" = var.tenant_allow_or_block_list_action["action"], "expirationDateTime" = var.tenant_allow_or_block_list_action["expirationDateTime"], "note" = var.tenant_allow_or_block_list_action["note"], "results" = (var.tenant_allow_or_block_list_action["results"] == null ? null : [for item1 in var.tenant_allow_or_block_list_action["results"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "entryType" = item1["entryType"], "expirationDateTime" = item1["expirationDateTime"], "identity" = item1["identity"], "status" = item1["status"], "value" = item1["value"] } : key2 => value2 if value2 != null }) if item1 != null]) } : key0 => value0 if value0 != null })
    "tenantId"                     = var.tenant_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "threatSubmission/emailThreats"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
