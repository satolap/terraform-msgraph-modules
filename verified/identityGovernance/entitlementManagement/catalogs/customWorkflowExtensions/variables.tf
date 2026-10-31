variable "accessPackageCatalog-id" {
  description = "ID of the entitlement management catalog that holds the extension. A policy can use only the extensions of its own catalog. Changing it replaces the extension, because an update cannot move it to another catalog. The module uses it in lower case, so a change of case alone replaces nothing."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.accessPackageCatalog-id))
    error_message = "accessPackageCatalog-id must be the ID of an entitlement management catalog, a GUID."
  }
}

variable "extension_type" {
  description = "Which workflow stages the extension serves. \"request_workflow\" serves the access package request stages (created, approved, granted, removed) and maps to accessPackageAssignmentRequestWorkflowExtension. \"assignment_workflow\" serves the stages before an assignment expires (fourteen days and one day before) and maps to accessPackageAssignmentWorkflowExtension. Changing it replaces the extension, because the type cannot be updated."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["request_workflow", "assignment_workflow"], var.extension_type)
    error_message = "extension_type must be one of \"request_workflow\" or \"assignment_workflow\"."
  }
}

variable "logic_app" {
  description = "The existing Azure Logic App (Consumption) that the extension calls: its subscriptionId, resourceGroupName and logicAppWorkflowName. The Logic App needs its HTTP trigger and a Microsoft Entra authorization policy for the proof-of-possession token, both created outside this module. url is the HTTP trigger URL without a shared access signature; Microsoft Learn requires it when an application, not a signed-in user, creates the extension."
  type = object({
    subscriptionId       = string
    resourceGroupName    = string
    logicAppWorkflowName = string
    url                  = optional(string)
    trigger_url          = optional(any)
  })
  nullable = false

  validation {
    condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.logic_app.subscriptionId))
    error_message = "logic_app.subscriptionId must be a GUID."
  }

  validation {
    condition     = try(can(regex("^[^/]+$", var.logic_app.resourceGroupName)) && length(trimspace(var.logic_app.resourceGroupName)) > 0, false)
    error_message = "logic_app.resourceGroupName must not be empty or contain a slash."
  }

  validation {
    condition     = try(can(regex("^[^/]+$", var.logic_app.logicAppWorkflowName)) && length(trimspace(var.logic_app.logicAppWorkflowName)) > 0, false)
    error_message = "logic_app.logicAppWorkflowName must not be empty or contain a slash."
  }

  validation {
    condition     = var.logic_app.url == null || can(regex("^https://", var.logic_app.url))
    error_message = "logic_app.url must be an https URL."
  }

  validation {
    condition     = var.logic_app.url == null || try(strcontains(var.logic_app.url, "/triggers/"), false)
    error_message = "logic_app.url must be the HTTP trigger URL of the Logic App, which contains \"/triggers/\"."
  }

  validation {
    condition     = var.logic_app.url == null || !can(regex("(?i)[?&](sig|sp|sv)(=|&|$)", var.logic_app.url))
    error_message = "logic_app.url must not carry a shared access signature (the sig, sp and sv query parameters), because the signature would be stored in the Terraform state. Microsoft Entra calls the trigger with a proof-of-possession token, so it does not need one."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(trigger_url)\":[^n]", jsonencode(var.logic_app)))
    error_message = "logic_app no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (trigger_url -> url). An old name that is silently dropped would fall back to its default."
  }
}

variable "displayName" {
  description = "Display name of the extension, shown in the admin center and when a policy stage is configured. Null uses logic_app.logicAppWorkflowName."
  type        = string
  default     = null

  validation {
    condition     = var.displayName == null || try(length(trimspace(var.displayName)) > 0, false)
    error_message = "displayName must not be empty when set; leave it null to use the Logic App workflow name."
  }
}

variable "description" {
  description = "Description of the extension. It is always sent, as null when unset, because an update keeps the properties that its body omits; whether Microsoft Graph accepts a null description is not verified."
  type        = string
  default     = null
}

variable "callback" {
  description = "Launch and wait. Sends callbackConfiguration with only timeoutDuration, without a callback @odata.type. Null, the default, leaves the callback out of the request body, so a new extension is launch and continue: entitlement management calls the Logic App and goes on. { timeoutDuration = \"PT1H\" } makes the extension launch and wait: entitlement management pauses the request at each stage that the extension is bound to until the resume action is called on the request, and treats the stage as failed when no resume arrives within timeoutDuration. timeoutDuration is an ISO 8601 duration in whole days, hours and minutes, in normal form (no part zero or with a leading zero, at most 23 hours and 59 minutes), from \"PT5M\" to \"P14D\", such as \"PT1H\", \"P1DT12H\" or \"P14D\". Only extension_type \"request_workflow\" supports it. Setting callback back to null does not end launch and wait, because an update keeps the callback that its body omits; replace the extension to remove it."
  type = object({
    timeoutDuration = string
  })
  default = null

  validation {
    condition     = var.callback == null || try(can(regex("^P([1-9][0-9]*D)?(T([1-9][0-9]*H)?([1-9][0-9]*M)?)?$", var.callback.timeoutDuration)) && !contains(["P", "PT"], var.callback.timeoutDuration) && !endswith(var.callback.timeoutDuration, "T"), false)
    error_message = "callback.timeoutDuration must be an ISO 8601 duration in whole days, hours and minutes, such as \"PT1H\", \"P1DT12H\" or \"P14D\": P, then the days, then T and the hours and minutes, each part a number greater than zero without a leading zero. Weeks, months, years, seconds and fractions are not accepted."
  }

  validation {
    condition     = var.callback == null || try(alltrue([for m in regexall("([0-9]+)([HM])", var.callback.timeoutDuration) : tonumber(m[0]) < lookup({ H = 24, M = 60 }, m[1])]), true)
    error_message = "callback.timeoutDuration must be in normal form, with at most 23 hours and 59 minutes, such as \"P1DT1H\" rather than \"PT25H\" and \"PT1H30M\" rather than \"PT90M\". Microsoft Graph may return a duration in normal form, and a different form would show as drift."
  }

  validation {
    condition     = var.callback == null || try(!can(regex("^P([0-9]+D)?(T([0-9]+H)?([0-9]+M)?)?$", var.callback.timeoutDuration)) || alltrue([for minutes in [sum([for m in regexall("([0-9]+)([DHM])", var.callback.timeoutDuration) : tonumber(m[0]) * lookup({ D = 1440, H = 60, M = 1 }, m[1])])] : minutes >= 5 && minutes <= 20160]), true)
    error_message = "callback.timeoutDuration must be from 5 minutes (\"PT5M\") to 14 days (\"P14D\"), the range that Microsoft Learn documents for custom extensions in entitlement management."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that the effective display name must match. When set and the name does not match, the plan fails. Null accepts any name."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "timeouts" {
  description = "Timeouts for creating, reading, updating and deleting the extension, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete default to \"10m\" and must be at least \"15s\": after each request the provider waits for three consistent reads 5 seconds apart within the same timeout. read defaults to null, which keeps the provider's default read timeout. Retries count against these timeouts."
  type = object({
    create = optional(string, "10m")
    read   = optional(string)
    update = optional(string, "10m")
    delete = optional(string, "10m")
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null || (can(regex("^([0-9]+[hms])+$", t)) && !can(regex("^(0+[hms])+$", t)))
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\": after each request the provider waits for three consistent reads 5 seconds apart within the same timeout."
  }
}
