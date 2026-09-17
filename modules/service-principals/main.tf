locals {
  body = merge(
    {
      appId                     = var.app_id
      accountEnabled            = var.account_enabled
      appRoleAssignmentRequired = var.app_role_assignment_required
    },
    var.description != null ? { description = var.description } : {},
    var.notes != null ? { notes = var.notes } : {},
    length(var.tags) > 0 ? { tags = var.tags } : {},
    var.login_url != null ? { loginUrl = var.login_url } : {},
    var.preferred_single_sign_on_mode != null ? { preferredSingleSignOnMode = var.preferred_single_sign_on_mode } : {},
  )
}

resource "msgraph_resource" "service_principal" {
  url         = "servicePrincipals"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    app_id       = "appId"
    display_name = "appDisplayName"
  }
}
