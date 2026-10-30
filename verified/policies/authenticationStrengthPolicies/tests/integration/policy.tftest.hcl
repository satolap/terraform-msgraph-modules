# Terraform test tears down the fixture on success or assertion failure.
# On partial first apply, retain the recovery workspace and repair/re-apply before destroy.
# This lifecycle probe creates no CA references; reference/refusal probes remain owner acceptance.
run "create" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  assert {
    condition = alltrue([
      output.policy.id == output.id,
      output.policy.policyType == "custom",
      startswith(output.policy.displayName, "tftest-strength-"),
      toset(output.policy.allowedCombinations) == toset(["fido2"]),
    ])
    error_message = "Independent GET must verify a new custom strength and its combinations."
  }
}
run "update" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    description  = "Updated by terraform test; safe to delete"
    combinations = ["fido2", "windowsHelloForBusiness"]
  }
  assert {
    condition = alltrue([
      output.id == run.create.id,
      output.policy.description == "Updated by terraform test; safe to delete",
      toset(output.policy.allowedCombinations) == toset(["fido2", "windowsHelloForBusiness"]),
    ])
    error_message = "Metadata PATCH and combinations action must preserve ID and match independent GET."
  }
}
run "destroy_policy" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    enabled    = false
    removed_id = run.create.id
  }
  assert {
    condition     = output.absent
    error_message = "The exact created custom strength must be absent after destroy."
  }
}
