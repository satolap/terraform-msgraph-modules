output "id" {
  description = "The ID of the workflow. A change of a property that only a new version can carry replaces the workflow and gives it a new ID."
  value       = msgraph_resource.workflow.id
}

output "version" {
  description = "The version number that the workflow read returned after the last refresh."
  value       = msgraph_resource.workflow.output.version
}

output "display_name" {
  description = "The display name of the workflow, as configured."
  value       = var.displayName
}

output "category" {
  description = "The category of the workflow, as configured."
  value       = var.category
}

output "is_enabled" {
  description = "Whether the workflow is enabled, as configured."
  value       = var.isEnabled
}

output "is_scheduling_enabled" {
  description = "Whether scheduling is enabled, as configured."
  value       = var.isSchedulingEnabled
}

output "request_body" {
  description = "The request body that the module sends to create the workflow, in Microsoft Graph's shape, with the tasks in list order. It carries no executionSequence and no administrationScopeTargets."
  value       = local.body
}

output "dangerous_task_keys" {
  description = "The keys of the selected tasks that disable or delete a user, or remove access, sorted. When it is not empty, acknowledge_dangerous_tasks must be true."
  value       = local.dangerous_task_keys
}

output "custom_task_extension_ids" {
  description = "The IDs (lower case, sorted, distinct) of the custom task extensions that the tasks run. When it is not empty, acknowledged_custom_task_extension_ids must equal this set. The module does not read the extensions."
  value       = local.custom_task_extension_ids
}
