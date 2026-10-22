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
