variable "displayName" {
  description = "Display name of the workflow. Microsoft Learn documents it as a unique string that identifies the workflow, and it can be updated in place."
  type        = string
  nullable    = false

  validation {
    condition     = try(length(trimspace(var.displayName)) > 0, false)
    error_message = "displayName must not be empty."
  }
}

variable "description" {
  description = "Description of the workflow, for administrative use. It is always sent, as an empty string when unset, and can be updated in place."
  type        = string
  default     = ""
  nullable    = false
}

variable "category" {
  description = "Workflow category: \"joiner\", \"leaver\" or \"mover\". Changing it needs a new workflow version, so it replaces the workflow (see the README). The create page's property table lists only joiner and leaver, but its own examples and those of createNewVersion use mover, so the module accepts the three observed values and rejects unknownFutureValue."
  type        = string
  nullable    = false

  validation {
    condition     = contains(["joiner", "leaver", "mover"], var.category)
    error_message = "category must be \"joiner\", \"leaver\" or \"mover\"."
  }
}

variable "execution_conditions" {
  description = <<-EOT
    Who the workflow runs for and when. Required. Changing it replaces the workflow.

    - type "trigger_and_scope": the workflow runs on a schedule for the users that a rule selects.
      Set scope_rule (a rule over user properties, such as "(department eq 'Marketing')", sent as a
      ruleBasedSubjectSet) and trigger. The trigger is a timeBasedAttributeTrigger:
      timeBasedAttribute is "employeeHireDate", "employeeLeaveDateTime" or "createdDateTime", and
      offsetInDays is between -180 and 180 days before or after it. The module checks that the rule
      is not empty; it does not parse the rule, so it cannot tell how many users the rule selects.
    - type "on_demand": the workflow runs only when someone starts it. Set neither scope_rule nor trigger.
  EOT
  type = object({
    type       = string
    scope_rule = optional(string)
    trigger = optional(object({
      timeBasedAttribute = string
      offsetInDays       = optional(number, 0)
      offset_in_days     = optional(any)
    }))
  })
  nullable = false

  validation {
    condition     = contains(["trigger_and_scope", "on_demand"], try(var.execution_conditions.type, ""))
    error_message = "execution_conditions.type must be \"trigger_and_scope\" or \"on_demand\"."
  }

  validation {
    condition = try(var.execution_conditions.type == "trigger_and_scope" ? (
      var.execution_conditions.trigger != null && trimspace(coalesce(var.execution_conditions.scope_rule, "")) != ""
      ) : (
      var.execution_conditions.trigger == null && var.execution_conditions.scope_rule == null
    ), false)
    error_message = "execution_conditions of type \"trigger_and_scope\" need a non-empty scope_rule and a trigger; type \"on_demand\" takes neither."
  }

  validation {
    # Terraform before 1.12 evaluates both operands of || and &&, so a conditional guards the
    # trigger attributes instead.
    condition = try(var.execution_conditions.trigger == null ? true : (
      contains(["employeeHireDate", "employeeLeaveDateTime", "createdDateTime"], var.execution_conditions.trigger.timeBasedAttribute) &&
      var.execution_conditions.trigger.offsetInDays == floor(var.execution_conditions.trigger.offsetInDays) &&
      var.execution_conditions.trigger.offsetInDays >= -180 &&
      var.execution_conditions.trigger.offsetInDays <= 180
    ), false)
    error_message = "execution_conditions.trigger.timeBasedAttribute must be \"employeeHireDate\", \"employeeLeaveDateTime\" or \"createdDateTime\", and offsetInDays a whole number from -180 to 180."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(offset_in_days)\":[^n]", jsonencode(var.execution_conditions)))
    error_message = "execution_conditions no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (offset_in_days -> offsetInDays). An old name that is silently dropped would fall back to its default."
  }
}

variable "tasks" {
  description = <<-EOT
    The tasks of the workflow, in the order they run, at least one. Changing any of them, in any
    property, replaces the workflow. Each entry has:

    - task: the key of a built-in task definition in task-definitions.json, such as
      "enable_user_account" or "send_welcome_email". Only the 25 built-in definitions that Microsoft
      Learn lists are known; the module resolves the key to the definition ID. The custom task
      extension task ("run_a_custom_task_extension") needs its ID in acknowledged_custom_task_extension_ids
      and an arguments entry customTaskExtensionID that is the ID of a custom task extension (a GUID,
      for example the id output of the customTaskExtensions module).
    - displayName, and optionally description, continueOnError (default false) and isEnabled (default true).
    - arguments: a map of argument name to value. A name must be a parameter of the task definition,
      and a value for a parameter with a fixed set of values must be one of them.

    The task definition's category list must include the workflow category. A task that disables or
    deletes a user, or removes access, needs acknowledge_dangerous_tasks. executionSequence is not an
    input: Microsoft Learn does not say who assigns it, and its responses show 1..N in list order.
  EOT
  type = list(object({
    task              = string
    displayName       = string
    description       = optional(string, "")
    continueOnError   = optional(bool, false)
    continue_on_error = optional(any)
    isEnabled         = optional(bool, true)
    is_enabled        = optional(any)
    arguments         = optional(map(string), {})
  }))
  nullable = false

  validation {
    condition     = length(var.tasks) > 0
    error_message = "tasks must contain at least one task."
  }

  validation {
    condition     = alltrue([for t in var.tasks : contains(keys(local.catalogue), t.task)])
    error_message = "Every tasks[*].task must be the key of a built-in task definition in task-definitions.json: ${join(", ", sort(keys(local.catalogue)))}."
  }

  # A task that is not selectable by default (the custom task extension task) needs its own
  # argument: the ID of the extension, as a GUID. The module cannot read the extension, so it
  # cannot check that it exists, that it is in the same tenant or that it is usable.
  validation {
    condition = alltrue([
      for t in var.tasks : try(local.catalogue[t.task].selectable, true) ? true : try(
        can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", t.arguments["customTaskExtensionID"])),
        false
      )
    ])
    error_message = "A custom task extension task needs an arguments entry customTaskExtensionID that is the ID (a GUID) of a custom task extension."
  }

  validation {
    condition     = alltrue([for t in var.tasks : try(length(trimspace(t.displayName)) > 0, false)])
    error_message = "Every tasks[*].displayName must not be empty."
  }

  validation {
    condition = alltrue([
      for t in var.tasks : alltrue([
        for name in keys(t.arguments) : contains([for p in try(local.catalogue[t.task].parameters, []) : p.name], name)
      ])
    ])
    error_message = "Every tasks[*].arguments name must be a documented parameter of its task definition."
  }

  validation {
    condition = alltrue(flatten([
      for t in var.tasks : [
        for p in try(local.catalogue[t.task].parameters, []) :
        p.type != "enum" ? true : (contains(keys(t.arguments), p.name) ? contains(p.values, t.arguments[p.name]) : true)
      ]
    ]))
    error_message = "An argument for a task parameter with a fixed set of values must be one of those values."
  }

  validation {
    condition     = alltrue([for t in var.tasks : contains(try(local.catalogue[t.task].categories, []), var.category)])
    error_message = "Every task's documented category list must include the workflow category."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = alltrue([for t in var.tasks : try(t.continue_on_error == null && t.is_enabled == null, false)])
    error_message = "tasks no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (continue_on_error -> continueOnError, is_enabled -> isEnabled). An old name that is silently dropped would fall back to its default."
  }
}

variable "isEnabled" {
  description = "Whether the workflow is enabled (isEnabled). Defaults to false. Enabling it needs activation_opt_in. Updated in place."
  type        = bool
  default     = false
  nullable    = false
}

variable "isSchedulingEnabled" {
  description = "Whether scheduling is enabled (isSchedulingEnabled). Defaults to false, independently of isEnabled. Enabling it needs activation_opt_in. Updated in place."
  type        = bool
  default     = false
  nullable    = false
}

variable "activation_opt_in" {
  description = "Explicit opt-in that must be true before isEnabled or isSchedulingEnabled may be true. It is not a Microsoft Graph property."
  type        = bool
  default     = false
  nullable    = false
}

variable "acknowledge_dangerous_tasks" {
  description = "Explicit acknowledgement that must be true when any task disables or deletes a user, or removes group, Teams, licence, access package or refresh token access (see the dangerous_task_keys output). It is not a Microsoft Graph property."
  type        = bool
  default     = false
  nullable    = false
}

variable "acknowledged_custom_task_extension_ids" {
  description = "The IDs (GUIDs) of the custom task extensions that the reviewer has accepted, for every task that runs one (see the custom_task_extension_ids output). The set must equal the set of customTaskExtensionID values of the tasks, compared in lower case: a new, changed or removed extension ID fails the plan until this set is updated. The task calls an external Azure Logic App whose effect Microsoft Graph does not describe, so the module cannot classify it as safe or dangerous; whoever sets this accepts what each extension does for every user the workflow runs for. The acknowledgement covers the extension ID only: the module cannot see, and the acknowledgement does not cover, a later change of the Logic App that the extension points to. Because an extension ID exists only after the extension is created, the first apply of a new extension needs the ID acknowledged in a second step (see the README). It is not a Microsoft Graph property."
  type        = set(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for id in var.acknowledged_custom_task_extension_ids : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", id))])
    error_message = "Every acknowledged_custom_task_extension_ids entry must be the ID (a GUID) of a custom task extension."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}
