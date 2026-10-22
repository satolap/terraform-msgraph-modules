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

# name_pattern: optional, null by default. When set, display_name must match it
# or the plan fails. The pattern uses placeholder segments, not a real convention.

run "accepts_any_display_name_without_name_pattern" {
  command = apply

  variables {
    display_name = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.catalog.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any display_name must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = apply

  variables {
    display_name = "Example ORG-DEV-Name"
    name_pattern = "ORG-(DEV|PRD)-"
  }

  assert {
    condition     = msgraph_resource.catalog.body.displayName == "Example ORG-DEV-Name"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    display_name = "Example without the prefix"
    name_pattern = "^ORG-(DEV|PRD)-"
  }

  expect_failures = [msgraph_resource.catalog]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(unclosed"
  }

  expect_failures = [var.name_pattern]
}
