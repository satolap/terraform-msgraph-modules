# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "certificateAuthorities" = (var.certificate_authorities == null ? null : [for item0 in var.certificate_authorities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "certificate" = item0["certificate"], "certificateAuthorityType" = item0["certificateAuthorityType"], "certificateRevocationListUrl" = item0["certificateRevocationListUrl"], "createdDateTime" = item0["createdDateTime"], "deletedDateTime" = item0["deletedDateTime"], "deltaCertificateRevocationListUrl" = item0["deltaCertificateRevocationListUrl"], "displayName" = item0["displayName"], "expirationDateTime" = item0["expirationDateTime"], "isIssuerHintEnabled" = item0["isIssuerHintEnabled"], "issuer" = item0["issuer"], "issuerSubjectKeyIdentifier" = item0["issuerSubjectKeyIdentifier"], "thumbprint" = item0["thumbprint"] } : key1 => value1 if value1 != null }) if item0 != null])
    "deletedDateTime"        = var.deleted_date_time
    "displayName"            = var.display_name
    "lastModifiedDateTime"   = var.last_modified_date_time
    "@odata.type"            = var.odata_type
    "status"                 = var.status
    "statusDetails"          = var.status_details
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "directory/publicKeyInfrastructure/certificateBasedAuthConfigurations"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
