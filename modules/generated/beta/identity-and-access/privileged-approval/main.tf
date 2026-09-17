# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "approvalDuration" = var.approval_duration
    "approvalState"    = var.approval_state
    "approvalType"     = var.approval_type
    "approverReason"   = var.approver_reason
    "endDateTime"      = var.end_date_time
    "@odata.type"      = var.odata_type
    "request"          = var.request
    "requestorReason"  = var.requestor_reason
    "roleId"           = var.role_id
    "roleInfo"         = var.role_info
    "startDateTime"    = var.start_date_time
    "userId"           = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "privilegedApproval"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
