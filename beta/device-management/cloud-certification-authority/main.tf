# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificateKeySize"                          = var.certificate_key_size
    "certificationAuthorityStatus"                = var.certification_authority_status
    "cloudCertificationAuthorityHashingAlgorithm" = var.cloud_certification_authority_hashing_algorithm
    "cloudCertificationAuthorityLeafCertificate"  = (var.cloud_certification_authority_leaf_certificate == null ? null : [for item0 in var.cloud_certification_authority_leaf_certificate : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certificateStatus" = item0["certificateStatus"] } : key1 => value1 if value1 != null }) if item0 != null])
    "cloudCertificationAuthorityType"             = var.cloud_certification_authority_type
    "description"                                 = var.description
    "displayName"                                 = var.display_name
    "eTag"                                        = var.e_tag
    "issuerCommonName"                            = var.issuer_common_name
    "keyPlatform"                                 = var.key_platform
    "lastModifiedDateTime"                        = var.last_modified_date_time
    "@odata.type"                                 = var.odata_type
    "roleScopeTagIds"                             = (var.role_scope_tag_ids == null ? null : [for item0 in var.role_scope_tag_ids : item0 if item0 != null])
    "validityPeriodInYears"                       = var.validity_period_in_years
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/cloudCertificationAuthority"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
