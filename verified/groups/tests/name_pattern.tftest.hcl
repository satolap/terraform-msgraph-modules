mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "33333333-3333-3333-3333-333333333333"
      output = {
        display_name = "Engineering"
        mail         = null
      }
    }
  }
}

variables {
  display_name  = "Engineering"
  mail_nickname = "engineering"
}

# name_pattern: optional, null by default. When set, display_name must match it
# or the plan fails. The pattern uses placeholder segments, not a real convention.

run "accepts_any_display_name_without_name_pattern" {
  command = apply

  variables {
    display_name = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.group.body.displayName == "Not following any convention"
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
    condition     = msgraph_resource.group.body.displayName == "Example ORG-DEV-Name"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    display_name = "Example without the prefix"
    name_pattern = "^ORG-(DEV|PRD)-"
  }

  expect_failures = [msgraph_resource.group]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "(unclosed"
  }

  expect_failures = [var.name_pattern]
}

# mail_nickname_pattern: optional, null by default, checked like name_pattern.

run "accepts_a_mail_nickname_that_matches_mail_nickname_pattern" {
  command = apply

  variables {
    mail_nickname         = "prefix-org-dev-example"
    mail_nickname_pattern = "org-(dev|prd)-"
  }

  assert {
    condition     = msgraph_resource.group.body.mailNickname == "prefix-org-dev-example"
    error_message = "A mail_nickname that matches mail_nickname_pattern must be accepted."
  }
}

run "rejects_a_mail_nickname_that_does_not_match_mail_nickname_pattern" {
  command = plan

  variables {
    mail_nickname         = "example"
    mail_nickname_pattern = "^org-(dev|prd)-"
  }

  expect_failures = [msgraph_resource.group]
}

run "rejects_an_invalid_mail_nickname_pattern" {
  command = plan

  variables {
    mail_nickname_pattern = "(unclosed"
  }

  expect_failures = [var.mail_nickname_pattern]
}
