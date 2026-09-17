# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assistantName"         = var.assistant_name
    "birthday"              = var.birthday
    "businessAddress"       = var.business_address
    "businessHomePage"      = var.business_home_page
    "businessPhones"        = (var.business_phones == null ? null : [for item0 in var.business_phones : item0 if item0 != null])
    "categories"            = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "children"              = (var.children == null ? null : [for item0 in var.children : item0 if item0 != null])
    "companyName"           = var.company_name
    "createdDateTime"       = var.created_date_time
    "department"            = var.department
    "displayName"           = var.display_name
    "emailAddresses"        = (var.email_addresses == null ? null : [for item0 in var.email_addresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "address" = item0["address"], "name" = item0["name"] } : key1 => value1 if value1 != null }) if item0 != null])
    "fileAs"                = var.file_as
    "generation"            = var.generation
    "givenName"             = var.given_name
    "homeAddress"           = var.home_address
    "homePhones"            = (var.home_phones == null ? null : [for item0 in var.home_phones : item0 if item0 != null])
    "imAddresses"           = (var.im_addresses == null ? null : [for item0 in var.im_addresses : item0 if item0 != null])
    "initials"              = var.initials
    "jobTitle"              = var.job_title
    "lastModifiedDateTime"  = var.last_modified_date_time
    "manager"               = var.manager
    "middleName"            = var.middle_name
    "mobilePhone"           = var.mobile_phone
    "nickName"              = var.nick_name
    "@odata.type"           = var.odata_type
    "officeLocation"        = var.office_location
    "otherAddress"          = var.other_address
    "parentFolderId"        = var.parent_folder_id
    "personalNotes"         = var.personal_notes
    "photo"                 = var.photo
    "primaryEmailAddress"   = var.primary_email_address
    "profession"            = var.profession
    "secondaryEmailAddress" = var.secondary_email_address
    "spouseName"            = var.spouse_name
    "surname"               = var.surname
    "tertiaryEmailAddress"  = var.tertiary_email_address
    "title"                 = var.title
    "yomiCompanyName"       = var.yomi_company_name
    "yomiGivenName"         = var.yomi_given_name
    "yomiSurname"           = var.yomi_surname
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "users/${urlencode(var.user_id)}/contactFolders/${urlencode(var.contact_folder_id)}/childFolders/${urlencode(var.contact_folder_id1)}/contacts"
  api_version             = "v1.0"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
