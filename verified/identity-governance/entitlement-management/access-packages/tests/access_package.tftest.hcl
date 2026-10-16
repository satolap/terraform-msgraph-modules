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

# The runs below share one state in file order: the first run creates the
# access package, later runs update or replace it. A replacement takes the id
# of the override_resource block; an in-place update keeps the id in the state.

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

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ catalog_id = "11111111-1111-1111-1111-111111111111" })
    error_message = "The replace trigger must hold the catalog id, the value an update cannot change."
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

# Used only if the access package were replaced: an in-place update keeps the
# id in the state.
run "changing_updatable_properties_updates_in_place" {
  command = apply

  variables {
    display_name = "Engineering Team Access (renamed)"
    description  = "Renamed bundle"
    is_hidden    = false
  }

  override_resource {
    target = msgraph_resource.access_package
    values = {
      id = "77777777-7777-7777-7777-000000000002"
      output = {
        display_name = "Engineering Team Access (renamed)"
        is_hidden    = false
      }
    }
  }

  assert {
    condition     = output.id == "77777777-7777-7777-7777-777777777777"
    error_message = "displayName, description and isHidden are updatable, so changing them must update the access package in place and keep its id."
  }

  assert {
    condition     = msgraph_resource.access_package.body.displayName == "Engineering Team Access (renamed)" && msgraph_resource.access_package.body.catalog.id == "11111111-1111-1111-1111-111111111111"
    error_message = "The update must carry the new name and keep the catalog unchanged."
  }
}

run "changing_the_catalog_replaces_the_access_package" {
  command = apply

  variables {
    catalog_id   = "44444444-4444-4444-4444-444444444444"
    display_name = "Engineering Team Access (renamed)"
    description  = "Renamed bundle"
  }

  override_resource {
    target = msgraph_resource.access_package
    values = {
      id = "77777777-7777-7777-7777-000000000003"
      output = {
        display_name = "Engineering Team Access (renamed)"
        is_hidden    = false
      }
    }
  }

  assert {
    condition     = output.id == "77777777-7777-7777-7777-000000000003"
    error_message = "A new catalog must replace the access package, because the catalog is read-only after creation."
  }

  assert {
    condition     = msgraph_resource.access_package.body.catalog.id == "44444444-4444-4444-4444-444444444444" && output.catalog_id == "44444444-4444-4444-4444-444444444444"
    error_message = "The replacement must be created in the new catalog."
  }

  assert {
    condition     = jsonencode(terraform_data.immutable.input) == jsonencode({ catalog_id = "44444444-4444-4444-4444-444444444444" })
    error_message = "The replace trigger must follow the catalog id."
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
