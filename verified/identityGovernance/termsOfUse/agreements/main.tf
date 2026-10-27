locals {
  default_language = lower(var.default_file.language)
  all_languages    = concat([local.default_language], [for key in sort(keys(var.additional_files)) : lower(var.additional_files[key].language)])

  # The file objects of the create request and of the "create agreementFileLocalization" call.
  # The PDF is the only value marked sensitive, so that a plan shows no base64 wall; it stays in
  # the request body and therefore in the state. A null display_name is left out.
  default_file_body = merge(
    {
      fileName  = var.default_file.file_name
      language  = var.default_file.language
      isDefault = true
      fileData  = { data = sensitive(var.default_file.content_base64) }
    },
    { for key, value in { displayName = var.default_file.display_name } : key => value if value != null },
  )

  # Every property that Learn documents for creating an agreement (displayName and
  # isViewingBeforeAcceptanceRequired) plus the files array that Learn's create example sends.
  # isPerDeviceAcceptanceRequired, termsExpiration and userReacceptRequiredFrequency are on the
  # resource page but in no request table, so they are not sent.
  body = {
    displayName                       = var.display_name
    isViewingBeforeAcceptanceRequired = var.is_viewing_before_acceptance_required
    files                             = [local.default_file_body]
  }

  additional = {
    for key in sort(keys(var.additional_files)) : key => {
      body = merge(
        {
          fileName       = var.additional_files[key].file_name
          language       = var.additional_files[key].language
          isDefault      = false
          isMajorVersion = var.additional_files[key].is_major_version
          fileData       = { data = sensitive(var.additional_files[key].content_base64) }
        },
        { for name, value in { displayName = var.additional_files[key].display_name } : name => value if value != null },
      )
      content_sha256 = sha256(var.additional_files[key].content_base64)
    }
  }

  # What identifies a file for the change guard: every value, with the PDF as a hash of its
  # base64 text. A change of any of them is a change that Graph has no documented call for.
  default_fingerprint = sha256(jsonencode({
    language       = local.default_language
    file_name      = var.default_file.file_name
    display_name   = var.default_file.display_name
    content_sha256 = sha256(var.default_file.content_base64)
  }))
  additional_fingerprints = {
    for key in sort(keys(var.additional_files)) : key => sha256(jsonencode({
      language         = lower(var.additional_files[key].language)
      file_name        = var.additional_files[key].file_name
      display_name     = var.additional_files[key].display_name
      content_sha256   = local.additional[key].content_sha256
      is_major_version = var.additional_files[key].is_major_version
    }))
  }
}

# The agreement is tenant configuration. Creating, updating or deleting it enforces nothing: it
# applies to users only when a Conditional Access policy requires it as a grant control, which is
# a separate composition (see the README). The module creates no policy.
#
# Learn documents PATCH for displayName and isViewingBeforeAcceptanceRequired only, and no update
# or delete of a file, so body.files is create-only: it is ignored here, and terraform_data.guard
# refuses a configured change instead of letting the provider plan a PATCH that Graph does not
# document. Learn's create page lists flat file properties in its table but its example sends a
# files array, so the array form is used and unverified against a tenant (GB-terms-of-use-504).
resource "msgraph_resource" "agreement" {
  url         = "identityGovernance/termsOfUse/agreements"
  api_version = "v1.0"
  body        = local.body

  update_method = "PATCH"

  # The read returns the agreement's own properties (including ones this module does not manage)
  # but not the files array, so the configured files key is kept as configured.
  ignore_missing_property = true

  lifecycle {
    ignore_changes = [body.files]

    # A replacement creates the new agreement first and deletes the old one after, so that a
    # Conditional Access policy that still requires the old agreement is repointed to the new ID
    # in the same apply (when it references this module's id output) before the old one is
    # deleted. Learn does not say that an agreement display name must be unique, so the two
    # agreements may share a name for a moment (unverified; see the README runbook).
    create_before_destroy = true

    precondition {
      condition     = var.name_pattern == null || can(regex(var.name_pattern, var.display_name))
      error_message = "display_name \"${var.display_name}\" does not match name_pattern \"${var.name_pattern == null ? "" : var.name_pattern}\". Set display_name to a value that matches, or change name_pattern."
    }

    precondition {
      condition     = length(local.all_languages) == length(distinct(local.all_languages))
      error_message = "Every file of an agreement needs its own language, compared case-insensitively: default_file and additional_files must not repeat one."
    }
  }
}

# Records the agreement's ID, so that everything created for one agreement is replaced with it
# (after terraform apply -replace) and nothing is replaced by an in-place update: the ID does not
# change when displayName or isViewingBeforeAcceptanceRequired is updated.
resource "terraform_data" "agreement_identity" {
  input = msgraph_resource.agreement.id
}

# The values of the default file as they were when the agreement was created. ignore_changes keeps
# them: a later configuration is compared with this record by terraform_data.guard. The record is
# replaced only together with the agreement.
resource "terraform_data" "default_file_applied" {
  input = local.default_fingerprint

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [terraform_data.agreement_identity]
  }
}

# The record reads the ID that the POST returned, so it is saved only after the file action has
# succeeded. A rejected file leaves no record, and correcting its content and applying again is
# not refused by the guard.
resource "terraform_data" "file_applied" {
  for_each = local.additional_fingerprints

  input = {
    fingerprint = each.value
    file_id     = msgraph_resource_action.file[each.key].output.id
  }

  lifecycle {
    ignore_changes       = [input]
    replace_triggered_by = [terraform_data.agreement_identity]
  }
}

# Adds one localized file with Learn's "create agreementFileLocalization" call. A POST-only action:
# it runs once and never again, because ignore_changes = all keeps every later body and URL change
# out of the plan, and nothing here reads or deletes the file (Learn documents neither). Removing
# the key from additional_files forgets the file and leaves it in the agreement. The action is
# created again only when the agreement is replaced, which has a new ID.
resource "msgraph_resource_action" "file" {
  for_each = toset(keys(local.additional))

  resource_url = "identityGovernance/termsOfUse/agreements/${msgraph_resource.agreement.id}/files"
  method       = "POST"
  api_version  = "v1.0"
  body         = local.additional[each.key].body

  response_export_values = {
    id = "id"
  }

  lifecycle {
    ignore_changes       = all
    replace_triggered_by = [terraform_data.agreement_identity]
  }
}

# Refuses a plan that changes a file which was already applied. Learn documents no call that
# updates or deletes a localized file, a different default file or a new file version, and the
# provider would otherwise plan a PATCH Graph does not document or silently ignore the change.
# A new language is added through additional_files. To replace the agreement (new ID, and no
# acceptances: every user must accept again, and Conditional Access policies must be pointed at
# the new ID), run terraform apply -replace on msgraph_resource.agreement: the records above are
# replaced with it, so the comparison passes in that plan.
resource "terraform_data" "guard" {
  lifecycle {
    precondition {
      condition     = terraform_data.default_file_applied.input == local.default_fingerprint
      error_message = "default_file differs from the file this agreement was created with. Learn documents no update or delete of an agreement file, so the change cannot be applied in place. Restore the original default_file, add the new language through additional_files, or replace the agreement with terraform apply -replace on msgraph_resource.agreement (new ID; every user must accept again)."
    }

    precondition {
      condition     = alltrue([for key, fingerprint in local.additional_fingerprints : try(terraform_data.file_applied[key].input.fingerprint == fingerprint, true)])
      error_message = "An additional_files entry differs from the file that was added under its key. Learn documents no update or delete of an agreement file, so the change cannot be applied in place. Restore the entry, add the file under a new key and language, or replace the agreement with terraform apply -replace on msgraph_resource.agreement (new ID; every user must accept again)."
    }
  }
}
