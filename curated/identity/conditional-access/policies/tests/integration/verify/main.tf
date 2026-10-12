# Integration-test helper: waits, then reads the policy back with a fresh GET
# and returns the managed keys in a normalised form: GUIDs lower-cased, lists
# sorted, absent parts null, the authentication strength reduced to its id. A
# new run_label replaces the wait, so every verify run reads after its own delay.
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0"
    }
  }
}

variable "policy_id" {
  type = string
}

variable "run_label" {
  type = string
}

variable "delay_seconds" {
  type    = number
  default = 30
}

resource "time_sleep" "settle" {
  create_duration = "${var.delay_seconds}s"

  triggers = {
    policy_id = var.policy_id
    run_label = var.run_label
  }
}

data "msgraph_resource" "policy" {
  url         = "identity/conditionalAccess/policies/${var.policy_id}"
  api_version = "v1.0"

  response_export_values = {
    all = "@"
  }

  depends_on = [time_sleep.settle]
}

locals {
  guid = "^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$"
  got  = data.msgraph_resource.policy.output.all
  c    = try(local.got.conditions, null)
  g    = try(local.got.grantControls, null)
  s    = try(local.got.sessionControls, null)

  user_keys = ["includeUsers", "excludeUsers", "includeGroups", "excludeGroups", "includeRoles", "excludeRoles"]
  app_keys  = ["includeApplications", "excludeApplications", "includeUserActions", "includeAuthenticationContextClassReferences"]
}

output "configuration" {
  value = {
    display_name        = try(local.got.displayName, null)
    state               = try(local.got.state, null)
    users               = { for k in local.user_keys : k => try(sort([for v in local.c.users[k] : can(regex(local.guid, v)) ? lower(v) : v]), []) }
    applications        = { for k in local.app_keys : k => try(sort([for v in local.c.applications[k] : can(regex(local.guid, v)) ? lower(v) : v]), []) }
    client_app_types    = try(sort(local.c.clientAppTypes), [])
    sign_in_risk_levels = try(sort(local.c.signInRiskLevels), [])
    user_risk_levels    = try(sort(local.c.userRiskLevels), [])
    locations = try(local.c.locations, null) == null ? null : {
      include = try(sort([for v in local.c.locations.includeLocations : can(regex(local.guid, v)) ? lower(v) : v]), [])
      exclude = try(sort([for v in local.c.locations.excludeLocations : can(regex(local.guid, v)) ? lower(v) : v]), [])
    }
    platforms = try(local.c.platforms, null) == null ? null : {
      include = try(sort(local.c.platforms.includePlatforms), [])
      exclude = try(sort(local.c.platforms.excludePlatforms), [])
    }
    device_filter = try(local.c.devices.deviceFilter, null) == null ? null : {
      mode = try(local.c.devices.deviceFilter.mode, null)
      rule = try(local.c.devices.deviceFilter.rule, null)
    }
    grant_controls = local.g == null ? null : {
      operator                   = try(local.g.operator, null)
      built_in_controls          = try(sort(local.g.builtInControls), [])
      terms_of_use               = try(sort([for v in local.g.termsOfUse : lower(v)]), [])
      authentication_strength_id = try(lower(local.g.authenticationStrength.id), null)
    }
    session_controls = local.s == null ? null : {
      sign_in_frequency = try(local.s.signInFrequency, null) == null ? null : {
        is_enabled          = try(local.s.signInFrequency.isEnabled, null)
        frequency_interval  = try(local.s.signInFrequency.frequencyInterval, null)
        authentication_type = try(local.s.signInFrequency.authenticationType, null)
        type                = try(local.s.signInFrequency.type, null)
        value               = try(local.s.signInFrequency.value, null)
      }
      persistent_browser_mode           = try(local.s.persistentBrowser.mode, null)
      application_enforced_restrictions = try(local.s.applicationEnforcedRestrictions.isEnabled, null)
      cloud_app_security_type           = try(local.s.cloudAppSecurity.cloudAppSecurityType, null)
    }
  }
}
