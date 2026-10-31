mock_provider "msgraph" {}

variables {
  displayName = "Example ORG-DEV-Terms of use"

  default_file = {
    language       = "en"
    fileName       = "TOU.pdf"
    content_base64 = "JVBERi0xLjQgc3ludGhldGljIGVuZ2xpc2g="
  }
}

run "accepts_any_display_name_without_name_pattern" {
  command = plan

  variables {
    displayName = "Not following any convention"
  }

  assert {
    condition     = msgraph_resource.agreement.body.displayName == "Not following any convention"
    error_message = "Without name_pattern, any display_name must be accepted."
  }
}

run "accepts_a_display_name_that_matches_name_pattern" {
  command = plan

  variables {
    name_pattern = "^Example ORG-(DEV|PRD)-"
  }

  assert {
    condition     = msgraph_resource.agreement.body.displayName == "Example ORG-DEV-Terms of use"
    error_message = "A display_name that matches name_pattern must be accepted."
  }
}

run "rejects_a_display_name_that_does_not_match_name_pattern" {
  command = plan

  variables {
    name_pattern = "^Example ORG-PRD-"
  }

  expect_failures = [msgraph_resource.agreement]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "("
  }

  expect_failures = [var.name_pattern]
}
