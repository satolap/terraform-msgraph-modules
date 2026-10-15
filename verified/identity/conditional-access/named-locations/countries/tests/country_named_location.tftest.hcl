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

run "rejects_beta_api_version" {
  command = plan

  variables {
    api_version = "beta"
  }

  expect_failures = [var.api_version]
}

run "timeouts_default_to_the_previous_behaviour" {
  command = plan

  assert {
    condition     = jsonencode(msgraph_resource.named_location.timeouts) == jsonencode({ create = "10m", delete = "10m", read = null, update = "10m" })
    error_message = "With default inputs the create, update and delete timeouts must stay 10m and read must stay unset, so an upgrade plans no timeout change."
  }
}

run "plans_custom_timeouts" {
  command = plan

  variables {
    timeouts = { create = "30m", read = "5m", update = "20m", delete = "25m" }
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.timeouts) == jsonencode({ create = "30m", delete = "25m", read = "5m", update = "20m" })
    error_message = "Each configured timeout must be planned as given."
  }
}

# A wrapper that forwards an unset variable passes null; the module must plan the
# defaults, as it does when timeouts is unset.
run "null_timeouts_plan_the_defaults" {
  command = plan

  variables {
    timeouts = null
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.timeouts) == jsonencode({ create = "10m", delete = "10m", read = null, update = "10m" })
    error_message = "A null timeouts must plan the create, update and delete defaults of 10m and leave read unset."
  }
}

run "rejects_malformed_timeout" {
  command = plan

  variables {
    timeouts = { update = "10 minutes" }
  }

  expect_failures = [var.timeouts]
}

# The provider accepts a zero duration; the module does not. read has no minimum,
# so only the zero rule rejects it.
run "rejects_zero_timeout" {
  command = plan

  variables {
    timeouts = { read = "0s" }
  }

  expect_failures = [var.timeouts]
}

# The provider waits at least 10 seconds for three consistent reads after a write.
run "rejects_short_timeout" {
  command = plan

  variables {
    timeouts = { update = "14s" }
  }

  expect_failures = [var.timeouts]
}

# The minimum itself is accepted.
run "accepts_15_second_timeouts" {
  command = plan

  variables {
    timeouts = { create = "15s", update = "15s", delete = "15s" }
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.timeouts) == jsonencode({ create = "15s", delete = "15s", read = null, update = "15s" })
    error_message = "15s is the documented minimum for create, update and delete and must be accepted."
  }
}
