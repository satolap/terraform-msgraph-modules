mock_provider "msgraph" {}

variables {
  displayName         = "Custom strength"
  allowedCombinations = ["fido2"]
}

run "rejects_empty_name" {
  command = plan
  variables {
    displayName = " "
  }
  expect_failures = [var.displayName]
}

run "rejects_empty_combinations" {
  command = plan
  variables {
    allowedCombinations = []
  }
  expect_failures = [var.allowedCombinations]
}

run "rejects_null_combination" {
  command = plan
  variables {
    allowedCombinations = [null]
  }
  expect_failures = [var.allowedCombinations]
}

run "rejects_unknown_flag" {
  command = plan
  variables {
    allowedCombinations = ["notAMethod"]
  }
  expect_failures = [var.allowedCombinations]
}

run "rejects_future_enum" {
  command = plan
  variables {
    allowedCombinations = ["unknownFutureValue"]
  }
  expect_failures = [var.allowedCombinations]
}

run "rejects_unsupported_flag_combination" {
  command = plan
  variables {
    allowedCombinations = ["fido2,password"]
  }
  expect_failures = [var.allowedCombinations]
}

run "rejects_noncanonical_combination" {
  command = plan
  variables {
    allowedCombinations = ["password, sms"]
  }
  expect_failures = [var.allowedCombinations]
}

run "rejects_empty_aaguids" {
  command = plan
  variables {
    allowedAAGUIDs = []
  }
  expect_failures = [var.allowedAAGUIDs]
}

run "rejects_null_aaguid" {
  command = plan
  variables {
    allowedAAGUIDs = [null]
  }
  expect_failures = [var.allowedAAGUIDs]
}

run "rejects_invalid_aaguid" {
  command = plan
  variables {
    allowedAAGUIDs = ["not-a-guid"]
  }
  expect_failures = [var.allowedAAGUIDs]
}

run "rejects_unknown_certificate_combination" {
  command = plan
  variables {
    x509CertificateCombinationConfigurations = { fido2 = { allowedIssuerSkis = ["AA"] } }
  }
  expect_failures = [var.x509CertificateCombinationConfigurations]
}

run "rejects_unknown_certificate_property" {
  command = plan
  variables {
    x509CertificateCombinationConfigurations = { x509CertificateMultiFactor = { unsupported = ["AA"] } }
  }
  expect_failures = [var.x509CertificateCombinationConfigurations]
}

run "rejects_empty_certificate_configuration" {
  command = plan
  variables {
    x509CertificateCombinationConfigurations = { x509CertificateMultiFactor = {} }
  }
  expect_failures = [var.x509CertificateCombinationConfigurations]
}

run "rejects_null_certificate_configuration" {
  command = plan
  variables {
    x509CertificateCombinationConfigurations = { x509CertificateMultiFactor = null }
  }
  expect_failures = [var.x509CertificateCombinationConfigurations]
}

run "rejects_null_certificate_values" {
  command = plan
  variables {
    x509CertificateCombinationConfigurations = { x509CertificateMultiFactor = { allowedIssuerSkis = null } }
  }
  expect_failures = [var.x509CertificateCombinationConfigurations]
}

run "rejects_blank_certificate_value" {
  command = plan
  variables {
    x509CertificateCombinationConfigurations = { x509CertificateMultiFactor = { allowedPolicyOIDs = [" "] } }
  }
  expect_failures = [var.x509CertificateCombinationConfigurations]
}

