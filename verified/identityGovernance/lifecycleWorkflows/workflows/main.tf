locals {
  # The built-in task definitions that Microsoft Learn lists, by key: ID, display name, the
  # categories a task may be used in, its parameters, and whether the task disables or deletes a
  # user or removes access. Tests bind this file to the pinned Learn pages. The IDs are
  # Microsoft-published constants, not tenant values.
  catalogue = jsondecode(file("${path.module}/task-definitions.json"))

  odata = {
    on_demand         = "#microsoft.graph.identityGovernance.onDemandExecutionOnly"
    trigger_and_scope = "#microsoft.graph.identityGovernance.triggerAndScopeBasedConditions"
    scope             = "#microsoft.graph.identityGovernance.ruleBasedSubjectSet"
    trigger           = "#microsoft.graph.identityGovernance.timeBasedAttributeTrigger"
  }

  is_trigger_and_scope = var.execution_conditions.type == "trigger_and_scope"

  # The for expression yields an object, so the two shapes need not unify as a conditional would.
  execution_conditions_body = merge(
    { "@odata.type" = local.odata[var.execution_conditions.type] },
    {
      for key, value in {
        scope = {
          "@odata.type" = local.odata.scope
          rule          = var.execution_conditions.scope_rule
        }
        trigger = {
          "@odata.type"      = local.odata.trigger
          timeBasedAttribute = try(var.execution_conditions.trigger.timeBasedAttribute, null)
          offsetInDays       = try(var.execution_conditions.trigger.offsetInDays, null)
        }
      } : key => value if local.is_trigger_and_scope
    },
  )

  # Every task in list order. executionSequence is not sent: the create page's property table and
  # examples omit it, and the pages do not say who assigns it.
  tasks_body = [
    for t in var.tasks : {
      taskDefinitionId = try(local.catalogue[t.task].id, null)
      displayName      = t.displayName
      description      = t.description
      continueOnError  = t.continueOnError
      isEnabled        = t.isEnabled
      arguments        = [for name in sort(keys(t.arguments)) : { name = name, value = t.arguments[name] }]
    }
  ]

  # Every property that Microsoft Learn documents for creating a workflow. The provider sends an
  # update as a PATCH of the changed top-level keys only, and Learn documents only description,
  # displayName, isEnabled and isSchedulingEnabled for that PATCH: a change of any other key
  # replaces the workflow through terraform_data.immutable instead of reaching a PATCH.
  # administrationScopeTargets is not sent: Learn shows it only in createNewVersion examples.
  body = {
    category            = var.category
    displayName         = var.displayName
    description         = var.description
    isEnabled           = var.isEnabled
    isSchedulingEnabled = var.isSchedulingEnabled
    executionConditions = local.execution_conditions_body
    tasks               = local.tasks_body
  }

  dangerous_task_keys = sort(distinct([for t in var.tasks : t.task if try(local.catalogue[t.task].dangerous, false)]))
  # The tasks whose catalogue entry is not selectable by default: the custom task extension task.
  # Their definition cannot be classified as dangerous or not (GB-lifecycle-workflows-506), so
  # they need an acknowledgement of their own instead of acknowledge_dangerous_tasks.
  custom_task_keys = sort(distinct([for t in var.tasks : t.task if !try(local.catalogue[t.task].selectable, true)]))
  custom_task_extension_ids = sort(distinct([
    for t in var.tasks : lower(try(t.arguments["customTaskExtensionID"], "")) if !try(local.catalogue[t.task].selectable, true)
  ]))
  acknowledged_custom_task_extension_ids = sort(distinct([for id in var.acknowledged_custom_task_extension_ids : lower(id)]))
  is_activating                          = var.isEnabled || var.isSchedulingEnabled
}

# The properties that a PATCH cannot change. Learn documents that changing them needs the
# createNewVersion action, and changing a task's definition, arguments, order, isEnabled or
# continueOnError needs it as well; only a task's displayName and description have a PATCH of
# their own. This module sends no action, so a change of any of these replaces the workflow:
# the old one is deleted first (Learn calls the display name unique, so a second workflow with
# the same name may be refused), and the new one has a new ID and starts at its first version.
# Learn's Delete workflow documents that the delete also removes the workflow's tasks, task
# processing results and versions, and that the workflow goes to the deleted workflows container,
# from which it can be restored within 30 days. The module relies on no restore. Enabled and scheduled workflows are replaced with their configured
# flags, so review the plan before applying a change to a live workflow.
resource "terraform_data" "immutable" {
  input = {
    category            = var.category
    executionConditions = local.execution_conditions_body
    tasks               = local.tasks_body
  }
}

resource "msgraph_resource" "workflow" {
  url         = "identityGovernance/lifecycleWorkflows/workflows"
  api_version = "v1.0"
  body        = local.body

  update_method = "PATCH"

  # Learn documents that a read returns the tasks (expanded by default) and the execution
  # conditions, in Graph's own shape and with server-added properties such as each task's id,
  # category and executionSequence. A key that the read does not return keeps its configured
  # value; one that it returns with another value still shows as a change.
  ignore_missing_property = true

  response_export_values = {
    version               = "version"
    is_enabled            = "isEnabled"
    is_scheduling_enabled = "isSchedulingEnabled"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]

    # The read returns the tasks and the execution conditions, so a change made outside
    # Terraform (in the portal, for example) would make the provider plan a PATCH that carries
    # them, which the update does not accept (see GB-lifecycle-workflows-001). A configured
    # change of these keys is handled by terraform_data.immutable, which replaces the workflow
    # from the configuration alone. So they are ignored here: an out-of-band edit of the tasks
    # or the execution conditions is not detected and not reconciled, and the module neither
    # restores nor versions the workflow to undo it.
    ignore_changes = [body.tasks, body.executionConditions]

    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.displayName))
      error_message = "displayName \"${var.displayName}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set displayName to a value that matches, or change name_pattern."
    }

    precondition {
      condition     = !local.is_activating || var.activation_opt_in
      error_message = "Enabling isEnabled or isSchedulingEnabled needs activation_opt_in = true. Both default to false so that a workflow is created without running."
    }

    # The acknowledgement names the extensions, so a new or changed extension ID needs a fresh
    # acknowledgement. Both sides are sorted, distinct, lower-cased lists; the sets must be equal, so an
    # acknowledgement that is no longer used also fails and does not linger.
    precondition {
      condition     = jsonencode(local.acknowledged_custom_task_extension_ids) == jsonencode(local.custom_task_extension_ids)
      error_message = "The tasks ${join(", ", local.custom_task_keys)} run the custom task extensions [${join(", ", local.custom_task_extension_ids)}], which call external Azure Logic Apps that this module cannot classify. Set acknowledged_custom_task_extension_ids to exactly those IDs (currently [${join(", ", local.acknowledged_custom_task_extension_ids)}]) to proceed."
    }

    precondition {
      condition     = length(local.dangerous_task_keys) == 0 || var.acknowledge_dangerous_tasks
      error_message = "The tasks ${join(", ", local.dangerous_task_keys)} disable or delete a user, or remove access. Set acknowledge_dangerous_tasks = true to proceed."
    }
  }
}
