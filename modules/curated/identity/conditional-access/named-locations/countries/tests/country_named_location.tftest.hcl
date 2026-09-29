mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "55555555-5555-5555-5555-555555555555"
      output = {
        display_name                          = "Blocked regions"
        countries_and_regions                 = ["IN", "CA"]
        include_unknown_countries_and_regions = false
        country_lookup_method                 = "clientIpAddress"
      }
    }
  }
}

variables {
  display_name          = "Blocked regions"
  countries_and_regions = ["IN", "CA"]
}

run "creates_country_location_with_defaults" {
  command = apply

  assert {
    condition     = msgraph_resource.named_location.url == "identity/conditionalAccess/namedLocations" && msgraph_resource.named_location.api_version == "v1.0"
    error_message = "Named locations must be created at identity/conditionalAccess/namedLocations on v1.0."
  }

  assert {
    condition     = msgraph_resource.named_location.ignore_missing_property == false
    error_message = "ignore_missing_property must be false so that server-side nulling shows as drift."
  }

  assert {
    condition = jsonencode(msgraph_resource.named_location.body) == jsonencode({
      "@odata.type"                     = "#microsoft.graph.countryNamedLocation"
      displayName                       = "Blocked regions"
      countriesAndRegions               = ["CA", "IN"]
      includeUnknownCountriesAndRegions = false
      countryLookupMethod               = "clientIpAddress"
    })
    error_message = "The body must carry the derived @odata.type, sorted codes and both defaults."
  }

  assert {
    condition     = terraform_data.country_lookup_method.output == "clientIpAddress"
    error_message = "The replacement trigger must hold the lookup method."
  }

  assert {
    condition     = output.id == "55555555-5555-5555-5555-555555555555" && jsonencode(output.countries_and_regions) == jsonencode(["CA", "IN"])
    error_message = "id and the sorted read-back codes must be exposed."
  }

  assert {
    condition     = output.include_unknown_countries_and_regions == false && output.country_lookup_method == "clientIpAddress"
    error_message = "The read-back flags must be exposed."
  }
}

run "updates_codes_and_unknown_flag_in_place" {
  command = apply

  variables {
    display_name                          = "Blocked regions renamed"
    countries_and_regions                 = ["IN", "FR", "CA"]
    include_unknown_countries_and_regions = true
  }

  # A new object would take this id; an in-place update keeps the old one.
  override_resource {
    target = msgraph_resource.named_location
    values = {
      id = "55555555-5555-5555-5555-000000000001"
      output = {
        display_name                          = "Blocked regions renamed"
        countries_and_regions                 = ["CA", "FR", "IN"]
        include_unknown_countries_and_regions = true
        country_lookup_method                 = "clientIpAddress"
      }
    }
  }

  assert {
    condition     = output.id == "55555555-5555-5555-5555-555555555555"
    error_message = "A change that the update API supports must update the location in place and keep its id."
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.body.countriesAndRegions) == jsonencode(["CA", "FR", "IN"]) && msgraph_resource.named_location.body.includeUnknownCountriesAndRegions == true
    error_message = "The update body must carry the sorted codes and the new flag."
  }

  assert {
    condition     = terraform_data.country_lookup_method.output == "clientIpAddress"
    error_message = "A change that the update API supports must not touch the replacement trigger."
  }
}

run "lookup_method_change_moves_the_replacement_trigger" {
  command = apply

  variables {
    country_lookup_method = "authenticatorAppGps"
  }

  override_resource {
    target = msgraph_resource.named_location
    values = {
      id = "55555555-5555-5555-5555-000000000002"
      output = {
        display_name                          = "Blocked regions"
        countries_and_regions                 = ["CA", "IN"]
        include_unknown_countries_and_regions = false
        country_lookup_method                 = "authenticatorAppGps"
      }
    }
  }

  assert {
    condition     = output.id == "55555555-5555-5555-5555-000000000002" && output.country_lookup_method == "authenticatorAppGps"
    error_message = "A lookup method change must replace the location, so the new object's id and method are used."
  }

  assert {
    condition     = terraform_data.country_lookup_method.output == "authenticatorAppGps" && msgraph_resource.named_location.body.countryLookupMethod == "authenticatorAppGps"
    error_message = "A lookup method change must change the replacement trigger, which replaces the location."
  }
}

run "rejects_empty_codes" {
  command = plan

  variables {
    countries_and_regions = []
  }

  expect_failures = [var.countries_and_regions]
}

run "rejects_lower_case_code" {
  command = plan

  variables {
    countries_and_regions = ["ca"]
  }

  expect_failures = [var.countries_and_regions]
}

run "rejects_three_letter_code" {
  command = plan

  variables {
    countries_and_regions = ["CAN"]
  }

  expect_failures = [var.countries_and_regions]
}

run "rejects_unknown_lookup_method" {
  command = plan

  variables {
    country_lookup_method = "gps"
  }

  expect_failures = [var.country_lookup_method]
}

run "rejects_empty_display_name" {
  command = plan

  variables {
    display_name = ""
  }

  expect_failures = [var.display_name]
}

run "rejects_unknown_api_version" {
  command = plan

  variables {
    api_version = "v2.0"
  }

  expect_failures = [var.api_version]
}
