locals {
  app_roles_body = [
    for r in var.app_roles : {
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
    length(var.tags) > 0 ? { tags = var.tags } : {},
    length(var.app_roles) > 0 ? { appRoles = local.app_roles_body } : {},
    length(var.web_redirect_uris) > 0 ? { web = { redirectUris = var.web_redirect_uris } } : {},
    length(var.spa_redirect_uris) > 0 ? { spa = { redirectUris = var.spa_redirect_uris } } : {},
    length(var.public_client_redirect_uris) > 0 ? { publicClient = { redirectUris = var.public_client_redirect_uris } } : {},
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
}
