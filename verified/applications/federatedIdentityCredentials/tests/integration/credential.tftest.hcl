# Terraform test destroys fixture state even after an assertion failure.
# Failed provider cleanup retains private state in the live runner's recovery workspace.
run "create" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  assert {
    condition = alltrue([
      output.credential.id == output.id,
      output.credential.name == "tftest-credential",
      output.credential.issuer == "https://issuer.example.invalid",
      output.credential.subject == "system:serviceaccount:tftest:initial",
      toset(output.credential.audiences) == toset(["api://AzureADTokenExchange"]),
      output.credential.description == "Created by terraform test; safe to delete",
    ])
    error_message = "Independent GET must return the created credential and exact claims."
  }
}
run "update" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    subject     = "system:serviceaccount:tftest:updated"
    description = "Updated by terraform test; safe to delete"
  }
  assert {
    condition = alltrue([
      output.id == run.create.id,
      output.credential.subject == "system:serviceaccount:tftest:updated",
      output.credential.description == "Updated by terraform test; safe to delete",
    ])
    error_message = "PATCH must preserve identity and independently read back changed claims."
  }
}
run "destroy_credential" {
  command = apply
  module {
    source = "./tests/integration/fixture"
  }
  variables {
    enabled = false
  }
  assert {
    condition     = toset(output.remaining_names) == toset(["tftest-sibling"])
    error_message = "Destroy must remove only the target and preserve the application and sibling."
  }
}
