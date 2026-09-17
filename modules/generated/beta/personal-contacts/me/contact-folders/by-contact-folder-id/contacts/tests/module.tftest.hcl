# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    contact_folder_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "me/contactFolders/test-parent-id/contacts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assistantName", "birthday", "categories", "children", "companyName", "createdDateTime", "department", "displayName", "emailAddresses", "extensions", "fileAs", "flag", "gender", "generation", "givenName", "imAddresses", "initials", "isFavorite", "jobTitle", "lastModifiedDateTime", "manager", "middleName", "nickName", "officeLocation", "parentFolderId", "personalNotes", "phones", "photo", "postalAddresses", "primaryEmailAddress", "profession", "secondaryEmailAddress", "spouseName", "surname", "tertiaryEmailAddress", "title", "websites", "weddingAnniversary", "yomiCompanyName", "yomiGivenName", "yomiSurname"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    contact_folder_id = "test-parent-id"
    assistant_name    = "example"
    is_favorite       = false
    categories        = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assistantName"]) == jsonencode("example")
    error_message = "assistantName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isFavorite"]) == jsonencode(false)
    error_message = "isFavorite must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["categories"]) == jsonencode(["example"])
    error_message = "categories must preserve typed values and omit nested nulls."
  }
}
