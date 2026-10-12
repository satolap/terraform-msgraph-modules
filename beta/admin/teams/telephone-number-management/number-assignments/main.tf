# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "activationState"            = var.activation_state
    "assignmentCategory"         = var.assignment_category
    "assignmentStatus"           = var.assignment_status
    "assignmentTargetId"         = var.assignment_target_id
    "capabilities"               = (var.capabilities == null ? null : [for item0 in var.capabilities : item0 if item0 != null])
    "city"                       = var.city
    "civicAddressId"             = var.civic_address_id
    "isoCountryCode"             = var.iso_country_code
    "locationId"                 = var.location_id
    "networkSiteId"              = var.network_site_id
    "numberSource"               = var.number_source
    "numberType"                 = var.number_type
    "@odata.type"                = var.odata_type
    "operatorId"                 = var.operator_id
    "portInStatus"               = var.port_in_status
    "reverseNumberLookupOptions" = (var.reverse_number_lookup_options == null ? null : [for item0 in var.reverse_number_lookup_options : item0 if item0 != null])
    "supportedCustomerActions"   = (var.supported_customer_actions == null ? null : [for item0 in var.supported_customer_actions : item0 if item0 != null])
    "telephoneNumber"            = var.telephone_number
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/teams/telephoneNumberManagement/numberAssignments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
