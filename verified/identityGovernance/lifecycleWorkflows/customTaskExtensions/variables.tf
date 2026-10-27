variable "display_name" {
  description = "Display name of the custom task extension. Microsoft Learn documents it as a unique string that identifies the extension; it can be updated in place."
  type        = string
  nullable    = false

  validation {
    condition     = try(length(trimspace(var.display_name)) > 0, false)
    error_message = "display_name must not be empty."
  }
}

variable "description" {
  description = "Description of the extension, for administrative use. It is always sent, as an empty string when unset, and can be updated in place."
  type        = string
  default     = ""
  nullable    = false
}

variable "logic_app" {
  description = <<-EOT
    The existing Azure Logic App (consumption-based) that the extension calls, sent as a
    logicAppTriggerEndpointConfiguration. The module creates no Azure resource and reads none: the
    three values are inputs. Changing them updates the extension in place.

    - subscription_id: the ID (GUID) of the Azure subscription that holds the Logic App.
    - resource_group_name: the resource group of the Logic App.
    - logic_app_workflow_name: the name of the Logic App.

    The identity that applies this module also needs one of the Azure roles Logic App Contributor,
    Contributor or Owner on the Logic App (Learn names this for create and update). The module
    checks only the shape of the values, not that the Logic App exists or is configured for
    Lifecycle Workflows.
  EOT
  type = object({
    subscription_id         = string
    resource_group_name     = string
    logic_app_workflow_name = string
  })
  nullable = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", try(var.logic_app.subscription_id, "")))
    error_message = "logic_app.subscription_id must be a subscription ID (a GUID)."
  }

  validation {
    condition = alltrue([
      for name in [try(var.logic_app.resource_group_name, ""), try(var.logic_app.logic_app_workflow_name, "")] :
      trimspace(name) != "" && trimspace(name) == name && length(name) <= 90 && !can(regex("[/\\\\?#%]", name))
    ])
    error_message = "logic_app.resource_group_name and logic_app.logic_app_workflow_name must not be empty, must not start or end with a space, must be at most 90 characters and must not contain / \\ ? # or %."
  }
}

variable "authentication_resource_id" {
  description = "The appId (GUID) of the Microsoft Entra application that authenticates the call to the Logic App, sent as azureAdTokenAuthentication.resourceId. Learn describes it as the appID of the application to use to authenticate an app with a custom extension. The module does not create or read the application. Changing it updates the extension in place."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", try(var.authentication_resource_id, "")))
    error_message = "authentication_resource_id must be an application (client) ID (a GUID)."
  }
}

variable "timeout_in_milliseconds" {
  description = "How long, in milliseconds, Microsoft Entra ID waits for the Logic App to accept the call before it shuts down the connection (clientConfiguration.timeoutInMilliseconds). Learn gives the valid range as 200 to 2000 and the default as 1000. This is the connection time, not the callback wait (see callback_timeout_duration)."
  type        = number
  default     = 1000
  nullable    = false

  validation {
    condition     = try(var.timeout_in_milliseconds == floor(var.timeout_in_milliseconds) ? (var.timeout_in_milliseconds >= 200 ? var.timeout_in_milliseconds <= 2000 : false) : false, false)
    error_message = "timeout_in_milliseconds must be a whole number from 200 to 2000."
  }
}

variable "maximum_retries" {
  description = "How many times Microsoft Entra ID retries a timed-out call (clientConfiguration.maximumRetries): 0 or 1. Null, the default, does not send the property, so the service default applies."
  type        = number
  default     = null

  validation {
    condition     = try(var.maximum_retries == null ? true : contains([0, 1], var.maximum_retries), false)
    error_message = "maximum_retries must be null, 0 or 1."
  }
}

variable "callback_timeout_duration" {
  description = <<-EOT
    How long the workflow task waits for the Logic App (or another party) to answer, as an ISO 8601
    duration of whole hours and minutes in normalised form, such as "PT30M", "PT1H30M" or "PT3H"
    (callbackConfiguration.timeoutDuration). Learn accepts 30 minutes to 3 hours. Forms such as
    "PT90M", "PT0H30M" or "PT01H" are rejected: Graph probably stores the normalised form, and a
    different string would show as a diff on every plan (not verified). When no answer arrives in
    time the task fails.

    Null, the default, sends no callbackConfiguration: the extension is then the "launch and
    continue" kind, whose task succeeds as soon as the Logic App is started. That mapping follows
    Learn's description of the two deployment scenarios; the pinned API pages do not state it.
    Setting it makes the extension "launch and wait". Changing it updates the extension in place.
    authorizedApps (which applications may answer) is not supported: the module does not send it.
  EOT
  type        = string
  default     = null

  validation {
    # Only the normalised form is accepted: no leading zeros, no 0H or 0M, minutes below 60 (so
    # PT1H30M, never PT90M or PT0H30M), because Graph probably returns a duration in that form and a
    # stored value that differs from the configured string would show as a permanent diff (not
    # verified; GB-lifecycle-workflows-014). The minutes are computed inline: a local would form a cycle with this validation. The
    # for expression binds the captured hours and minutes once; an absent group is null or an empty string, which coalesce turns into "0".
    condition = try(var.callback_timeout_duration == null ? true : alltrue([
      for m in [regex("^PT(?:([1-9][0-9]?)H)?(?:([1-9][0-9]?)M)?$", var.callback_timeout_duration)] :
      try(tonumber(coalesce(m[0], "0")), 0) * 60 + try(tonumber(coalesce(m[1], "0")), 0) >= 30 && try(tonumber(coalesce(m[0], "0")), 0) * 60 + try(tonumber(coalesce(m[1], "0")), 0) <= 180 && try(tonumber(coalesce(m[1], "0")), 0) < 60
    ]), false)
    error_message = "callback_timeout_duration must be null or an ISO 8601 duration of whole hours and minutes in normalised form (for example PT30M, PT1H30M or PT3H: hours without a leading zero, minutes below 60) between 30 minutes and 3 hours."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that display_name must match, such as the pattern of a naming convention. When it is set and display_name does not match, the plan fails. Null, the default, accepts any display_name."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}
