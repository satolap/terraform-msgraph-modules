# A mock that omits the customExtensionStageSettings key altogether. The provider
# itself writes the key as null; see custom_extension_read_back_null.tftest.hcl and
# custom_extension_read_back.tftest.hcl.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name = "Standard request policy"
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        catalog_id    = "99999999-9999-9999-9999-999999999999"
        extension_ids = ["cccccccc-cccc-cccc-cccc-cccccccccccc"]
      }
    }
  }
}

variables {
  access_package_id = "77777777-7777-7777-7777-777777777777"
  display_name      = "Standard request policy"
}

run "returns_null_when_graph_did_not_return_the_bindings" {
  command = apply

  assert {
    condition     = output.custom_extension_stage_settings == null
    error_message = "A read without the expanded stage settings must give null, never an empty list that suggests there is no binding."
  }
}

run "does_not_warn_about_undeclared_bindings_without_a_read_back" {
  command = apply

  variables {
    custom_extension_stage_settings = [
      { stage = "assignmentRequestCreated", extension_id = "cccccccc-cccc-cccc-cccc-cccccccccccc", extension_type = "request_workflow" },
    ]
  }

  assert {
    condition     = output.custom_extension_stage_settings == null
    error_message = "The output must stay null while Graph returns no stage settings."
  }
}
