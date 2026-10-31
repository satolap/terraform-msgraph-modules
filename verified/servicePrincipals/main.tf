locals {
  body = merge(
    {
      appId                     = var.appId
      accountEnabled            = var.accountEnabled
      appRoleAssignmentRequired = var.appRoleAssignmentRequired
    },
    var.description != null ? { description = var.description } : {},
    var.notes != null ? { notes = var.notes } : {},
    var.tags != null ? { tags = var.tags } : {},
    var.loginUrl != null ? { loginUrl = var.loginUrl } : {},
    var.preferredSingleSignOnMode != null ? { preferredSingleSignOnMode = var.preferredSingleSignOnMode } : {},
  )
}

# A service principal belongs to one application for its whole life: Microsoft
# Learn's update servicePrincipal page does not list appId among the properties
# a PATCH can change. A change of app_id replaces the service principal. The
# old one is deleted first. Creating the new one first would make Terraform
# create a replaced application before deleting the old one too, and two
# applications can collide on unique values such as identifier URIs.
resource "terraform_data" "immutable" {
  input = {
    app_id = lower(var.appId)
  }
}

resource "msgraph_resource" "service_principal" {
  url         = "servicePrincipals"
  api_version = var.api_version
  body        = local.body

  response_export_values = {
    app_id       = "appId"
    display_name = "appDisplayName"
  }

  lifecycle {
    replace_triggered_by = [terraform_data.immutable]

    # appId is sent only when the service principal is created; Terraform plans
    # a create from the full configuration. An in-place update never sends it,
    # so a change of only its case is not a PATCH of appId. Lower-casing it in
    # the body instead would send that PATCH for every caller whose state holds
    # upper-case letters.
    ignore_changes = [body.appId]
  }
}
