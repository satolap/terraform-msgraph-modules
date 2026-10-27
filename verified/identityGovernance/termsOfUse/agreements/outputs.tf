output "id" {
  description = "The ID of the agreement. Pass it, in a separate explicit composition, as an entry of grant_controls.terms_of_use of a Conditional Access policy; the reference also orders the destroy so that the policy goes before the agreement."
  value       = msgraph_resource.agreement.id
}

output "display_name" {
  description = "The display name of the agreement, as configured."
  value       = var.display_name
}

output "file_languages" {
  description = "The languages of the files this module manages, lower case and sorted: the default file's and every additional file's."
  value       = sort(local.all_languages)
}

output "default_file_language" {
  description = "The language of the default file, as configured."
  value       = var.default_file.language
}

output "additional_file_ids" {
  description = "The ID of each file added through additional_files, by key, as the create call returned it. The default file's ID is not returned by the create call and is not exported."
  value       = { for key, action in msgraph_resource_action.file : key => action.output.id }
}

output "content_sha256" {
  description = "The SHA-256 (hex) of the base64 text of each PDF, by lower case language. It is a fingerprint of the configured input, not a hash of the file Graph holds: Graph returns no file content in a read, so nothing compares the two."
  value = merge(
    { (local.default_language) = sha256(var.default_file.content_base64) },
    # A language repeated by mistake is refused by a precondition; the ellipsis keeps this output from failing first.
    { for language, hashes in { for key in sort(keys(var.additional_files)) : lower(var.additional_files[key].language) => sha256(var.additional_files[key].content_base64)... } : language => hashes[0] },
  )
}

output "request_summary" {
  description = "The create request without any PDF content: the agreement's properties and, per file, its name, language, default flag and content hash. Nothing in it is a secret."
  value = {
    displayName                       = var.display_name
    isViewingBeforeAcceptanceRequired = var.is_viewing_before_acceptance_required
    files = concat(
      [{
        fileName       = var.default_file.file_name
        language       = var.default_file.language
        isDefault      = true
        content_sha256 = sha256(var.default_file.content_base64)
      }],
      [for key in sort(keys(local.additional)) : {
        fileName       = var.additional_files[key].file_name
        language       = var.additional_files[key].language
        isDefault      = false
        isMajorVersion = var.additional_files[key].is_major_version
        content_sha256 = local.additional[key].content_sha256
      }],
    )
  }
}
