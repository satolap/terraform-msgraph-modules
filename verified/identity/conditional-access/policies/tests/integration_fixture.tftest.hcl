# Offline check of the live suite's setup module (tests/integration/setup), which the
# offline validation does not otherwise load. The disabled stand-in emergency access
# user gets its own random password; no input supplies one, so it cannot share a
# password with another fixture user. The msgraph-backed modules are replaced by their
# outputs, so nothing real is created.

mock_provider "msgraph" {}
mock_provider "random" {}

run "setup_generates_the_user_password" {
  command = apply

  module {
    source = "./tests/integration/setup"
  }

  variables {
    verified_domain = "contoso.com"
  }

  override_module {
    target = module.break_glass_user
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.target_group
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.break_glass_group
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.ip_location
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.country_location
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  assert {
    condition     = length(nonsensitive(random_password.break_glass_user.result)) > 0
    error_message = "The fixture user must receive a generated initial password."
  }
}
