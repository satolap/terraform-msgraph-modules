mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "11111111-1111-1111-1111-111111111111"
      output = {
        display_name = "Engineering"
        state        = "published"
        catalog_type = "userManaged"
      }
    }
  }
}

variables {
  display_name = "Engineering"
}

run "creates_catalog_with_defaults" {
  command = apply

  assert {
    condition     = msgraph_resource.catalog.url == "identityGovernance/entitlementManagement/catalogs"
    error_message = "Catalog must be created against the catalogs endpoint."
  }

  assert {
    condition     = msgraph_resource.catalog.body.displayName == "Engineering"
    error_message = "body.displayName must come from var.display_name."
  }

  assert {
    condition     = msgraph_resource.catalog.body.state == "unpublished"
    error_message = "state must default to unpublished."
  }

  assert {
    condition     = msgraph_resource.catalog.body.catalogType == "userManaged"
    error_message = "catalogType must default to userManaged."
  }

  assert {
    condition     = msgraph_resource.catalog.api_version == "v1.0"
    error_message = "api_version must default to v1.0."
  }

  assert {
    condition     = output.id == "11111111-1111-1111-1111-111111111111"
    error_message = "id output must expose the resource id."
  }

  assert {
    condition     = output.display_name == "Engineering"
    error_message = "display_name output must expose the response displayName."
  }
}

run "creates_published_catalog" {
  command = apply

  variables {
    display_name = "Engineering"
    description  = "Team catalog"
    state        = "published"
  }

  assert {
    condition     = msgraph_resource.catalog.body.state == "published"
    error_message = "state must be passed through to the request body."
  }

  assert {
    condition     = msgraph_resource.catalog.body.description == "Team catalog"
    error_message = "description must be passed through to the request body."
  }
}

run "rejects_empty_display_name" {
  command = plan

  variables {
    display_name = ""
  }

  expect_failures = [var.display_name]
}

run "rejects_invalid_state" {
  command = plan

  variables {
    display_name = "Engineering"
    state        = "hidden"
  }

  expect_failures = [var.state]
}

run "rejects_invalid_catalog_type" {
  command = plan

  variables {
    display_name = "Engineering"
    catalog_type = "custom"
  }

  expect_failures = [var.catalog_type]
}

run "rejects_invalid_api_version" {
  command = plan

  variables {
    display_name = "Engineering"
    api_version  = "v2.0"
  }

  expect_failures = [var.api_version]
}
