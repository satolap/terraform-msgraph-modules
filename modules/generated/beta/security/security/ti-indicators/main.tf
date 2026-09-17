# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "action"                      = var.action
    "activityGroupNames"          = (var.activity_group_names == null ? null : [for item0 in var.activity_group_names : item0 if item0 != null])
    "additionalInformation"       = var.additional_information
    "azureTenantId"               = var.azure_tenant_id
    "confidence"                  = var.confidence
    "description"                 = var.description
    "diamondModel"                = var.diamond_model
    "domainName"                  = var.domain_name
    "emailEncoding"               = var.email_encoding
    "emailLanguage"               = var.email_language
    "emailRecipient"              = var.email_recipient
    "emailSenderAddress"          = var.email_sender_address
    "emailSenderName"             = var.email_sender_name
    "emailSourceDomain"           = var.email_source_domain
    "emailSourceIpAddress"        = var.email_source_ip_address
    "emailSubject"                = var.email_subject
    "emailXMailer"                = var.email_x_mailer
    "expirationDateTime"          = var.expiration_date_time
    "externalId"                  = var.external_id
    "fileCompileDateTime"         = var.file_compile_date_time
    "fileCreatedDateTime"         = var.file_created_date_time
    "fileHashType"                = var.file_hash_type
    "fileHashValue"               = var.file_hash_value
    "fileMutexName"               = var.file_mutex_name
    "fileName"                    = var.file_name
    "filePacker"                  = var.file_packer
    "filePath"                    = var.file_path
    "fileSize"                    = var.file_size
    "fileType"                    = var.file_type
    "ingestedDateTime"            = var.ingested_date_time
    "isActive"                    = var.is_active
    "killChain"                   = (var.kill_chain == null ? null : [for item0 in var.kill_chain : item0 if item0 != null])
    "knownFalsePositives"         = var.known_false_positives
    "lastReportedDateTime"        = var.last_reported_date_time
    "malwareFamilyNames"          = (var.malware_family_names == null ? null : [for item0 in var.malware_family_names : item0 if item0 != null])
    "networkCidrBlock"            = var.network_cidr_block
    "networkDestinationAsn"       = var.network_destination_asn
    "networkDestinationCidrBlock" = var.network_destination_cidr_block
    "networkDestinationIPv4"      = var.network_destination_i_pv4
    "networkDestinationIPv6"      = var.network_destination_i_pv6
    "networkDestinationPort"      = var.network_destination_port
    "networkIPv4"                 = var.network_i_pv4
    "networkIPv6"                 = var.network_i_pv6
    "networkPort"                 = var.network_port
    "networkProtocol"             = var.network_protocol
    "networkSourceAsn"            = var.network_source_asn
    "networkSourceCidrBlock"      = var.network_source_cidr_block
    "networkSourceIPv4"           = var.network_source_i_pv4
    "networkSourceIPv6"           = var.network_source_i_pv6
    "networkSourcePort"           = var.network_source_port
    "@odata.type"                 = var.odata_type
    "passiveOnly"                 = var.passive_only
    "severity"                    = var.severity
    "tags"                        = (var.tags == null ? null : [for item0 in var.tags : item0 if item0 != null])
    "targetProduct"               = var.target_product
    "threatType"                  = var.threat_type
    "tlpLevel"                    = var.tlp_level
    "url"                         = var.url
    "userAgent"                   = var.user_agent
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/tiIndicators"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
