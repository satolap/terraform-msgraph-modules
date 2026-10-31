# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "authenticationType"               = var.authenticationType
    "availabilityStatus"               = var.availabilityStatus
    "federationConfiguration"          = (var.federationConfiguration == null ? null : [for item0 in var.federationConfiguration : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "activeSignInUri" = item0["activeSignInUri"], "defaultInteractiveAuthenticationMethod" = item0["defaultInteractiveAuthenticationMethod"], "displayName" = item0["displayName"], "federatedIdpMfaBehavior" = item0["federatedIdpMfaBehavior"], "isSignedAuthenticationRequestRequired" = item0["isSignedAuthenticationRequestRequired"], "issuerUri" = item0["issuerUri"], "metadataExchangeUri" = item0["metadataExchangeUri"], "nextSigningCertificate" = item0["nextSigningCertificate"], "openIdConnectDiscoveryEndpoint" = item0["openIdConnectDiscoveryEndpoint"], "passiveSignInUri" = item0["passiveSignInUri"], "passwordChangeUri" = item0["passwordChangeUri"], "passwordResetUri" = item0["passwordResetUri"], "preferredAuthenticationProtocol" = item0["preferredAuthenticationProtocol"], "promptLoginBehavior" = item0["promptLoginBehavior"], "signOutUri" = item0["signOutUri"], "signingCertificate" = item0["signingCertificate"], "signingCertificateUpdateStatus" = (item0["signingCertificateUpdateStatus"] == null ? null : { for key2, value2 in { "@odata.type" = item0["signingCertificateUpdateStatus"]["odata_type"] } : key2 => value2 if value2 != null }) } : key1 => value1 if value1 != null }) if item0 != null])
    "isAdminManaged"                   = var.isAdminManaged
    "isDefault"                        = var.isDefault
    "isInitial"                        = var.isInitial
    "isRoot"                           = var.isRoot
    "isVerified"                       = var.isVerified
    "@odata.type"                      = var.odata_type
    "passwordNotificationWindowInDays" = var.passwordNotificationWindowInDays
    "passwordValidityPeriodInDays"     = var.passwordValidityPeriodInDays
    "sharedEmailDomainInvitations"     = (var.sharedEmailDomainInvitations == null ? null : [for item0 in var.sharedEmailDomainInvitations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "expiryTime" = item0["expiryTime"], "invitationDomain" = item0["invitationDomain"], "invitationStatus" = item0["invitationStatus"] } : key1 => value1 if value1 != null }) if item0 != null])
    "state"                            = (var.state == null ? null : { for key0, value0 in { "@odata.type" = var.state["odata_type"], "lastActionDateTime" = var.state["lastActionDateTime"], "operation" = var.state["operation"], "status" = var.state["status"] } : key0 => value0 if value0 != null })
    "supportedServices"                = (var.supportedServices == null ? null : [for item0 in var.supportedServices : item0 if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "domains"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name)), !contains(["federationConfiguration", "sharedEmailDomainInvitations"], name)])]))))] } : null

  response_export_values = {
    response = "@"
  }

  dynamic "timeouts" {
    for_each = local.timeouts_set ? [var.timeouts] : []

    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
