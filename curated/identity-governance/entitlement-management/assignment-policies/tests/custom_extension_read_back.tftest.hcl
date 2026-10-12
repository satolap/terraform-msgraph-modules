# Read-back of the bindings. A mock resource keeps its computed output across the
# runs of a file once it exists, so each read-back shape has its own file:
# custom_extension_stage_settings.tftest.hcl (an empty list),
# this file (two bindings), custom_extension_read_back_missing.tftest.hcl (no key at
# all) and custom_extension_read_back_null.tftest.hcl (the key written as null, which
# is what the provider does when Graph returns no stage settings).
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name = "Standard request policy"
        custom_extension_stage_settings = [
          { stage = "assignmentRequestApproved", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc" },
          { stage = "assignmentRequestRemoved", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd" },
        ]
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        catalog_id = "99999999-9999-9999-9999-999999999999"
        extension_ids = [
          "cccccccc-cccc-cccc-cccc-cccccccccccc",
          "dddddddd-dddd-dddd-dddd-dddddddddddd",
        ]
        custom_extension_stage_settings = [
          { stage = "assignmentRequestApproved", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc" },
          { stage = "assignmentRequestRemoved", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd" },
        ]
      }
    }
  }
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"
}

run "returns_the_bindings_read_back_from_graph" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestApproved", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
      { stage = "assignmentRequestRemoved", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd", extension_type = "request_workflow" },
    ]
  }

  assert {
    condition = jsonencode(output.custom_extension_stage_settings) == jsonencode([
      { stage = "assignmentRequestApproved", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc" },
      { stage = "assignmentRequestRemoved", extension_id = "dddddddd-dddd-dddd-dddd-dddddddddddd" },
    ])
    error_message = "The output must return the stage and extension id of every binding that Graph returned, in the order it returned them."
  }
}

# The output reports what Graph has, not what the configuration declares; the
# check warns that the next apply removes the binding that is not declared.
run "returns_a_binding_that_the_configuration_does_not_declare" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestApproved", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  expect_failures = [check.undeclared_custom_extension_bindings]

  assert {
    condition     = length(output.custom_extension_stage_settings) == 2
    error_message = "A binding that exists only on the server must still be returned."
  }
}
