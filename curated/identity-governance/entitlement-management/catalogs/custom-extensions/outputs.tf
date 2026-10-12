output "id" {
  description = "The ID of the custom workflow extension. It changes when extension_type or catalog_id changes, because that replaces the extension."
  value       = msgraph_resource.this.id
}

output "catalog_id" {
  description = "The ID of the catalog that holds the extension, in lower case."
  value       = local.catalog_id
}

output "extension_type" {
  description = "The extension type, \"request_workflow\" or \"assignment_workflow\"."
  value       = var.extension_type
}

output "odata_type" {
  description = "The concrete @odata.type of the extension, which a policy stage setting must name."
  value       = local.odata_type
}

output "display_name" {
  description = "The effective display name: display_name, or the Logic App workflow name when display_name is null."
  value       = local.display_name
}

output "logic_app_resource_id" {
  description = "The Azure resource ID of the Logic App: /subscriptions/{subscription}/resourceGroups/{group}/providers/Microsoft.Logic/workflows/{workflow}. The HTTP trigger URL is never an output."
  value       = local.logic_app_resource_id
}

output "binding" {
  description = "The extension id and type in the shape of an assignment policy's custom_extension_stage_settings element, without the stage. Add the stage with merge(module.<name>.binding, { stage = \"assignmentRequestGranted\" })."
  value = {
    extension_id   = msgraph_resource.this.id
    extension_type = var.extension_type
  }
}
