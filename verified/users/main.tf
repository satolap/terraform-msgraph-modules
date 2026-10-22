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

  lifecycle {
    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }
    precondition {
      condition     = var.mail_nickname_pattern == null || can(regex(var.mail_nickname_pattern, var.mail_nickname))
      error_message = "mail_nickname \"${var.mail_nickname}\" does not match mail_nickname_pattern \"${var.mail_nickname_pattern == null ? "" : var.mail_nickname_pattern}\". Set mail_nickname to a value that matches, or change mail_nickname_pattern."
    }
  }
}
