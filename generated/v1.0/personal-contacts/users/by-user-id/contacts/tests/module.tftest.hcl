# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    user_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "users/test-parent-id/contacts"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assistantName", "birthday", "businessAddress", "businessHomePage", "businessPhones", "categories", "children", "companyName", "createdDateTime", "department", "displayName", "emailAddresses", "fileAs", "generation", "givenName", "homeAddress", "homePhones", "imAddresses", "initials", "jobTitle", "lastModifiedDateTime", "manager", "middleName", "mobilePhone", "nickName", "officeLocation", "otherAddress", "parentFolderId", "personalNotes", "photo", "primaryEmailAddress", "profession", "secondaryEmailAddress", "spouseName", "surname", "tertiaryEmailAddress", "title", "yomiCompanyName", "yomiGivenName", "yomiSurname"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    user_id         = "test-parent-id"
    assistant_name  = "example"
    business_phones = ["example"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assistantName"]) == jsonencode("example")
    error_message = "assistantName must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["businessPhones"]) == jsonencode(["example"])
    error_message = "businessPhones must preserve typed values and omit nested nulls."
  }
}
