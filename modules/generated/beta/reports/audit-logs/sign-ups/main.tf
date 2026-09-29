# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "appDisplayName"         = var.app_display_name
    "appId"                  = var.app_id
    "appliedEventListeners"  = (var.applied_event_listeners == null ? null : [for item0 in var.applied_event_listeners : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "eventType" = item0["eventType"], "executedListenerId" = item0["executedListenerId"], "handlerResult" = item0["handlerResult"] } : key1 => value1 if value1 != null }) if item0 != null])
    "correlationId"          = var.correlation_id
    "createdDateTime"        = var.created_date_time
    "fraudProtectionDetails" = (var.fraud_protection_details == null ? null : { for key0, value0 in { "@odata.type" = var.fraud_protection_details["odata_type"], "providerErrorMessages" = (var.fraud_protection_details["providerErrorMessages"] == null ? null : [for item1 in var.fraud_protection_details["providerErrorMessages"] : item1 if item1 != null]), "providerHttpStatusCodes" = (var.fraud_protection_details["providerHttpStatusCodes"] == null ? null : [for item1 in var.fraud_protection_details["providerHttpStatusCodes"] : item1 if item1 != null]), "providerName" = var.fraud_protection_details["providerName"], "providerResponseTimes" = (var.fraud_protection_details["providerResponseTimes"] == null ? null : [for item1 in var.fraud_protection_details["providerResponseTimes"] : item1 if item1 != null]), "providerSessionId" = var.fraud_protection_details["providerSessionId"], "reason" = var.fraud_protection_details["reason"], "verdict" = var.fraud_protection_details["verdict"] } : key0 => value0 if value0 != null })
    "@odata.type"            = var.odata_type
    "signUpIdentity"         = (var.sign_up_identity == null ? null : { for key0, value0 in { "@odata.type" = var.sign_up_identity["odata_type"], "signUpIdentifier" = var.sign_up_identity["signUpIdentifier"], "signUpIdentifierType" = var.sign_up_identity["signUpIdentifierType"] } : key0 => value0 if value0 != null })
    "signUpIdentityProvider" = var.sign_up_identity_provider
    "signUpStage"            = var.sign_up_stage
    "status"                 = (var.status == null ? null : { for key0, value0 in { "@odata.type" = var.status["odata_type"], "additionalDetails" = var.status["additionalDetails"], "errorCode" = var.status["errorCode"], "failureReason" = var.status["failureReason"] } : key0 => value0 if value0 != null })
    "userId"                 = var.user_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "auditLogs/signUps"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
