# Offline check of the live suite's setup module (tests/integration/setup), which the
# offline validation does not otherwise load. The requestor and the approver must not
# share an initial password: the requestor could sign in as the approver, set a new
# password at the forced change prompt and approve its own request. Each user therefore
# has its own random_password and no input supplies one. The mocked random provider
# generates each result independently, and the msgraph-backed modules are replaced by
# their outputs, so nothing real is created. tests/test_fixture_passwords.py checks that
# each user module reads its own resource.

mock_provider "msgraph" {}
mock_provider "random" {}

run "setup_passwords_are_independent" {
  command = apply

  module {
    source = "./tests/integration/setup"
  }

  variables {
    verified_domain = "contoso.com"
  }

  override_module {
    target = module.requestor
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.approver
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.test_population
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.catalog
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  override_module {
    target = module.access_package
    outputs = {
      id = "11111111-1111-1111-1111-111111111111"
    }
  }

  assert {
    condition     = length(nonsensitive(random_password.requestor.result)) > 0 && length(nonsensitive(random_password.approver.result)) > 0
    error_message = "Both fixture users must receive a generated initial password."
  }

  assert {
    condition     = nonsensitive(random_password.requestor.result != random_password.approver.result)
    error_message = "The requestor and the approver must not share an initial password."
  }
}
