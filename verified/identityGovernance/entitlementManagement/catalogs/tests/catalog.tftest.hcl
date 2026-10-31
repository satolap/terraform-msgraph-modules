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
  displayName = "Engineering"
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
    condition     = !contains(keys(msgraph_resource.catalog.body), "catalogType")
    error_message = "The create request does not take catalogType, so the body must not carry it."
  }

  assert {
    condition     = output.catalog_type == "userManaged"
    error_message = "catalog_type output must read the type back from Microsoft Graph."
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

  assert {
    condition = jsonencode(msgraph_resource.catalog.body) == jsonencode({
      description = null
      displayName = "Engineering"
      state       = "unpublished"
    })
    error_message = "Without is_externally_visible the body must hold exactly the documented create properties displayName, description and state."
  }

  assert {
    condition     = output.is_externally_visible == null
    error_message = "is_externally_visible output must be null when the input is not set."
  }
}

run "sends_external_visibility_when_set" {
  command = apply

  variables {
    displayName         = "Engineering"
    isExternallyVisible = true
  }

  assert {
    condition     = msgraph_resource.catalog.body.isExternallyVisible == true
    error_message = "is_externally_visible = true must be sent as isExternallyVisible."
  }

  assert {
    condition     = output.is_externally_visible == true
    error_message = "is_externally_visible output must expose the configured value."
  }
}

# The previous run created the catalog; the mock keeps its id on an in-place
# update, which a PATCH of isExternallyVisible is.
run "changes_external_visibility_in_place" {
  command = apply

  variables {
    displayName         = "Engineering"
    isExternallyVisible = false
  }

  assert {
    condition     = msgraph_resource.catalog.body.isExternallyVisible == false
    error_message = "is_externally_visible = false must be sent, not left out."
  }

  assert {
    condition     = msgraph_resource.catalog.id == "11111111-1111-1111-1111-111111111111"
    error_message = "Changing is_externally_visible must update the catalog in place."
  }
}

run "creates_published_catalog" {
  command = apply

  variables {
    displayName = "Engineering"
    description = "Team catalog"
    state       = "published"
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
    displayName = ""
  }

  expect_failures = [var.displayName]
}

run "rejects_invalid_state" {
  command = plan

  variables {
    displayName = "Engineering"
    state       = "hidden"
  }

  expect_failures = [var.state]
}

# catalog_type is deprecated: "userManaged", the former default, is still
# accepted so that existing callers keep working, and changes nothing.
run "accepts_the_deprecated_user_managed_catalog_type" {
  command = plan

  variables {
    displayName         = "Engineering"
    catalog_type        = "userManaged"
    isExternallyVisible = true
  }

  assert {
    condition = jsonencode(msgraph_resource.catalog.body) == jsonencode({
      description         = null
      displayName         = "Engineering"
      isExternallyVisible = true
      state               = "unpublished"
    })
    error_message = "A configured catalog_type must not add catalogType to the body."
  }
}

run "rejects_the_service_default_catalog_type" {
  command = plan

  variables {
    displayName  = "Engineering"
    catalog_type = "serviceDefault"
  }

  expect_failures = [var.catalog_type]
}

run "rejects_invalid_catalog_type" {
  command = plan

  variables {
    displayName  = "Engineering"
    catalog_type = "custom"
  }

  expect_failures = [var.catalog_type]
}

run "rejects_invalid_api_version" {
  command = plan

  variables {
    displayName = "Engineering"
    api_version = "v2.0"
  }

  expect_failures = [var.api_version]
}
