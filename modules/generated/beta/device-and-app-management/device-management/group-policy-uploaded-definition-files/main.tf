# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "content"                          = var.content
    "defaultLanguageCode"              = var.default_language_code
    "definitions"                      = (var.definitions == null ? null : [for item0 in var.definitions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "category" = item0["category"], "categoryPath" = item0["categoryPath"], "classType" = item0["classType"], "definitionFile" = item0["definitionFile"], "displayName" = item0["displayName"], "explainText" = item0["explainText"], "groupPolicyCategoryId" = item0["groupPolicyCategoryId"], "hasRelatedDefinitions" = item0["hasRelatedDefinitions"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "minDeviceCspVersion" = item0["minDeviceCspVersion"], "minUserCspVersion" = item0["minUserCspVersion"], "nextVersionDefinition" = item0["nextVersionDefinition"], "policyType" = item0["policyType"], "presentations" = (item0["presentations"] == null ? null : [for item2 in item0["presentations"] : (item2 == null ? null : { for key3, value3 in { "@odata.type" = item2["odata_type"], "definition" = item2["definition"], "label" = item2["label"], "lastModifiedDateTime" = item2["lastModifiedDateTime"] } : key3 => value3 if value3 != null }) if item2 != null]), "previousVersionDefinition" = item0["previousVersionDefinition"], "supportedOn" = item0["supportedOn"], "version" = item0["version"] } : key1 => value1 if value1 != null }) if item0 != null])
    "description"                      = var.description
    "displayName"                      = var.display_name
    "fileName"                         = var.file_name
    "groupPolicyOperations"            = (var.group_policy_operations == null ? null : [for item0 in var.group_policy_operations : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "operationStatus" = item0["operationStatus"], "operationType" = item0["operationType"], "statusDetails" = item0["statusDetails"] } : key1 => value1 if value1 != null }) if item0 != null])
    "groupPolicyUploadedLanguageFiles" = (var.group_policy_uploaded_language_files == null ? null : [for item0 in var.group_policy_uploaded_language_files : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "content" = item0["content"], "fileName" = item0["fileName"], "id" = item0["id"], "languageCode" = item0["languageCode"], "lastModifiedDateTime" = item0["lastModifiedDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
    "languageCodes"                    = (var.language_codes == null ? null : [for item0 in var.language_codes : item0 if item0 != null])
    "lastModifiedDateTime"             = var.last_modified_date_time
    "@odata.type"                      = var.odata_type
    "policyType"                       = var.policy_type
    "revision"                         = var.revision
    "status"                           = var.status
    "targetNamespace"                  = var.target_namespace
    "targetPrefix"                     = var.target_prefix
    "uploadDateTime"                   = var.upload_date_time
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "deviceManagement/groupPolicyUploadedDefinitionFiles"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
