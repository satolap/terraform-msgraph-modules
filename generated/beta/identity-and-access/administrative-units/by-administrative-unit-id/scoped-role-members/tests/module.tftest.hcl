# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    administrative_unit_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "administrativeUnits/test-parent-id/scopedRoleMembers"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["administrativeUnitId", "roleId", "roleMemberInfo"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    administrative_unit_id   = "test-parent-id"
    administrative_unit_id_2 = "example"
    role_member_info         = { "displayName" = null }
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["administrativeUnitId"]) == jsonencode("example")
    error_message = "administrativeUnitId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["roleMemberInfo"]) == jsonencode({ "@odata.type" = "#microsoft.graph.identity" })
    error_message = "roleMemberInfo must preserve typed values and omit nested nulls."
  }
}
