mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
      output = {
        created_date_time       = "2026-01-01T00:00:00Z"
        last_modified_date_time = "2026-01-01T00:00:00Z"
      }
    }
  }
}

variables {
  displayName = "Grant manager access"

  logic_app = {
    subscriptionId       = "11111111-1111-4111-8111-111111111111"
    resourceGroupName    = "rg-example"
    logicAppWorkflowName = "example-logic-app"
  }

  authentication_resource_id = "22222222-2222-4222-8222-222222222222"
}

# expect_failures does not read messages; the README documents each rule and
# tests/test_lifecycle_custom_task_extensions_module.py asserts the messages.

run "rejects_an_empty_display_name" {
  command = plan

  variables {
    displayName = "  "
  }

  expect_failures = [var.displayName]
}

run "rejects_a_subscription_id_that_is_not_a_guid" {
  command = plan

  variables {
    logic_app = {
      subscriptionId       = "my-subscription"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "example-logic-app"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_subscription_id_with_trailing_text" {
  command = plan

  variables {
    logic_app = {
      subscriptionId       = "11111111-1111-4111-8111-111111111111\n"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "example-logic-app"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_an_empty_resource_group" {
  command = plan

  variables {
    logic_app = {
      subscriptionId       = "11111111-1111-4111-8111-111111111111"
      resourceGroupName    = ""
      logicAppWorkflowName = "example-logic-app"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_logic_app_name_with_a_path_separator" {
  command = plan

  variables {
    logic_app = {
      subscriptionId       = "11111111-1111-4111-8111-111111111111"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = "group/app"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_a_logic_app_name_with_surrounding_space" {
  command = plan

  variables {
    logic_app = {
      subscriptionId       = "11111111-1111-4111-8111-111111111111"
      resourceGroupName    = "rg-example"
      logicAppWorkflowName = " example-logic-app"
    }
  }

  expect_failures = [var.logic_app]
}

run "rejects_an_authentication_resource_id_that_is_not_a_guid" {
  command = plan

  variables {
    authentication_resource_id = "api://example"
  }

  expect_failures = [var.authentication_resource_id]
}

run "accepts_the_timeout_limits" {
  command = plan

  variables {
    timeout_in_milliseconds = 200
  }

  assert {
    condition     = msgraph_resource.extension.body.clientConfiguration.timeoutInMilliseconds == 200
    error_message = "200 milliseconds is the documented lower bound."
  }
}

run "rejects_a_timeout_below_the_range" {
  command = plan

  variables {
    timeout_in_milliseconds = 199
  }

  expect_failures = [var.timeout_in_milliseconds]
}

run "rejects_a_timeout_above_the_range" {
  command = plan

  variables {
    timeout_in_milliseconds = 2001
  }

  expect_failures = [var.timeout_in_milliseconds]
}

run "rejects_a_fractional_timeout" {
  command = plan

  variables {
    timeout_in_milliseconds = 500.5
  }

  expect_failures = [var.timeout_in_milliseconds]
}

run "accepts_one_retry" {
  command = plan

  variables {
    maximum_retries = 1
  }

  assert {
    condition     = msgraph_resource.extension.body.clientConfiguration.maximumRetries == 1
    error_message = "One retry is documented as supported."
  }
}

run "rejects_two_retries" {
  command = plan

  variables {
    maximum_retries = 2
  }

  expect_failures = [var.maximum_retries]
}

run "accepts_the_callback_duration_limits" {
  command = plan

  variables {
    callback_timeout_duration = "PT30M"
  }

  assert {
    condition     = msgraph_resource.extension.body.callbackConfiguration.timeoutDuration == "PT30M"
    error_message = "30 minutes is the documented lower bound."
  }
}

run "accepts_hours_and_minutes_together" {
  command = plan

  variables {
    callback_timeout_duration = "PT2H30M"
  }

  assert {
    condition     = msgraph_resource.extension.body.callbackConfiguration.timeoutDuration == "PT2H30M"
    error_message = "A duration of hours and minutes must be accepted."
  }
}

run "accepts_three_hours" {
  command = plan

  variables {
    callback_timeout_duration = "PT3H"
  }

  assert {
    condition     = msgraph_resource.extension.body.callbackConfiguration.timeoutDuration == "PT3H"
    error_message = "Three hours is the documented upper bound."
  }
}

run "rejects_a_callback_duration_below_thirty_minutes" {
  command = plan

  variables {
    callback_timeout_duration = "PT29M"
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_a_callback_duration_above_three_hours" {
  command = plan

  variables {
    callback_timeout_duration = "PT3H1M"
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_a_callback_duration_that_is_not_hours_and_minutes" {
  command = plan

  variables {
    callback_timeout_duration = "P1D"
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_an_empty_callback_duration" {
  command = plan

  variables {
    callback_timeout_duration = ""
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_an_invalid_name_pattern" {
  command = plan

  variables {
    name_pattern = "("
  }

  expect_failures = [var.name_pattern]
}

run "accepts_the_normalised_hour_and_minute_form" {
  command = plan

  variables {
    callback_timeout_duration = "PT1H30M"
  }

  assert {
    condition     = msgraph_resource.extension.body.callbackConfiguration.timeoutDuration == "PT1H30M"
    error_message = "PT1H30M is the normalised form of ninety minutes."
  }
}

run "rejects_minutes_of_sixty_or_more" {
  command = plan

  variables {
    callback_timeout_duration = "PT90M"
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_a_zero_hour_prefix" {
  command = plan

  variables {
    callback_timeout_duration = "PT0H30M"
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_minutes_of_sixty_after_an_hour" {
  command = plan

  variables {
    callback_timeout_duration = "PT1H60M"
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_a_leading_zero_in_the_hours" {
  command = plan

  variables {
    callback_timeout_duration = "PT01H"
  }

  expect_failures = [var.callback_timeout_duration]
}

run "rejects_a_maximal_duration_written_in_minutes" {
  command = plan

  variables {
    callback_timeout_duration = "PT180M"
  }

  expect_failures = [var.callback_timeout_duration]
}
