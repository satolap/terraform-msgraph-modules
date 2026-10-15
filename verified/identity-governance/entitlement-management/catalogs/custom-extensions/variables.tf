variable "catalog_id" {
  description = "ID of the entitlement management catalog that holds the extension. A policy can use only the extensions of its own catalog. Changing it replaces the extension, because an update cannot move it to another catalog. The module uses it in lower case, so a change of case alone replaces nothing."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.catalog_id))
    error_message = "catalog_id must be the ID of an entitlement management catalog, a GUID."
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
  description = "The existing Azure Logic App (Consumption) that the extension calls: its subscription_id, resource_group_name and workflow_name. The Logic App needs its HTTP trigger and a Microsoft Entra authorization policy for the proof-of-possession token, both created outside this module. trigger_url is the HTTP trigger URL without a shared access signature; Microsoft Learn requires it when an application, not a signed-in user, creates the extension."
  type = object({
    subscription_id     = string
    resource_group_name = string
    workflow_name       = string
    trigger_url         = optional(string)
  })
  nullable = false

  validation {
    condition     = can(regex("^[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$", var.logic_app.subscription_id))
    error_message = "logic_app.subscription_id must be a GUID."
  }

  validation {
    condition     = try(can(regex("^[^/]+$", var.logic_app.resource_group_name)) && length(trimspace(var.logic_app.resource_group_name)) > 0, false)
    error_message = "logic_app.resource_group_name must not be empty or contain a slash."
  }

  validation {
    condition     = try(can(regex("^[^/]+$", var.logic_app.workflow_name)) && length(trimspace(var.logic_app.workflow_name)) > 0, false)
    error_message = "logic_app.workflow_name must not be empty or contain a slash."
  }

  validation {
    condition     = var.logic_app.trigger_url == null || can(regex("^https://", var.logic_app.trigger_url))
    error_message = "logic_app.trigger_url must be an https URL."
  }

  validation {
    condition     = var.logic_app.trigger_url == null || try(strcontains(var.logic_app.trigger_url, "/triggers/"), false)
    error_message = "logic_app.trigger_url must be the HTTP trigger URL of the Logic App, which contains \"/triggers/\"."
  }

  validation {
    condition     = var.logic_app.trigger_url == null || !can(regex("(?i)[?&](sig|sp|sv)(=|&|$)", var.logic_app.trigger_url))
    error_message = "logic_app.trigger_url must not carry a shared access signature (the sig, sp and sv query parameters), because the signature would be stored in the Terraform state. Microsoft Entra calls the trigger with a proof-of-possession token, so it does not need one."
  }
}

variable "display_name" {
  description = "Display name of the extension, shown in the admin center and when a policy stage is configured. Null uses logic_app.workflow_name."
  type        = string
  default     = null

  validation {
    condition     = var.display_name == null || try(length(trimspace(var.display_name)) > 0, false)
    error_message = "display_name must not be empty when set; leave it null to use the Logic App workflow name."
  }
}

variable "description" {
  description = "Description of the extension. It is always sent, as null when unset, because an update keeps the properties that its body omits; whether Microsoft Graph accepts a null description is not verified."
  type        = string
  default     = null
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
