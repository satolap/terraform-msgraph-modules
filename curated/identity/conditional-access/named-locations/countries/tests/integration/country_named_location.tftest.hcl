# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) that carry Policy.Read.All and
# Policy.ReadWrite.ConditionalAccess. Delegated access needs both scopes in the
# token plus the Conditional Access Administrator or Security Administrator
# role. No policy references the location. Destroy is implicit.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_location" {
  command = apply

  variables {
    display_name          = "tftest-ca-country-${run.setup.suffix}"
    countries_and_regions = ["CA", "IN"]
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID id for the created location."
  }

  assert {
    condition     = jsonencode(output.countries_and_regions) == jsonencode(["CA", "IN"]) && output.include_unknown_countries_and_regions == false && output.country_lookup_method == "clientIpAddress"
    error_message = "The create read-back must carry the codes and both defaults."
  }
}

run "verify_created" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    named_location_id = run.create_location.id
    run_label         = "created"
  }

  assert {
    condition = jsonencode(output.configuration) == jsonencode({
      odata_type                            = "#microsoft.graph.countryNamedLocation"
      display_name                          = "tftest-ca-country-${run.setup.suffix}"
      countries_and_regions                 = ["CA", "IN"]
      include_unknown_countries_and_regions = false
      country_lookup_method                 = "clientIpAddress"
    })
    error_message = "A fresh GET must return every managed property as configured."
  }
}

run "refresh_created" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name          = "tftest-ca-country-${run.setup.suffix}"
    countries_and_regions = ["CA", "IN"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.body) == jsonencode(local.body)
    error_message = "After a refresh the body differs from the configuration, so the next plan would not be empty."
  }
}

# PATCH: rename, add a code, include unknown countries and regions.
run "update_location" {
  command = apply

  variables {
    display_name                          = "tftest-ca-country-${run.setup.suffix}-updated"
    countries_and_regions                 = ["CA", "FR", "IN"]
    include_unknown_countries_and_regions = true
  }

  assert {
    condition     = output.id == run.create_location.id
    error_message = "A value change must update the location in place."
  }
}

run "verify_updated" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    named_location_id = run.update_location.id
    run_label         = "updated"
  }

  assert {
    condition = jsonencode(output.configuration) == jsonencode({
      odata_type                            = "#microsoft.graph.countryNamedLocation"
      display_name                          = "tftest-ca-country-${run.setup.suffix}-updated"
      countries_and_regions                 = ["CA", "FR", "IN"]
      include_unknown_countries_and_regions = true
      country_lookup_method                 = "clientIpAddress"
    })
    error_message = "A fresh GET must return the updated name, codes and flag."
  }
}

run "refresh_updated" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name                          = "tftest-ca-country-${run.setup.suffix}-updated"
    countries_and_regions                 = ["CA", "FR", "IN"]
    include_unknown_countries_and_regions = true
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.body) == jsonencode(local.body)
    error_message = "After a refresh the body differs from the configuration, so the next plan would not be empty."
  }
}

# The update API does not list countryLookupMethod, so a change replaces the
# location (create before destroy). No policy uses it, so the GPS lookup
# prompts nobody. Unknown countries and regions are left out: Learn describes
# them only for IP addresses that map to no country, and shows no GPS example.
run "replace_on_lookup_method_change" {
  command = apply

  variables {
    display_name          = "tftest-ca-country-${run.setup.suffix}-updated"
    countries_and_regions = ["CA", "FR", "IN"]
    country_lookup_method = "authenticatorAppGps"
  }

  assert {
    condition     = output.id != run.update_location.id
    error_message = "A lookup method change must replace the location."
  }
}

run "verify_replaced" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    named_location_id = run.replace_on_lookup_method_change.id
    run_label         = "replaced"
  }

  assert {
    condition     = output.configuration.country_lookup_method == "authenticatorAppGps" && jsonencode(output.configuration.countries_and_regions) == jsonencode(["CA", "FR", "IN"]) && output.configuration.include_unknown_countries_and_regions == false
    error_message = "A fresh GET of the replacement must return the new lookup method, the codes and no unknown countries and regions."
  }
}
