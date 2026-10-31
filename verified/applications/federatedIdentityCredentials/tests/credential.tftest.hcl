mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id     = "11111111-1111-1111-1111-111111111111"
      output = { id = "11111111-1111-1111-1111-111111111111", name = "github-main" }
    }
  }
}

variables {
  application-id = "AAAAAAAA-AAAA-4AAA-8AAA-AAAAAAAAAAAA"
  name           = "github-main"
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:example-org/example-repo:ref:refs/heads/main"
}

run "creates_only_one_v1_child_with_default_audience" {
  command = apply

  assert {
    condition     = msgraph_resource.credential.url == "applications/aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa/federatedIdentityCredentials" && msgraph_resource.credential.api_version == "v1.0"
    error_message = "Use the lower-case application object ID and Graph-cased child route on v1.0."
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body) == jsonencode({ name = var.name, issuer = var.issuer, subject = var.subject, audiences = ["api://AzureADTokenExchange"] })
    error_message = "Only the four required properties belong in the default create body."
  }
  assert {
    condition     = output.id == "11111111-1111-1111-1111-111111111111" && output.name == "github-main" && output.application_id == "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa"
    error_message = "Outputs must expose this credential and its normalized parent, without any token."
  }
}

run "parent_guid_case_change_keeps_credential" {
  command = apply
  variables { application-id = "aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa" }
  override_resource {
    target = msgraph_resource.credential
    values = {
      id     = "22222222-2222-2222-2222-222222222222"
      output = { id = "11111111-1111-1111-1111-111111111111", name = "github-main" }
    }
  }
  assert {
    condition     = output.id == run.creates_only_one_v1_child_with_default_audience.id
    error_message = "A case-only application GUID change must neither move nor replace a credential."
  }
}

run "mutable_claims_and_description_keep_credential" {
  command = apply
  variables {
    issuer      = "https://issuer.example/cluster/"
    subject     = "system:serviceaccount:example-namespace:example-service-account"
    audiences   = ["custom-audience"]
    description = "Kubernetes trust"
  }
  override_resource {
    target = msgraph_resource.credential
    values = {
      id     = "33333333-3333-3333-3333-333333333333"
      output = { id = "11111111-1111-1111-1111-111111111111", name = "github-main" }
    }
  }
  assert {
    condition     = output.id == run.creates_only_one_v1_child_with_default_audience.id && msgraph_resource.credential.update_method == "PATCH"
    error_message = "Claim and description changes must update this child in place with PATCH, never repeat creation POST."
  }
  assert {
    condition     = jsonencode(msgraph_resource.credential.body) == jsonencode({ name = "github-main", issuer = var.issuer, subject = var.subject, audiences = var.audiences, description = "Kubernetes trust" })
    error_message = "Mutable inputs must reach the body exactly, including the issuer trailing slash."
  }
}

run "unsetting_description_omits_without_replacing" {
  command = apply
  assert {
    condition     = output.id == run.creates_only_one_v1_child_with_default_audience.id && !contains(keys(msgraph_resource.credential.body), "description")
    error_message = "Null omits the description, without replacing; this is not evidence of a live clear."
  }
}

run "name_change_replaces_credential" {
  command = apply
  variables { name = "github-production" }
  override_resource {
    target = msgraph_resource.credential
    values = {
      id     = "44444444-4444-4444-4444-444444444444"
      output = { id = "44444444-4444-4444-4444-444444444444", name = "github-production" }
    }
  }
  assert {
    condition     = output.id == "44444444-4444-4444-4444-444444444444" && msgraph_resource.credential.body.name == "github-production"
    error_message = "A rename must replace and send the new name on creation, despite ignore_changes for PATCH."
  }
}

run "parent_change_replaces_credential" {
  command = apply
  variables {
    application-id = "BBBBBBBB-BBBB-4BBB-8BBB-BBBBBBBBBBBB"
    name           = "github-production"
  }
  override_resource {
    target = msgraph_resource.credential
    values = {
      id     = "55555555-5555-5555-5555-555555555555"
      output = { id = "55555555-5555-5555-5555-555555555555", name = "github-production" }
    }
  }
  assert {
    condition     = output.id == "55555555-5555-5555-5555-555555555555" && msgraph_resource.credential.url == "applications/bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb/federatedIdentityCredentials"
    error_message = "Moving to another application must replace, never PATCH the object under its old parent."
  }
}

run "name_case_is_significant_and_replaces" {
  command = apply
  variables {
    application-id = "bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb"
    name           = "GitHub-Production"
  }
  override_resource {
    target = msgraph_resource.credential
    values = {
      id     = "66666666-6666-6666-6666-666666666666"
      output = { id = "66666666-6666-6666-6666-666666666666", name = "GitHub-Production" }
    }
  }
  assert {
    condition     = output.id == "66666666-6666-6666-6666-666666666666" && msgraph_resource.credential.body.name == "GitHub-Production"
    error_message = "Only GUIDs may be normalized; a credential name's case change must replace."
  }
}
