# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "agentRegistry/agentInstances"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["additionalInterfaces", "agentCardManifest", "agentIdentityBlueprintId", "agentIdentityId", "collections", "displayName", "lastModifiedDateTime", "managedBy", "originatingStore", "ownerIds", "preferredTransport", "signatures", "sourceAgentId", "url"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    agent_identity_blueprint_id = "example"
    additional_interfaces       = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["agentIdentityBlueprintId"]) == jsonencode("example")
    error_message = "agentIdentityBlueprintId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["additionalInterfaces"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.agentInterface" }])
    error_message = "additionalInterfaces must preserve typed values and omit nested nulls."
  }
}
