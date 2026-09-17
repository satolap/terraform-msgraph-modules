# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceAppManagement/mdmWindowsInformationProtectionPolicies"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["assignments", "azureRightsManagementServicesAllowed", "createdDateTime", "dataRecoveryCertificate", "description", "displayName", "enforcementLevel", "enterpriseDomain", "enterpriseInternalProxyServers", "enterpriseIPRanges", "enterpriseIPRangesAreAuthoritative", "enterpriseNetworkDomainNames", "enterpriseProtectedDomainNames", "enterpriseProxiedDomains", "enterpriseProxyServers", "enterpriseProxyServersAreAuthoritative", "exemptAppLockerFiles", "exemptApps", "version", "iconsVisible", "indexingEncryptedStoresOrItemsBlocked", "isAssigned", "lastModifiedDateTime", "neutralDomainResources", "protectedAppLockerFiles", "protectedApps", "protectionUnderLockConfigRequired", "revokeOnUnenrollDisabled", "rightsManagementServicesTemplateId", "roleScopeTagIds", "smbAutoEncryptedFileExtensions"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    created_date_time                        = "2026-01-01T00:00:00Z"
    azure_rights_management_services_allowed = false
    assignments                              = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["createdDateTime"]) == jsonencode("2026-01-01T00:00:00Z")
    error_message = "createdDateTime must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["azureRightsManagementServicesAllowed"]) == jsonencode(false)
    error_message = "azureRightsManagementServicesAllowed must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["assignments"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.targetedManagedAppPolicyAssignment" }])
    error_message = "assignments must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    enforcement_level = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.enforcement_level]
}
