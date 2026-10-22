# Fixtures follow the List subscribedSkus response for the selected properties. The
# servicePlans lists copy the Microsoft Entra ID P1 and P2 product rows of the Learn
# licensing service plan reference; the P2 product also lists AAD_PREMIUM.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        skus      = []
      }
    }
  }
}

# The free tier needs no premium plan and reads nothing.
run "free_reads_no_licences" {
  command = plan

  variables {
    tier = "free"
  }

  assert {
    condition     = length(data.msgraph_resource.subscribed_skus) == 0
    error_message = "The free tier must not read subscribedSkus."
  }

  assert {
    condition     = output.tier == "free"
    error_message = "The tier output must pass the validated tier through."
  }

  assert {
    condition     = length(output.licensed_skus) == 0
    error_message = "The free tier has no licensed SKUs."
  }
}

# A tenant with only Microsoft Entra ID P1 passes p1.
run "p1_only_licenses_p1" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = data.msgraph_resource.subscribed_skus[0].url == "subscribedSkus"
    error_message = "The guard must read the subscribedSkus collection."
  }

  assert {
    condition     = data.msgraph_resource.subscribed_skus[0].api_version == "v1.0"
    error_message = "The guard must read subscribedSkus from v1.0."
  }

  assert {
    condition     = data.msgraph_resource.subscribed_skus[0].query_parameters["$select"][0] == "skuId,skuPartNumber,capabilityStatus,prepaidUnits,servicePlans" && length(data.msgraph_resource.subscribed_skus[0].query_parameters) == 1
    error_message = "The read must select only the properties the guard evaluates."
  }

  assert {
    condition     = output.tier == "p1"
    error_message = "The tier output must pass the validated tier through."
  }

  assert {
    condition     = [for sku in output.licensed_skus : sku.sku_part_number] == ["AAD_PREMIUM"]
    error_message = "The P1 SKU must be reported as licensed."
  }

  assert {
    condition     = output.licensed_skus[0].capability_status == "Enabled" && output.licensed_skus[0].prepaid_units.enabled == 25
    error_message = "Licensed SKUs must expose their state and prepaid units."
  }

  assert {
    condition     = output.licensed_skus[0].sku_id == "00000000-0000-4000-8000-000000000001"
    error_message = "Licensed SKUs must expose their skuId."
  }
}

# P1 alone does not license p2, and no SKU lists the P2 plan.
run "p2_with_only_p1_fails" {
  command = plan

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = length(local.unusable_skus) == 0
    error_message = "No SKU lists AAD_PREMIUM_P2, so none is reported as unusable."
  }

  assert {
    condition     = local.licence_error == "Tier p2 is not licensed: no subscribed SKU with capabilityStatus Enabled and enabled prepaid units lists Microsoft Entra ID P2 (AAD_PREMIUM_P2 eec0eb4f-6444-4f95-aba0-50c24d67f998). No subscribed SKU lists the plan."
    error_message = "The error must name the tier's plan and say that no SKU lists it."
  }
}

# With P1 and P2, only the P2 SKU licenses p2.
run "p1_and_p2_license_p2" {
  command = plan

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = [for sku in output.licensed_skus : sku.sku_part_number] == ["AAD_PREMIUM_P2"]
    error_message = "Only the SKU listing AAD_PREMIUM_P2 licenses p2."
  }
}

# With P1 and P2, both SKUs list AAD_PREMIUM and license p1.
run "p1_and_p2_license_p1" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = [for sku in output.licensed_skus : sku.sku_part_number] == ["AAD_PREMIUM", "AAD_PREMIUM_P2"]
    error_message = "Both SKUs list AAD_PREMIUM and license p1."
  }
}

# The P2 product includes AAD_PREMIUM, so a P2-only tenant passes p1.
run "p2_only_licenses_p1" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = [for sku in output.licensed_skus : sku.sku_part_number] == ["AAD_PREMIUM_P2"]
    error_message = "A P2-only tenant must pass p1 through the AAD_PREMIUM plan of its SKU."
  }
}

# Each non-Enabled state fails on its own. Learn defines Enabled as having at least one
# enabled unit, so a real SKU in another state usually reports 0 enabled units, which the
# units rule rejects too. These state runs report enabled units, so that only the
# capabilityStatus rule can fail them; the error names the SKU and its state.
run "suspended_sku_fails_naming_its_state" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Suspended"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 20, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = local.unusable_skus == ["AAD_PREMIUM_P2 (Suspended, 5 enabled units)"]
    error_message = "A Suspended SKU must fail the guard even with enabled units."
  }

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM_P2 (Suspended, 5 enabled units).")
    error_message = "The error must name the SKU and its Suspended state."
  }
}

# A SKU in the Warning (grace period) state does not satisfy the guard.
run "warning_sku_fails_naming_its_state" {
  command = plan

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Warning"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 20 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = local.unusable_skus == ["AAD_PREMIUM_P2 (Warning, 5 enabled units)"]
    error_message = "A Warning SKU must fail the guard even with enabled units."
  }

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM_P2 (Warning, 5 enabled units).")
    error_message = "The error must name the SKU and its Warning state."
  }
}

# A SKU in the LockedOut state (a cancelled subscription) does not satisfy the guard.
run "locked_out_sku_fails_naming_its_state" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "LockedOut"
            prepaidUnits     = { enabled = 5, lockedOut = 20, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = local.unusable_skus == ["AAD_PREMIUM (LockedOut, 5 enabled units)"]
    error_message = "A LockedOut SKU must fail the guard even with enabled units."
  }

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM (LockedOut, 5 enabled units).")
    error_message = "The error must name the SKU and its LockedOut state."
  }
}

# A SKU in the Deleted state does not satisfy the guard.
run "deleted_sku_fails_naming_its_state" {
  command = plan

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Deleted"
            prepaidUnits     = { enabled = 5, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = local.unusable_skus == ["AAD_PREMIUM_P2 (Deleted, 5 enabled units)"]
    error_message = "A Deleted SKU must fail the guard even with enabled units."
  }

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM_P2 (Deleted, 5 enabled units).")
    error_message = "The error must name the SKU and its Deleted state."
  }
}

# An Enabled SKU needs at least one enabled prepaid unit.
run "enabled_sku_without_enabled_units_fails" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 0, lockedOut = 0, suspended = 0, warning = 10 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = local.unusable_skus == ["AAD_PREMIUM (Enabled, 0 enabled units)"]
    error_message = "An Enabled SKU without enabled units must fail the guard."
  }

  assert {
    condition     = endswith(local.licence_error, "SKUs that list the plan but do not qualify: AAD_PREMIUM (Enabled, 0 enabled units).")
    error_message = "The error must name the SKU and its enabled units."
  }
}

# Non-Enabled SKUs do not count, but they do not block an Enabled SKU either.
run "suspended_sku_does_not_hide_an_enabled_one" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000015"
            skuPartNumber    = "AAD_PREMIUM_P2"
            capabilityStatus = "Suspended"
            prepaidUnits     = { enabled = 0, lockedOut = 0, suspended = 25, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "eec0eb4f-6444-4f95-aba0-50c24d67f998", servicePlanName = "AAD_PREMIUM_P2", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
          {
            skuId            = "00000000-0000-4000-8000-000000000001"
            skuPartNumber    = "AAD_PREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "41781fb2-bc02-4b7c-bd55-b576c07bb09d", servicePlanName = "AAD_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000019", servicePlanName = "ADALLOM_S_DISCOVERY", provisioningStatus = "Success", appliesTo = "User" },
              { servicePlanId = "00000000-0000-4000-8000-000000000004", servicePlanName = "EXCHANGE_S_FOUNDATION", provisioningStatus = "Success", appliesTo = "Company" },
              { servicePlanId = "00000000-0000-4000-8000-000000000016", servicePlanName = "MFA_PREMIUM", provisioningStatus = "Success", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  assert {
    condition     = [for sku in output.licensed_skus : sku.sku_part_number] == ["AAD_PREMIUM"]
    error_message = "Only the Enabled SKU licenses the tier."
  }
}

# Subscriptions without an Entra ID premium plan fail p1 (SKUs from the List subscribedSkus example).
run "no_premium_plan_fails" {
  command = plan

  variables {
    tier = "p1"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
          {
            skuId            = "00000000-0000-4000-8000-000000000022"
            skuPartNumber    = "ENTERPRISEPREMIUM"
            capabilityStatus = "Enabled"
            prepaidUnits     = { enabled = 25, lockedOut = 0, suspended = 0, warning = 0 }
            servicePlans = [
              { servicePlanId = "00000000-0000-4000-8000-000000000017", servicePlanName = "ADALLOM_S_O365", provisioningStatus = "Success", appliesTo = "Company" },
            ]
          },
          {
            skuId            = "00000000-0000-4000-8000-000000000023"
            skuPartNumber    = "CRMSTANDARD"
            capabilityStatus = "Suspended"
            prepaidUnits     = { enabled = 0, lockedOut = 0, suspended = 25, warning = 0 }
            servicePlans = [
              { servicePlanId = "00000000-0000-4000-8000-000000000056", servicePlanName = "CRMSTANDARD", provisioningStatus = "Disabled", appliesTo = "User" },
            ]
          },
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = length(local.plan_skus) == 0
    error_message = "No SKU lists a premium plan."
  }

  assert {
    condition     = endswith(local.licence_error, "lists Microsoft Entra ID P1 (AAD_PREMIUM 41781fb2-bc02-4b7c-bd55-b576c07bb09d). No subscribed SKU lists the plan.")
    error_message = "The error must name the tier's plan and say that no SKU lists it."
  }
}

# A tenant without subscriptions fails every premium tier.
run "tenant_without_skus_fails" {
  command = plan

  variables {
    tier = "p2"
  }

  override_data {
    target = data.msgraph_resource.subscribed_skus
    values = {
      output = {
        next_link = null
        skus = [
        ]
      }
    }
  }

  expect_failures = [output.tier]

  assert {
    condition     = endswith(local.licence_error, "No subscribed SKU lists the plan.")
    error_message = "The error must say that no SKU lists the plan."
  }
}

# Only free, p1 and p2 exist; there is no automatic tier.
run "rejects_unknown_tier" {
  command = plan

  variables {
    tier = "auto"
  }

  expect_failures = [var.tier]
}

# A caller restricts the tiers it supports.
run "rejects_a_tier_the_caller_does_not_support" {
  command = plan

  variables {
    tier          = "free"
    allowed_tiers = ["p1", "p2"]
  }

  expect_failures = [output.tier]

  assert {
    condition     = length(data.msgraph_resource.subscribed_skus) == 0
    error_message = "The free tier must not read subscribedSkus even when it is rejected."
  }
}

# allowed_tiers accepts only known tiers.
run "rejects_invalid_allowed_tiers" {
  command = plan

  variables {
    tier          = "p1"
    allowed_tiers = ["p1", "gold"]
  }

  expect_failures = [var.allowed_tiers]
}
