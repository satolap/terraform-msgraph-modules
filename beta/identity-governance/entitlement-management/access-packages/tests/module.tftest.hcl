# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "identityGovernance/entitlementManagement/accessPackages"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["accessPackageCatalog", "accessPackageResourceRoleScopes", "description", "displayName", "incompatibleAccessPackages", "incompatibleGroups", "isHidden", "isRoleScopesVisible", "uniqueName"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    description                         = "example"
    is_hidden                           = false
    access_package_resource_role_scopes = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["description"]) == jsonencode("example")
    error_message = "description must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["isHidden"]) == jsonencode(false)
    error_message = "isHidden must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["accessPackageResourceRoleScopes"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.accessPackageResourceRoleScope" }])
    error_message = "accessPackageResourceRoleScopes must preserve typed values and omit nested nulls."
  }
}
