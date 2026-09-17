locals {
  body = merge(
    {
      accountEnabled    = var.account_enabled
      displayName       = var.display_name
      mailNickname      = var.mail_nickname
      userPrincipalName = var.user_principal_name
      passwordProfile = {
        password                      = var.password
        forceChangePasswordNextSignIn = var.force_change_password_next_sign_in
      }
    },
    var.given_name != null ? { givenName = var.given_name } : {},
    var.surname != null ? { surname = var.surname } : {},
    var.job_title != null ? { jobTitle = var.job_title } : {},
    var.department != null ? { department = var.department } : {},
    var.usage_location != null ? { usageLocation = var.usage_location } : {},
    var.additional_properties,
  )
}

resource "msgraph_resource" "user" {
  url         = "users"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    display_name        = "displayName"
    user_principal_name = "userPrincipalName"
  }
}
