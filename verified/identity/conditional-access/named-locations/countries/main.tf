locals {
  # The derived @odata.type is required on create and on every update. Codes
  # are sorted so that caller order never causes an update.
  body = {
    "@odata.type"                     = "#microsoft.graph.countryNamedLocation"
    displayName                       = var.display_name
    countriesAndRegions               = sort(var.countries_and_regions)
    includeUnknownCountriesAndRegions = var.include_unknown_countries_and_regions
    countryLookupMethod               = var.country_lookup_method
  }
}

# Update countryNamedLocation lists only countriesAndRegions, displayName and
# includeUnknownCountriesAndRegions, so a lookup method change replaces the
# location. The replacement is created first, so a policy that references this
# location's id is updated to the new id before the old location is deleted.
resource "terraform_data" "country_lookup_method" {
  input = var.country_lookup_method
}

resource "msgraph_resource" "named_location" {
  url                     = "identity/conditionalAccess/namedLocations"
  api_version             = var.api_version
  body                    = local.body
  ignore_missing_property = false

  response_export_values = {
    display_name                          = "displayName"
    countries_and_regions                 = "countriesAndRegions"
    include_unknown_countries_and_regions = "includeUnknownCountriesAndRegions"
    country_lookup_method                 = "countryLookupMethod"
  }

  timeouts {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [terraform_data.country_lookup_method]
  }
}
