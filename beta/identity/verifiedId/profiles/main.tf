# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "description"                       = var.description
    "faceCheckConfiguration"            = (var.faceCheckConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.faceCheckConfiguration["odata_type"], "isEnabled" = var.faceCheckConfiguration["isEnabled"], "sourcePhotoClaimName" = var.faceCheckConfiguration["sourcePhotoClaimName"] } : key0 => value0 if value0 != null })
    "lastModifiedDateTime"              = var.lastModifiedDateTime
    "mobileDriversLicenseConfiguration" = (var.mobileDriversLicenseConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.mobileDriversLicenseConfiguration["odata_type"], "acceptedRegions" = (var.mobileDriversLicenseConfiguration["acceptedRegions"] == null ? null : [for item1 in var.mobileDriversLicenseConfiguration["acceptedRegions"] : item1 if item1 != null]), "documentStandard" = var.mobileDriversLicenseConfiguration["documentStandard"] } : key0 => value0 if value0 != null })
    "name"                              = var.name
    "@odata.type"                       = var.odata_type
    "priority"                          = var.priority
    "selfServiceIssuance"               = (var.selfServiceIssuance == null ? null : { for key0, value0 in { "@odata.type" = var.selfServiceIssuance["odata_type"], "isEnabled" = var.selfServiceIssuance["isEnabled"], "issuanceUrl" = var.selfServiceIssuance["issuanceUrl"] } : key0 => value0 if value0 != null })
    "state"                             = var.state
    "verifiedIdProfileConfiguration"    = (var.verifiedIdProfileConfiguration == null ? null : { for key0, value0 in { "@odata.type" = var.verifiedIdProfileConfiguration["odata_type"], "acceptedIssuer" = var.verifiedIdProfileConfiguration["acceptedIssuer"], "claimBindingSource" = var.verifiedIdProfileConfiguration["claimBindingSource"], "claimBindings" = (var.verifiedIdProfileConfiguration["claimBindings"] == null ? null : [for item1 in var.verifiedIdProfileConfiguration["claimBindings"] : (item1 == null ? null : { for key2, value2 in { "@odata.type" = item1["odata_type"], "matchConfidenceLevel" = item1["matchConfidenceLevel"], "sourceAttribute" = item1["sourceAttribute"], "verifiedIdClaim" = item1["verifiedIdClaim"] } : key2 => value2 if value2 != null }) if item1 != null]), "claimValidation" = (var.verifiedIdProfileConfiguration["claimValidation"] == null ? null : { for key1, value1 in { "@odata.type" = var.verifiedIdProfileConfiguration["claimValidation"]["odata_type"], "customExtensionId" = var.verifiedIdProfileConfiguration["claimValidation"]["customExtensionId"], "isEnabled" = var.verifiedIdProfileConfiguration["claimValidation"]["isEnabled"] } : key1 => value1 if value1 != null }), "manifestUrl" = var.verifiedIdProfileConfiguration["manifestUrl"], "methodType" = var.verifiedIdProfileConfiguration["methodType"], "type" = var.verifiedIdProfileConfiguration["type"] } : key0 => value0 if value0 != null })
    "verifiedIdUsageConfigurations"     = (var.verifiedIdUsageConfigurations == null ? null : [for item0 in var.verifiedIdUsageConfigurations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "isEnabledForTestOnly" = item0["isEnabledForTestOnly"], "purpose" = item0["purpose"] } : key1 => value1 if value1 != null }) if item0 != null])
    "verifierDid"                       = var.verifierDid
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "identity/verifiedId/profiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
