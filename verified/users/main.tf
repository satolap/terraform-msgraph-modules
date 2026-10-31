locals {
  body = merge(
    {
      accountEnabled    = var.accountEnabled
      displayName       = var.displayName
      mailNickname      = var.mailNickname
      userPrincipalName = var.userPrincipalName
      passwordProfile = {
        password                      = var.password
        forceChangePasswordNextSignIn = var.force_change_password_next_sign_in
      }
    },
    var.givenName != null ? { givenName = var.givenName } : {},
    var.surname != null ? { surname = var.surname } : {},
    var.jobTitle != null ? { jobTitle = var.jobTitle } : {},
    var.department != null ? { department = var.department } : {},
    var.usageLocation != null ? { usageLocation = var.usageLocation } : {},
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
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.displayName))
      error_message = "displayName \"${var.displayName}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set displayName to a value that matches, or change name_pattern."
    }
    precondition {
      condition     = var.mail_nickname_pattern == null || can(regex(var.mail_nickname_pattern, var.mailNickname))
      error_message = "mailNickname \"${var.mailNickname}\" does not match mail_nickname_pattern \"${var.mail_nickname_pattern == null ? "" : var.mail_nickname_pattern}\". Set mailNickname to a value that matches, or change mail_nickname_pattern."
    }
  }
}
