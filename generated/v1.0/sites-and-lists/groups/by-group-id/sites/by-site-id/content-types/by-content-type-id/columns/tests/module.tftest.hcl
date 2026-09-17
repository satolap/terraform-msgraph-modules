# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    group_id        = "test-parent-id"
    site_id         = "test-parent-id"
    content_type_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "groups/test-parent-id/sites/test-parent-id/contentTypes/test-parent-id/columns"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["boolean", "calculated", "choice", "columnGroup", "contentApprovalStatus", "currency", "dateTime", "defaultValue", "description", "displayName", "enforceUniqueValues", "geolocation", "hidden", "hyperlinkOrPicture", "indexed", "isDeletable", "isSealed", "lookup", "name", "number", "personOrGroup", "propagateChanges", "readOnly", "required", "sourceColumn", "term", "text", "thumbnail", "validation"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    group_id              = "test-parent-id"
    site_id               = "test-parent-id"
    content_type_id       = "test-parent-id"
    column_group          = "example"
    enforce_unique_values = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["columnGroup"]) == jsonencode("example")
    error_message = "columnGroup must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["enforceUniqueValues"]) == jsonencode(false)
    error_message = "enforceUniqueValues must preserve typed values and omit nested nulls."
  }
}
