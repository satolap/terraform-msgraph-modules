# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"                      = var.action
    "activityGroupNames"          = (var.activityGroupNames == null ? null : [for item0 in var.activityGroupNames : item0 if item0 != null])
    "additionalInformation"       = var.additionalInformation
    "azureTenantId"               = var.azureTenantId
    "confidence"                  = var.confidence
    "description"                 = var.description
    "diamondModel"                = var.diamondModel
    "domainName"                  = var.domainName
    "emailEncoding"               = var.emailEncoding
    "emailLanguage"               = var.emailLanguage
    "emailRecipient"              = var.emailRecipient
    "emailSenderAddress"          = var.emailSenderAddress
    "emailSenderName"             = var.emailSenderName
    "emailSourceDomain"           = var.emailSourceDomain
    "emailSourceIpAddress"        = var.emailSourceIpAddress
    "emailSubject"                = var.emailSubject
    "emailXMailer"                = var.emailXMailer
    "expirationDateTime"          = var.expirationDateTime
    "externalId"                  = var.externalId
    "fileCompileDateTime"         = var.fileCompileDateTime
    "fileCreatedDateTime"         = var.fileCreatedDateTime
    "fileHashType"                = var.fileHashType
    "fileHashValue"               = var.fileHashValue
    "fileMutexName"               = var.fileMutexName
    "fileName"                    = var.fileName
    "filePacker"                  = var.filePacker
    "filePath"                    = var.filePath
    "fileSize"                    = var.fileSize
    "fileType"                    = var.fileType
    "ingestedDateTime"            = var.ingestedDateTime
    "isActive"                    = var.isActive
    "killChain"                   = (var.killChain == null ? null : [for item0 in var.killChain : item0 if item0 != null])
    "knownFalsePositives"         = var.knownFalsePositives
    "lastReportedDateTime"        = var.lastReportedDateTime
    "malwareFamilyNames"          = (var.malwareFamilyNames == null ? null : [for item0 in var.malwareFamilyNames : item0 if item0 != null])
    "networkCidrBlock"            = var.networkCidrBlock
    "networkDestinationAsn"       = var.networkDestinationAsn
    "networkDestinationCidrBlock" = var.networkDestinationCidrBlock
    "networkDestinationIPv4"      = var.networkDestinationIPv4
    "networkDestinationIPv6"      = var.networkDestinationIPv6
    "networkDestinationPort"      = var.networkDestinationPort
    "networkIPv4"                 = var.networkIPv4
    "networkIPv6"                 = var.networkIPv6
    "networkPort"                 = var.networkPort
    "networkProtocol"             = var.networkProtocol
    "networkSourceAsn"            = var.networkSourceAsn
    "networkSourceCidrBlock"      = var.networkSourceCidrBlock
    "networkSourceIPv4"           = var.networkSourceIPv4
    "networkSourceIPv6"           = var.networkSourceIPv6
    "networkSourcePort"           = var.networkSourcePort
    "@odata.type"                 = var.odata_type
    "passiveOnly"                 = var.passiveOnly
    "severity"                    = var.severity
    "tags"                        = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "targetProduct"               = var.targetProduct
    "threatType"                  = var.threatType
    "tlpLevel"                    = var.tlpLevel
    "url"                         = var.url
    "userAgent"                   = var.userAgent
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

locals {
  timeouts_set = anytrue([var.timeouts.create != null, var.timeouts.read != null, var.timeouts.update != null, var.timeouts.delete != null])
}

resource "msgraph_resource" "this" {
  url                     = "security/tiIndicators"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true
  read_query_parameters   = var.select_response ? { "$select" = [join(",", sort(distinct(concat(["id"], [for name in keys(local.body) : name if alltrue([!startswith(name, "@"), !can(regex("@odata\\.", name))])]))))] } : null

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
