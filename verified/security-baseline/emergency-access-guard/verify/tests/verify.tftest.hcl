# Fixtures follow the List policies response (GET /identity/conditionalAccess/policies with
# $select=id,displayName,state,conditions). The exclusions are the guard's
# conditional_access_users_exclusions output for two users and one group.
#
# The policy read waits for terraform_data.baseline_policy_ids, so it happens during apply
# whenever the policy IDs or the exclusions are new or changed, as on the baseline's first
# apply, and at plan time otherwise. The runs share one state and follow that sequence: an
# apply run records the policy IDs and exclusions, and the plan runs after it with the same
# inputs read the policies at plan time.

mock_provider "msgraph" {
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        next_link = null
        policies  = []
      }
    }
  }
}

variables {
  tier = "p1"
  exclusions = {
    excludeUsers  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
    excludeGroups = ["00000000-0000-4000-8000-000000000002"]
  }
  baseline_policy_ids = ["00000000-0000-4000-8000-000000000006", "00000000-0000-4000-8000-000000000003"]
}

# First plan: the baseline policies do not exist yet, so the read must not happen at plan time.
# The tenant holds no policies here; a plan-time read would fail the missing-policy check.
run "first_plan_defers_the_read" {
  command = plan

  assert {
    condition     = data.msgraph_resource.policies[0].url == "identity/conditionalAccess/policies" && data.msgraph_resource.policies[0].api_version == "v1.0"
    error_message = "Policies must be read from the v1.0 Conditional Access policies collection."
  }

  assert {
    condition     = data.msgraph_resource.policies[0].query_parameters == tomap({ "$select" = tolist(["id,displayName,state,conditions"]) })
    error_message = "The read must select the properties the checks evaluate."
  }
}

# Baseline scope: a report-only and an enabled baseline policy that both exclude every ID.
run "baseline_scope_passes" {
  command = apply

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              clientAppTypes = ["all"]
              applications   = { includeApplications = ["All"], excludeApplications = [], includeUserActions = [], includeAuthenticationContextClassReferences = [], applicationFilter = null }
              users = {
                includeUsers                 = []
                excludeUsers                 = ["00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000010"]
                includeGroups                = []
                excludeGroups                = ["00000000-0000-4000-8000-000000000002"]
                includeRoles                 = ["00000000-0000-4000-8000-000000000011", "00000000-0000-4000-8000-000000000005"]
                excludeRoles                 = []
                includeGuestsOrExternalUsers = null
                excludeGuestsOrExternalUsers = null
              }
              platforms = null
              locations = null
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              clientAppTypes = ["exchangeActiveSync", "other"]
              applications   = { includeApplications = ["All"], excludeApplications = [], includeUserActions = [], includeAuthenticationContextClassReferences = [], applicationFilter = null }
              users = {
                includeUsers                 = ["All"]
                excludeUsers                 = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000024"]
                includeGroups                = []
                excludeGroups                = ["00000000-0000-4000-8000-000000000002"]
                includeRoles                 = []
                excludeRoles                 = []
                includeGuestsOrExternalUsers = null
                excludeGuestsOrExternalUsers = null
              }
              platforms = null
              locations = null
            }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == true
    error_message = "Both baseline policies exclude every ID."
  }

  assert {
    condition     = output.verified_policy_ids == tolist(["00000000-0000-4000-8000-000000000003", "00000000-0000-4000-8000-000000000006"])
    error_message = "Both baseline policies must be verified, whatever their state."
  }
}

# The next runs plan with the policy IDs that baseline_scope_passes recorded, so the policies
# are read at plan time, as in every plan after the baseline's first apply.
run "missing_user_exclusion_fails" {
  command = plan

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabled"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verified]

  assert {
    condition     = local.exclusion_error == "Conditional Access policies do not exclude every emergency access account. Policy 0000...0006, state enabled: excludeUsers lacks 0000...0020."
    error_message = "The error must name the policy and the missing user."
  }

  assert {
    condition     = length(local.missing_policy_ids) == 0
    error_message = "Both policies exist."
  }
}

run "missing_group_exclusion_fails" {
  command = plan

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabled"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = [], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verified]

  assert {
    condition     = local.policy_errors == ["Policy 0000...0003, state enabled: excludeGroups lacks 0000...0002."]
    error_message = "The error must name the policy and the missing group."
  }
}

run "baseline_policy_missing_from_tenant_fails" {
  command = plan

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verified]

  assert {
    condition     = local.missing_error == "Baseline policies not found in the tenant: 0000...0003."
    error_message = "The error must name the missing policy."
  }

  assert {
    condition     = length(local.policy_errors) == 0
    error_message = "The policy that exists excludes every ID."
  }
}

# Report-only baseline policies are checked too, because one input change enforces them.
run "report_only_baseline_policy_without_exclusion_fails" {
  command = plan

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = [], includeGroups = [], excludeGroups = [], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verified]

  assert {
    condition     = local.policy_errors == ["Policy 0000...0006, state enabledForReportingButNotEnforced: excludeUsers lacks 0000...0010, 0000...0020; excludeGroups lacks 0000...0002."]
    error_message = "The error must name the report-only policy and every missing ID."
  }
}

# Adding a break-glass user: the baseline adds the exclusion in the same apply, so the tenant
# still lacks it at plan time. The changed exclusions defer the read to apply; a plan-time read
# of this tenant would fail.
run "adding_a_user_defers_the_read" {
  command = plan

  variables {
    exclusions = {
      excludeUsers  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"]
      excludeGroups = ["00000000-0000-4000-8000-000000000002"]
    }
  }

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  assert {
    condition     = terraform_data.baseline_policy_ids.input.exclude_users == tolist(["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"])
    error_message = "The read gate must hold the exclusions, so that a change to them defers the read."
  }
}

# Adding a break-glass group defers the read in the same way.
run "adding_a_group_defers_the_read" {
  command = plan

  variables {
    exclusions = {
      excludeUsers  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
      excludeGroups = ["00000000-0000-4000-8000-000000000002", "00000000-0000-4000-8000-000000000013"]
    }
  }

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }
}

# The deferred read still runs during apply. Here the baseline did not add the new user, so
# the apply fails and names it.
run "added_user_missing_after_apply_fails" {
  command = apply

  variables {
    exclusions = {
      excludeUsers  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"]
      excludeGroups = ["00000000-0000-4000-8000-000000000002"]
    }
  }

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verified]
}

# The baseline added the new user to both policies: the apply passes and records the new
# exclusions.
run "added_user_passes_after_apply" {
  command = apply

  variables {
    exclusions = {
      excludeUsers  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"]
      excludeGroups = ["00000000-0000-4000-8000-000000000002"]
    }
  }

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == true
    error_message = "Both baseline policies exclude the new user."
  }
}

# Drift: the inputs match the last apply, so the read happens at plan time, and an exclusion
# removed outside Terraform fails the plan.
run "removed_exclusion_with_unchanged_inputs_fails" {
  command = plan

  variables {
    exclusions = {
      excludeUsers  = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"]
      excludeGroups = ["00000000-0000-4000-8000-000000000002"]
    }
  }

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020", "00000000-0000-4000-8000-000000000021"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000003"
            displayName = "Security baseline - Block legacy authentication"
            state       = "enabled"
            conditions = {
              users = { includeUsers = ["All"], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verified]

  assert {
    condition     = local.policy_errors == ["Policy 0000...0003, state enabled: excludeUsers lacks 0000...0021."]
    error_message = "The error must name the policy and the removed user."
  }
}

# Tenant scope: a report-only policy outside the baseline needs no exclusion, a disabled one is
# ignored, and an enabled one with the exclusions passes.
run "tenant_scope_passes" {
  command = apply

  variables {
    scope               = "tenant"
    baseline_policy_ids = ["00000000-0000-4000-8000-000000000006"]
  }

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              clientAppTypes = ["all"]
              users = {
                includeUsers                 = []
                excludeUsers                 = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
                includeGroups                = []
                excludeGroups                = ["00000000-0000-4000-8000-000000000002"]
                includeRoles                 = ["00000000-0000-4000-8000-000000000011"]
                excludeRoles                 = []
                includeGuestsOrExternalUsers = null
                excludeGuestsOrExternalUsers = null
              }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000012"
            displayName = "Pilot - Sign-in frequency for all users"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              clientAppTypes = ["all"]
              users          = { includeUsers = ["All"], excludeUsers = [], includeGroups = [], excludeGroups = [], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000018"
            displayName = "Retired - Block unknown platforms"
            state       = "disabled"
            conditions = {
              clientAppTypes = ["all"]
              users          = { includeUsers = ["All"], excludeUsers = [], includeGroups = [], excludeGroups = [], includeRoles = [], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000008"
            displayName = "Require compliant device for Office 365"
            state       = "enabled"
            conditions = {
              clientAppTypes = ["all"]
              users = {
                includeUsers                 = ["All"]
                excludeUsers                 = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"]
                includeGroups                = []
                excludeGroups                = ["00000000-0000-4000-8000-000000000002"]
                includeRoles                 = []
                excludeRoles                 = []
                includeGuestsOrExternalUsers = null
                excludeGuestsOrExternalUsers = null
              }
            }
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == true
    error_message = "Report-only and disabled policies outside the baseline must be ignored."
  }

  assert {
    condition     = output.verified_policy_ids == tolist(["00000000-0000-4000-8000-000000000006", "00000000-0000-4000-8000-000000000008"])
    error_message = "The baseline policy and the enabled tenant policy must be verified."
  }
}

# Tenant scope: an enabled Microsoft-managed policy outside the baseline must exclude the IDs.
run "tenant_scope_enabled_policy_without_exclusion_fails" {
  command = plan

  variables {
    scope               = "tenant"
    baseline_policy_ids = ["00000000-0000-4000-8000-000000000006"]
  }

  override_data {
    target = data.msgraph_resource.policies
    values = {
      output = {
        next_link = null
        policies = [
          {
            id          = "00000000-0000-4000-8000-000000000006"
            displayName = "Security baseline - Require MFA for administrators"
            state       = "enabledForReportingButNotEnforced"
            conditions = {
              users = { includeUsers = [], excludeUsers = ["00000000-0000-4000-8000-000000000010", "00000000-0000-4000-8000-000000000020"], includeGroups = [], excludeGroups = ["00000000-0000-4000-8000-000000000002"], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
          {
            id          = "00000000-0000-4000-8000-000000000041"
            displayName = "Multifactor authentication for admins accessing Microsoft Admin Portals"
            state       = "enabled"
            conditions = {
              users = { includeUsers = [], excludeUsers = [], includeGroups = [], excludeGroups = [], includeRoles = ["00000000-0000-4000-8000-000000000011"], excludeRoles = [], includeGuestsOrExternalUsers = null, excludeGuestsOrExternalUsers = null }
            }
          },
        ]
      }
    }
  }

  expect_failures = [terraform_data.verified]

  assert {
    condition     = local.policy_errors == ["Policy 0000...0041, state enabled, outside the baseline: excludeUsers lacks 0000...0010, 0000...0020; excludeGroups lacks 0000...0002."]
    error_message = "The error must name the tenant policy and every missing ID."
  }
}

run "free_with_policy_ids_fails" {
  command = plan

  variables {
    tier = "free"
  }

  expect_failures = [terraform_data.verified]

  assert {
    condition     = local.tier_error == "Tier free runs no Conditional Access checks, because security defaults stay on and Conditional Access needs Microsoft Entra ID P1, but baseline_policy_ids lists 0000...0003, 0000...0006. Remove them, or use p1 or p2."
    error_message = "The error must name the policy IDs."
  }

  assert {
    condition     = length(local.missing_policy_ids) == 0 && length(data.msgraph_resource.policies) == 0
    error_message = "The free tier reads no policies, so only the tier check fails."
  }
}

# free keeps security defaults on: no policy is read and nothing is verified.
run "free_without_policies_reads_nothing" {
  command = plan

  variables {
    tier                = "free"
    baseline_policy_ids = []
  }

  assert {
    condition     = length(data.msgraph_resource.policies) == 0
    error_message = "The free tier must not read Conditional Access policies."
  }

  assert {
    condition     = output.verified == false && length(output.verified_policy_ids) == 0
    error_message = "The free tier verifies no policy."
  }
}

run "rejects_exclusions_without_users" {
  command = plan

  variables {
    exclusions = {
      excludeUsers  = []
      excludeGroups = ["00000000-0000-4000-8000-000000000002"]
    }
  }

  expect_failures = [var.exclusions]
}

run "rejects_unknown_scope" {
  command = plan

  variables {
    scope = "all"
  }

  expect_failures = [var.scope]
}
