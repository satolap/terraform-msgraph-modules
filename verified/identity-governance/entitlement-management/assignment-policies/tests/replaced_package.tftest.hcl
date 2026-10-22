# The access package is replaced, new one first, in the same apply that
# replaces the policy, as when the access-packages module moves a package to
# another catalog. The new package id is unknown while the plan replaces the
# policy. The runs share the state of the helper configuration in file order.
mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "88888888-8888-8888-8888-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  mock_data "msgraph_resource" {
    defaults = {
      output = {
        custom_extension_stage_settings = []
      }
    }
  }
}

run "creates_the_package_and_the_policy" {
  command = apply

  module {
    source = "./tests/replaced_package"
  }

  override_resource {
    target = module.policy.msgraph_resource.assignment_policy
    values = {
      id = "eeeeeeee-eeee-eeee-eeee-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  assert {
    condition     = output.policy_access_package_id == output.access_package_id
    error_message = "The policy must name the access package."
  }
}

run "a_replaced_package_replaces_the_policy" {
  command = apply

  module {
    source = "./tests/replaced_package"
  }

  variables {
    package_seed = "second"
  }

  override_resource {
    target = module.policy.msgraph_resource.assignment_policy
    values = {
      id = "ffffffff-ffff-ffff-ffff-888888888888"
      output = {
        display_name                    = "Standard request policy"
        custom_extension_stage_settings = []
      }
    }
  }

  assert {
    condition     = output.access_package_id != run.creates_the_package_and_the_policy.access_package_id
    error_message = "The helper must replace the access package."
  }

  assert {
    condition     = output.policy_id == "ffffffff-ffff-ffff-ffff-888888888888"
    error_message = "A replaced access package must replace the policy, which then names the new package id."
  }

  assert {
    condition     = output.policy_access_package_id == output.access_package_id
    error_message = "The replacement policy must name the new access package."
  }
}
