mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "77777777-7777-7777-7777-777777777777"
      output = {
        display_name = "Engineering Team Access"
        is_hidden    = false
      }
    }
  }
}

variables {
  catalog_id   = "11111111-1111-1111-1111-111111111111"
  display_name = "Engineering Team Access"
}

run "creates_access_package" {
  command = apply

  assert {
    condition     = msgraph_resource.access_package.url == "identityGovernance/entitlementManagement/accessPackages"
    error_message = "Access package must be created against the accessPackages endpoint."
  }

  assert {
    condition     = msgraph_resource.access_package.body.catalog.id == "11111111-1111-1111-1111-111111111111"
    error_message = "The catalog must be referenced by id in the request body."
  }

  assert {
    condition     = msgraph_resource.access_package.body.isHidden == false
    error_message = "isHidden must default to false."
  }

  assert {
    condition     = output.id == "77777777-7777-7777-7777-777777777777"
    error_message = "id output must expose the access package id."
  }

  assert {
    condition     = output.catalog_id == "11111111-1111-1111-1111-111111111111"
    error_message = "catalog_id output must round-trip the input."
  }
}

run "creates_hidden_access_package" {
  command = apply

  variables {
    is_hidden   = true
    description = "Standard access bundle"
  }

  assert {
    condition     = msgraph_resource.access_package.body.isHidden == true
    error_message = "isHidden must be passed through."
  }

  assert {
    condition     = msgraph_resource.access_package.body.description == "Standard access bundle"
    error_message = "description must be passed through."
  }
}

run "rejects_empty_display_name" {
  command = plan

  variables {
    display_name = ""
  }

  expect_failures = [var.display_name]
}

run "rejects_invalid_api_version" {
  command = plan

  variables {
    api_version = "beta2"
  }

  expect_failures = [var.api_version]
}
