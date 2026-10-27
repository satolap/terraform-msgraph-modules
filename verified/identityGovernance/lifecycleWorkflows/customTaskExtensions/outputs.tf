output "id" {
  description = "The ID of the custom task extension. Pass it as the customTaskExtensionID argument of a run_a_custom_task_extension task in the workflows module; the reference also orders the destroy so that the workflow goes before the extension."
  value       = msgraph_resource.extension.id
}

output "display_name" {
  description = "The display name of the extension, as configured."
  value       = var.display_name
}

output "reply_mode" {
  description = "How the extension answers the workflow, derived from the configuration: \"callback\" when callback_timeout_duration is set (launch and wait), otherwise \"none\" (launch and continue). Learn lists a replyMode property but documents no way to set it, so this is not read from Graph."
  value       = var.callback_timeout_duration == null ? "none" : "callback"
}

output "created_date_time" {
  description = "When the extension was created, as the read returned it after the last refresh."
  value       = msgraph_resource.extension.output.created_date_time
}

output "last_modified_date_time" {
  description = "When the extension was last modified, as the read returned it after the last refresh."
  value       = msgraph_resource.extension.output.last_modified_date_time
}

output "request_body" {
  description = "The request body that the module sends to create the extension, in Microsoft Graph's shape. It carries no secret: the application ID, subscription ID, resource group and Logic App name are identifiers, and this API has no credential."
  value       = local.body
}
