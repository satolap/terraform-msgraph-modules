# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "expirationDateTime" = var.expiration_date_time
    "fingerprint"        = var.fingerprint
    "firstSeenDateTime"  = var.first_seen_date_time
    "issueDateTime"      = var.issue_date_time
    "issuer"             = (var.issuer == null ? null : { for key0, value0 in { "@odata.type" = var.issuer["odata_type"], "address" = (var.issuer["address"] == null ? null : { for key1, value1 in { "@odata.type" = var.issuer["address"]["odata_type"], "city" = var.issuer["address"]["city"], "countryOrRegion" = var.issuer["address"]["countryOrRegion"], "postalCode" = var.issuer["address"]["postalCode"], "state" = var.issuer["address"]["state"], "street" = var.issuer["address"]["street"] } : key1 => value1 if value1 != null }), "alternateNames" = (var.issuer["alternateNames"] == null ? null : [for item1 in var.issuer["alternateNames"] : item1 if item1 != null]), "commonName" = var.issuer["commonName"], "email" = var.issuer["email"], "givenName" = var.issuer["givenName"], "organizationName" = var.issuer["organizationName"], "organizationUnitName" = var.issuer["organizationUnitName"], "serialNumber" = var.issuer["serialNumber"], "surname" = var.issuer["surname"] } : key0 => value0 if value0 != null })
    "lastSeenDateTime"   = var.last_seen_date_time
    "@odata.type"        = var.odata_type
    "relatedHosts"       = (var.related_hosts == null ? null : [for item0 in var.related_hosts : item0 if item0 != null])
    "serialNumber"       = var.serial_number
    "sha1"               = var.sha1
    "subject"            = (var.subject == null ? null : { for key0, value0 in { "@odata.type" = var.subject["odata_type"], "address" = (var.subject["address"] == null ? null : { for key1, value1 in { "@odata.type" = var.subject["address"]["odata_type"], "city" = var.subject["address"]["city"], "countryOrRegion" = var.subject["address"]["countryOrRegion"], "postalCode" = var.subject["address"]["postalCode"], "state" = var.subject["address"]["state"], "street" = var.subject["address"]["street"] } : key1 => value1 if value1 != null }), "alternateNames" = (var.subject["alternateNames"] == null ? null : [for item1 in var.subject["alternateNames"] : item1 if item1 != null]), "commonName" = var.subject["commonName"], "email" = var.subject["email"], "givenName" = var.subject["givenName"], "organizationName" = var.subject["organizationName"], "organizationUnitName" = var.subject["organizationUnitName"], "serialNumber" = var.subject["serialNumber"], "surname" = var.subject["surname"] } : key0 => value0 if value0 != null })
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/threatIntelligence/sslCertificates"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
