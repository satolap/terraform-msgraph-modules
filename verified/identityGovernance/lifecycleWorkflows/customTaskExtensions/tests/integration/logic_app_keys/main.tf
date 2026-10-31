# Integration-test helper: turns the logic_app of the lifecycle extension fixture secret
# (TF_VAR_lifecycle_extension_fixture, LIFECYCLE_EXTENSION_FIXTURE) into the module's logic_app
# object. The secret keeps the keys it always had (subscription_id, resource_group_name,
# logic_app_workflow_name), so nobody has to rewrite it; the Graph-named keys the module takes
# (subscriptionId, resourceGroupName, logicAppWorkflowName) work too and win when both are given.
variable "logic_app" {
  type = object({
    subscriptionId          = optional(string)
    resourceGroupName       = optional(string)
    logicAppWorkflowName    = optional(string)
    subscription_id         = optional(string)
    resource_group_name     = optional(string)
    logic_app_workflow_name = optional(string)
  })
}

output "logic_app" {
  value = {
    subscriptionId       = coalesce(var.logic_app.subscriptionId, var.logic_app.subscription_id)
    resourceGroupName    = coalesce(var.logic_app.resourceGroupName, var.logic_app.resource_group_name)
    logicAppWorkflowName = coalesce(var.logic_app.logicAppWorkflowName, var.logic_app.logic_app_workflow_name)
  }
}
