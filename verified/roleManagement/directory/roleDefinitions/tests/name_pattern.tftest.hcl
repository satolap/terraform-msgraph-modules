mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "11111111-1111-1111-1111-111111111111"
      output = {
        isBuiltIn  = false
        templateId = "22222222-2222-2222-2222-222222222222"
      }
    }
  }
}

variables {
  displayName = "Application metadata reader"
  rolePermissions = [{
    allowedResourceActions = ["microsoft.directory/applications/basic/read"]
  }]
}

# name_pattern: optional, null by default. When set, displayName must match it
# or the plan fails. The pattern uses placeholder segments, not a real convention.

run "accepts_any_display_name_without_name_pattern" {
  command = apply

  variables {
    displayName = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.roleDefinition.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any displayName must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = apply

  variables {
    displayName  = "ORG-DEV Application metadata reader"
    name_pattern = "^ORG-(DEV|PRD) "
  }

  assert {
    condition     = msgraph_resource.roleDefinition.body.displayName == "ORG-DEV Application metadata reader"
    error_message = "A displayName that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    displayName  = "Application metadata reader"
    name_pattern = "^ORG-(DEV|PRD) "
  }

  expect_failures = [msgraph_resource.roleDefinition]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(["
  }

  expect_failures = [var.name_pattern]
}
