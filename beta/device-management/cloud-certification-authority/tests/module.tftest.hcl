# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "deviceManagement/cloudCertificationAuthority"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["certificateKeySize", "certificationAuthorityStatus", "cloudCertificationAuthorityHashingAlgorithm", "cloudCertificationAuthorityLeafCertificate", "cloudCertificationAuthorityType", "description", "displayName", "eTag", "issuerCommonName", "keyPlatform", "lastModifiedDateTime", "roleScopeTagIds", "validityPeriodInYears"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    certificate_key_size                           = "unknown"
    validity_period_in_years                       = -2147483648
    cloud_certification_authority_leaf_certificate = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["certificateKeySize"]) == jsonencode("unknown")
    error_message = "certificateKeySize must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["validityPeriodInYears"]) == jsonencode(-2147483648)
    error_message = "validityPeriodInYears must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["cloudCertificationAuthorityLeafCertificate"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.cloudCertificationAuthorityLeafCertificate" }])
    error_message = "cloudCertificationAuthorityLeafCertificate must preserve typed values and omit nested nulls."
  }
}

run "invalid_enum" {
  command = plan

  variables {
    certificate_key_size = "__graphmodules_invalid_enum__"
  }

  expect_failures = [var.certificate_key_size]
}
