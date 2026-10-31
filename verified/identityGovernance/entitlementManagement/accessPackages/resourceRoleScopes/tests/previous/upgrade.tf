output "post_state_id" { value = msgraph_resource_action.resource_role_scope.id }
output "owned_state_id" { value = null_resource.remove_on_destroy[0].id }
