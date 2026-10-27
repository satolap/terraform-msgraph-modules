locals {
  app_roles_body = [
    for r in coalesce(var.app_roles, []) : {
      id                 = r.id
      displayName        = r.display_name
      description        = r.description
      value              = r.value
      allowedMemberTypes = r.allowed_member_types
      isEnabled          = r.is_enabled
    }
  ]

  body = merge(
    {
      displayName    = var.display_name
      signInAudience = var.sign_in_audience
    },
    var.description != null ? { description = var.description } : {},
    var.notes != null ? { notes = var.notes } : {},
    var.tags != null ? { tags = var.tags } : {},
    var.app_roles != null ? { appRoles = local.app_roles_body } : {},
    var.web_redirect_uris != null ? { web = { redirectUris = var.web_redirect_uris } } : {},
    var.spa_redirect_uris != null ? { spa = { redirectUris = var.spa_redirect_uris } } : {},
    var.public_client_redirect_uris != null ? { publicClient = { redirectUris = var.public_client_redirect_uris } } : {},
  )
}

resource "msgraph_resource" "application" {
  url         = "applications"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    app_id       = "appId"
    display_name = "displayName"
  }

  lifecycle {
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
  }
}

# The provider's computed `output` has no use-state-for-unknown modifier, so any
# planned body change, such as a rename, makes `output.app_id` unknown until
# apply. A dependent that keys replacement on app_id (service-principals) would
# then be replaced. appId never changes for an application, so keep the value
# from creation and refresh it whenever the application's stable `id` changes:
# on replacement, and on a fresh create after the application left the state.
# triggers_replace also fires in the second case; replace_triggered_by does not.
# Callers read `input`, not `output`: a new terraform_data plans its output as
# unknown even for a known input, which would replace a fed service principal on
# the upgrade that adds this resource. With ignore_changes, the planned input is
# the stored value, or on creation the plan-known app_id.
resource "terraform_data" "app_id" {
  input            = msgraph_resource.application.output.app_id
  triggers_replace = msgraph_resource.application.id

  lifecycle {
    ignore_changes = [input]
  }
}
