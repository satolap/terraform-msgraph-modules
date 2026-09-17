# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "alertIds"                      = (var.alert_ids == null ? null : [for item0 in var.alert_ids : item0 if item0 != null])
    "attachments"                   = (var.attachments == null ? null : [for item0 in var.attachments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "detonationDetails" = item0["detonationDetails"], "fileExtension" = item0["fileExtension"], "fileName" = item0["fileName"], "fileSize" = item0["fileSize"], "fileType" = item0["fileType"], "malwareFamily" = item0["malwareFamily"], "sha256" = item0["sha256"], "tenantAllowBlockListDetailInfo" = item0["tenantAllowBlockListDetailInfo"], "threatType" = item0["threatType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "authenticationDetails"         = var.authentication_details
    "bulkComplaintLevel"            = var.bulk_complaint_level
    "clientType"                    = var.client_type
    "contexts"                      = (var.contexts == null ? null : [for item0 in var.contexts : item0 if item0 != null])
    "detectionMethods"              = (var.detection_methods == null ? null : [for item0 in var.detection_methods : item0 if item0 != null])
    "directionality"                = var.directionality
    "distributionList"              = var.distribution_list
    "dlpRules"                      = (var.dlp_rules == null ? null : [for item0 in var.dlp_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "ruleId" = item0["ruleId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "emailClusterId"                = var.email_cluster_id
    "exchangeTransportRules"        = (var.exchange_transport_rules == null ? null : [for item0 in var.exchange_transport_rules : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "name" = item0["name"], "ruleId" = item0["ruleId"] } : key1 => value1 if value1 != null }) if item0 != null])
    "forwardingDetail"              = var.forwarding_detail
    "inboundConnectorFormattedName" = var.inbound_connector_formatted_name
    "internetMessageId"             = var.internet_message_id
    "language"                      = var.language
    "latestDelivery"                = var.latest_delivery
    "loggedDateTime"                = var.logged_date_time
    "networkMessageId"              = var.network_message_id
    "@odata.type"                   = var.odata_type
    "originalDelivery"              = var.original_delivery
    "overrideSources"               = (var.override_sources == null ? null : [for item0 in var.override_sources : item0 if item0 != null])
    "phishConfidenceLevel"          = var.phish_confidence_level
    "policy"                        = var.policy
    "policyAction"                  = var.policy_action
    "policyType"                    = var.policy_type
    "primaryOverrideSource"         = var.primary_override_source
    "recipientDetail"               = var.recipient_detail
    "recipientEmailAddress"         = var.recipient_email_address
    "returnPath"                    = var.return_path
    "senderDetail"                  = var.sender_detail
    "sizeInBytes"                   = var.size_in_bytes
    "spamConfidenceLevel"           = var.spam_confidence_level
    "subject"                       = var.subject
    "threatDetectionDetails"        = (var.threat_detection_details == null ? null : [for item0 in var.threat_detection_details : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "confidenceLevel" = item0["confidenceLevel"], "priorityAccountProtection" = item0["priorityAccountProtection"], "threats" = item0["threats"] } : key1 => value1 if value1 != null }) if item0 != null])
    "threatTypes"                   = (var.threat_types == null ? null : [for item0 in var.threat_types : item0 if item0 != null])
    "timelineEvents"                = (var.timeline_events == null ? null : [for item0 in var.timeline_events : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "eventDateTime" = item0["eventDateTime"], "eventDetails" = item0["eventDetails"], "eventResult" = item0["eventResult"], "eventSource" = item0["eventSource"], "eventThreats" = (item0["eventThreats"] == null ? null : [for item2 in item0["eventThreats"] : item2 if item2 != null]), "eventType" = item0["eventType"] } : key1 => value1 if value1 != null }) if item0 != null])
    "urls"                          = (var.urls == null ? null : [for item0 in var.urls : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "detectionMethod" = item0["detectionMethod"], "detonationDetails" = item0["detonationDetails"], "tenantAllowBlockListDetailInfo" = item0["tenantAllowBlockListDetailInfo"], "threatType" = item0["threatType"], "url" = item0["url"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "security/collaboration/analyzedEmails"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
