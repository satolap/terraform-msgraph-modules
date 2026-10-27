# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "address"         = (var.address == null ? null : { for key0, value0 in { "@odata.type" = var.address["odata_type"], "city" = var.address["city"], "countryOrRegion" = var.address["countryOrRegion"], "officeLocation" = var.address["officeLocation"], "postalCode" = var.address["postalCode"], "state" = var.address["state"], "street" = var.address["street"] } : key0 => value0 if value0 != null })
    "companyName"     = var.company_name
    "deletedDateTime" = var.deleted_date_time
    "department"      = var.department
    "displayName"     = var.display_name
    "isDiscoverable"  = var.is_discoverable
    "isEnabled"       = var.is_enabled
    "jobTitle"        = var.job_title
    "@odata.type"     = var.odata_type
    "phoneNumber"     = var.phone_number
    "supervisorId"    = var.supervisor_id
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "directory/pendingExternalUserProfiles"
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
