# Integration-test helper: turns the Logic App fixture secret (TF_VAR_logic_app, LOGIC_APP_DEV)
# into the module's logic_app object. The secret keeps the keys it always had (subscription_id,
# resource_group_name, workflow_name, trigger_url), so nobody has to rewrite it; the Graph-named
# keys the module takes (subscriptionId, resourceGroupName, logicAppWorkflowName, url) work too.
# A key given both ways takes the Graph-named one.
variable "logic_app" {
  type = object({
    subscriptionId       = optional(string)
    resourceGroupName    = optional(string)
    logicAppWorkflowName = optional(string)
    url                  = optional(string)
    subscription_id      = optional(string)
    resource_group_name  = optional(string)
    workflow_name        = optional(string)
    trigger_url          = optional(string)
  })
}

output "logic_app" {
  value = {
    subscriptionId       = coalesce(var.logic_app.subscriptionId, var.logic_app.subscription_id)
    resourceGroupName    = coalesce(var.logic_app.resourceGroupName, var.logic_app.resource_group_name)
    logicAppWorkflowName = coalesce(var.logic_app.logicAppWorkflowName, var.logic_app.workflow_name)
    url                  = try(coalesce(var.logic_app.url, var.logic_app.trigger_url), null)
  }
}
