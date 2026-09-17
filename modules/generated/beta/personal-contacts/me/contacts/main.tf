# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assistantName"         = var.assistant_name
    "birthday"              = var.birthday
    "categories"            = (var.categories == null ? null : [for item0 in var.categories : item0 if item0 != null])
    "children"              = (var.children == null ? null : [for item0 in var.children : item0 if item0 != null])
    "companyName"           = var.company_name
    "createdDateTime"       = var.created_date_time
    "department"            = var.department
    "displayName"           = var.display_name
    "emailAddresses"        = (var.email_addresses == null ? null : [for item0 in var.email_addresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "address" = item0["address"], "name" = item0["name"], "otherLabel" = item0["otherLabel"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "extensions"            = (var.extensions == null ? null : [for item0 in var.extensions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "fileAs"                = var.file_as
    "flag"                  = var.flag
    "gender"                = var.gender
    "generation"            = var.generation
    "givenName"             = var.given_name
    "imAddresses"           = (var.im_addresses == null ? null : [for item0 in var.im_addresses : item0 if item0 != null])
    "initials"              = var.initials
    "isFavorite"            = var.is_favorite
    "jobTitle"              = var.job_title
    "lastModifiedDateTime"  = var.last_modified_date_time
    "manager"               = var.manager
    "middleName"            = var.middle_name
    "nickName"              = var.nick_name
    "@odata.type"           = var.odata_type
    "officeLocation"        = var.office_location
    "parentFolderId"        = var.parent_folder_id
    "personalNotes"         = var.personal_notes
    "phones"                = (var.phones == null ? null : [for item0 in var.phones : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "number" = item0["number"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "photo"                 = var.photo
    "postalAddresses"       = (var.postal_addresses == null ? null : [for item0 in var.postal_addresses : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "city" = item0["city"], "countryOrRegion" = item0["countryOrRegion"], "postOfficeBox" = item0["postOfficeBox"], "postalCode" = item0["postalCode"], "state" = item0["state"], "street" = item0["street"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "primaryEmailAddress"   = var.primary_email_address
    "profession"            = var.profession
    "secondaryEmailAddress" = var.secondary_email_address
    "spouseName"            = var.spouse_name
    "surname"               = var.surname
    "tertiaryEmailAddress"  = var.tertiary_email_address
    "title"                 = var.title
    "websites"              = (var.websites == null ? null : [for item0 in var.websites : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "address" = item0["address"], "displayName" = item0["displayName"], "type" = item0["type"] } : key1 => value1 if value1 != null }) if item0 != null])
    "weddingAnniversary"    = var.wedding_anniversary
    "yomiCompanyName"       = var.yomi_company_name
    "yomiGivenName"         = var.yomi_given_name
    "yomiSurname"           = var.yomi_surname
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "me/contacts"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
