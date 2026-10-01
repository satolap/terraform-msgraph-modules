locals {
  odata_types = {
    request_workflow    = "#microsoft.graph.accessPackageAssignmentRequestWorkflowExtension"
    assignment_workflow = "#microsoft.graph.accessPackageAssignmentWorkflowExtension"
  }

  odata_type   = local.odata_types[var.extension_type]
  display_name = var.display_name == null ? var.logic_app.workflow_name : var.display_name

  # A GUID has no case: Microsoft Learn's examples send ids in upper case in a
  # request url and show them in lower case in a response. Using the input in
  # lower case everywhere means a change of case alone plans nothing: the replace
  # trigger and both urls keep the same text, so the extension is neither
  # replaced nor updated.
  catalog_id = lower(var.catalog_id)

  logic_app_resource_id = "/subscriptions/${var.logic_app.subscription_id}/resourceGroups/${var.logic_app.resource_group_name}/providers/Microsoft.Logic/workflows/${var.logic_app.workflow_name}"

  # Every managed key is in the body, on create and on update. An update is a
  # PUT, and Microsoft Graph keeps the properties that its body omits, so a
  # description that is no longer configured is sent as null rather than left
  # out. The body never holds a property this module does not manage; the
  # unmanaged_properties check reports those.
  body = {
    "@odata.type" = local.odata_type
    displayName   = local.display_name
    description   = var.description
    endpointConfiguration = merge(
      {
        "@odata.type"        = "#microsoft.graph.logicAppTriggerEndpointConfiguration"
        subscriptionId       = var.logic_app.subscription_id
        resourceGroupName    = var.logic_app.resource_group_name
        logicAppWorkflowName = var.logic_app.workflow_name
      },
      var.logic_app.trigger_url == null ? {} : { url = var.logic_app.trigger_url },
    )
    authenticationConfiguration = {
      "@odata.type" = "#microsoft.graph.azureAdPopTokenAuthentication"
    }
  }

  # The extensions of the catalog as of the last read of the listing, without
  # their endpoint configuration.
  extensions_in_catalog = try(data.msgraph_resource.catalog_extensions.output.extensions, [])

  # Another extension of the same type with the same name. Comparing only the
  # same type keeps a replacement that changes the type from warning, because
  # the old extension is still listed under the same name until it is deleted.
  duplicate_extension_ids = try(sort([
    for e in local.extensions_in_catalog : e.id
    if e.odata_type == local.odata_type && e.display_name == local.display_name && e.id != msgraph_resource.this.id
  ]), [])

  # The properties this module does not manage that Microsoft Graph returned
  # set on the last read; empty when no read has exported them. An update keeps
  # them and a replacement creates the extension from the configuration only,
  # so they are lost.
  server_unmanaged = try(msgraph_resource.this.output.unmanaged_properties, null)
  unmanaged_set = sort(compact([
    try(local.server_unmanaged.callback_configuration == true, false) ? "callbackConfiguration" : "",
    try(local.server_unmanaged.client_configuration == true, false) ? "clientConfiguration" : "",
    try(local.server_unmanaged.behavior_on_error == true, false) ? "behaviorOnError" : "",
    try(local.server_unmanaged.other_authentication == true, false) ? "authenticationConfiguration" : "",
  ]))
}

# Lists the catalog's extensions for the unique_display_name check. It is a
# top-level data source, not one inside the check block, so that a 401 or 403
# fails the plan instead of reading as "no extensions". Microsoft Learn says the
# list supports $select and $filter, but shows only a contains() filter on the
# display name and does not say whether $filter works on @odata.type or for both
# extension types. The check needs an exact match on type and name, and a
# filter that Graph rejected would fail every plan, because this data source is
# top-level. So the module reads the whole list, and exports only the id, type
# and name of each extension, so the endpoint configuration of the other
# extensions does not enter the state.
data "msgraph_resource" "catalog_extensions" {
  url         = "identityGovernance/entitlementManagement/catalogs/${local.catalog_id}/customWorkflowExtensions"
  api_version = "v1.0"

  response_export_values = {
    extensions = "value[].{id: id, odata_type: \"@odata.type\", display_name: displayName}"
  }
}

# An update can change neither the type nor the catalog, and the provider
# replaces a resource when its url changes only for relationship urls, so a
# changed catalog_id would otherwise send the update to the old catalog. A
# change to either value replaces the extension, and the new one is created
# first, so the id changes before the old extension is deleted. The catalog id
# is in lower case, so that a change of case alone does not replace it.
resource "terraform_data" "identity" {
  input = {
    extension_type = var.extension_type
    catalog_id     = local.catalog_id
  }
}

resource "msgraph_resource" "this" {
  url                     = "identityGovernance/entitlementManagement/catalogs/${local.catalog_id}/customWorkflowExtensions"
  api_version             = "v1.0"
  body                    = local.body
  update_method           = "PUT"
  ignore_missing_property = false

  response_export_values = {
    # Which properties that this module does not manage are set on the server,
    # for the unmanaged_properties check. No function or ! operator: an
    # evaluation error drops the key from the provider's output.
    unmanaged_properties = "{callback_configuration: callbackConfiguration != `null`, client_configuration: clientConfiguration != `null`, behavior_on_error: behaviorOnError != `null`, other_authentication: authenticationConfiguration.\"@odata.type\" != `null` && authenticationConfiguration.\"@odata.type\" != '#microsoft.graph.azureAdPopTokenAuthentication'}"
  }

  timeouts {
    create = var.timeouts.create
    read   = var.timeouts.read
    update = var.timeouts.update
    delete = var.timeouts.delete
  }

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [terraform_data.identity]

    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, local.display_name))
      error_message = "The extension display name \"${local.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a name that matches, or change name_pattern."
    }
  }
}

# Warns, without failing the plan or apply, when another extension of the same
# type in the catalog has the same display name. Microsoft Learn does not say
# whether names must be unique; a duplicate makes the extensions hard to tell
# apart when a policy stage is configured. A create-before-destroy replacement
# of the same type (terraform apply -replace) warns until the old extension is
# deleted. On a plan that creates or replaces the extension the extension's id
# is not known yet, and Terraform warns that the result is known after apply
# instead.
check "unique_display_name" {
  assert {
    condition     = length(local.duplicate_extension_ids) == 0
    error_message = "Catalog ${local.catalog_id} already holds another extension of this type with the display name \"${local.display_name}\" (ID ${join(", ", local.duplicate_extension_ids)}). Use a distinct display_name."
  }
}

# Warns, without failing the plan or apply, when Microsoft Graph returns a
# property this module does not manage set. On a plan that creates, updates or
# replaces the extension the read-back is not known yet, and Terraform warns
# that the result is known after apply instead.
check "unmanaged_properties" {
  assert {
    condition     = length(local.unmanaged_set) == 0
    error_message = "Microsoft Graph returned properties that this module does not manage set: ${join(", ", local.unmanaged_set)}. An update keeps them and the module does not show them as drift. Replacing the extension (changing extension_type or catalog_id, or terraform apply -replace) creates it from the configuration only and loses them."
  }
}

# Warns, without failing the plan, when the Logic App resource ID is longer than
# 150 characters. Microsoft Learn states that limit for a Logic App created in
# the admin center; it does not say whether it applies to an existing Logic App
# that an extension references, so this is a warning.
check "logic_app_id_length" {
  assert {
    condition     = length(local.logic_app_resource_id) <= 150
    error_message = "The Logic App resource ID is ${length(local.logic_app_resource_id)} characters long. Microsoft Learn limits it to 150 characters for a Logic App created in the admin center, and does not say whether the limit applies to an existing Logic App. Check that Microsoft Graph accepts it."
  }
}
