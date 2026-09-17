# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "displayName"                   = var.display_name
    "isCourseActivitySyncEnabled"   = var.is_course_activity_sync_enabled
    "learningContents"              = (var.learning_contents == null ? null : [for item0 in var.learning_contents : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "additionalTags" = (item0["additionalTags"] == null ? null : [for item2 in item0["additionalTags"] : item2 if item2 != null]), "contentWebUrl" = item0["contentWebUrl"], "contributors" = (item0["contributors"] == null ? null : [for item2 in item0["contributors"] : item2 if item2 != null]), "createdDateTime" = item0["createdDateTime"], "description" = item0["description"], "duration" = item0["duration"], "externalId" = item0["externalId"], "format" = item0["format"], "isActive" = item0["isActive"], "isPremium" = item0["isPremium"], "isSearchable" = item0["isSearchable"], "languageTag" = item0["languageTag"], "lastModifiedDateTime" = item0["lastModifiedDateTime"], "level" = item0["level"], "numberOfPages" = item0["numberOfPages"], "skillTags" = (item0["skillTags"] == null ? null : [for item2 in item0["skillTags"] : item2 if item2 != null]), "sourceName" = item0["sourceName"], "thumbnailWebUrl" = item0["thumbnailWebUrl"], "title" = item0["title"] } : key1 => value1 if value1 != null }) if item0 != null])
    "learningCourseActivities"      = (var.learning_course_activities == null ? null : [for item0 in var.learning_course_activities : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "completedDateTime" = item0["completedDateTime"], "completionPercentage" = item0["completionPercentage"], "externalcourseActivityId" = item0["externalcourseActivityId"], "learnerUserId" = item0["learnerUserId"], "learningContentId" = item0["learningContentId"], "learningProviderId" = item0["learningProviderId"], "status" = item0["status"] } : key1 => value1 if value1 != null }) if item0 != null])
    "loginWebUrl"                   = var.login_web_url
    "longLogoWebUrlForDarkTheme"    = var.long_logo_web_url_for_dark_theme
    "longLogoWebUrlForLightTheme"   = var.long_logo_web_url_for_light_theme
    "@odata.type"                   = var.odata_type
    "squareLogoWebUrlForDarkTheme"  = var.square_logo_web_url_for_dark_theme
    "squareLogoWebUrlForLightTheme" = var.square_logo_web_url_for_light_theme
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "employeeExperience/learningProviders"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
