# Graph returned no customExtensionStageSettings, or null, and the provider wrote the
# exported key with a null value. This is the shape the real provider produces, in
# the resource and in every data source. See custom_extension_read_back.tftest.hcl.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = null
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        catalog_id                      = "99999999-9999-9999-9999-999999999999"
        extension_ids                   = ["cccccccc-cccc-cccc-cccc-cccccccccccc"]
        custom_extension_stage_settings = null
      }
    }
  }
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"
}

run "returns_null_when_the_provider_wrote_the_bindings_as_null" {
  command = apply

  assert {
    condition     = output.custom_extension_stage_settings == null
    error_message = "A null read-back must give null, never an empty list that suggests there is no binding."
  }
}

run "does_not_fail_the_check_when_the_read_back_is_null_without_declared_bindings" {
  command = apply

  assert {
    condition     = jsonencode(msgraph_resource.assignment_policy.body.customExtensionStageSettings) == "[]"
    error_message = "The key must still be sent as an empty list."
  }
}

run "does_not_fail_the_check_when_the_read_back_is_null_with_declared_bindings" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  assert {
    condition     = output.custom_extension_stage_settings == null
    error_message = "The output must stay null while the provider wrote the bindings as null."
  }
}
