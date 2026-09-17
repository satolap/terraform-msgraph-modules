# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"                    = var.description
    "faceCheckConfiguration"         = (var.face_check_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.face_check_configuration["odata_type"], "isEnabled" = var.face_check_configuration["isEnabled"], "sourcePhotoClaimName" = var.face_check_configuration["sourcePhotoClaimName"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"           = var.last_modified_date_time
    "name"                           = var.name
    "@odata.type"                    = var.odata_type
    "priority"                       = var.priority
    "state"                          = var.state
    "verifiedIdProfileConfiguration" = (var.verified_id_profile_configuration == null ? null : { for key0, value0 in { "@odata.type" = var.verified_id_profile_configuration["odata_type"], "acceptedIssuer" = var.verified_id_profile_configuration["acceptedIssuer"], "claimBindingSource" = var.verified_id_profile_configuration["claimBindingSource"], "claimBindings" = (var.verified_id_profile_configuration["claimBindings"] == null ? null : [for item1 in var.verified_id_profile_configuration["claimBindings"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "matchConfidenceLevel" = item1["matchConfidenceLevel"], "sourceAttribute" = item1["sourceAttribute"], "verifiedIdClaim" = item1["verifiedIdClaim"] } : key2 => value2 if value2 != null }) if item1 != null]), "claimValidation" = (var.verified_id_profile_configuration["claimValidation"] == null ? null : { for key1, value1 in { "@odata.type" = var.verified_id_profile_configuration["claimValidation"]["odata_type"], "customExtensionId" = var.verified_id_profile_configuration["claimValidation"]["customExtensionId"], "isEnabled" = var.verified_id_profile_configuration["claimValidation"]["isEnabled"] } : key1 => value1 if value1 != null }), "type" = var.verified_id_profile_configuration["type"] } : key0 => value0 if value0 != null })
    "verifiedIdUsageConfigurations"  = (var.verified_id_usage_configurations == null ? null : [for item0 in var.verified_id_usage_configurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isEnabledForTestOnly" = item0["isEnabledForTestOnly"], "purpose" = item0["purpose"] } : key1 => value1 if value1 != null }) if item0 != null])
    "verifierDid"                    = var.verifier_did
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "identity/verifiedId/profiles"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
