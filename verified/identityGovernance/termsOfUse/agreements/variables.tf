variable "displayName" {
  description = "Display name of the agreement, used for internal tracking: Learn says it is not shown to end users (each file's displayName is). It can be updated in place."
  type        = string
  nullable    = false

  validation {
    condition     = try(length(trimspace(var.displayName)) > 0, false)
    error_message = "displayName must not be empty."
  }
}

variable "isViewingBeforeAcceptanceRequired" {
  description = "Whether a user has to expand and view the agreement before accepting it (isViewingBeforeAcceptanceRequired). Learn lists it among the properties required to create an agreement and documents it for update, so it is always sent and changes in place. Changing it does not by itself ask users to accept again; Learn documents no such effect."
  type        = bool
  default     = false
  nullable    = false
}

variable "default_file" {
  description = <<-EOT
    The default localized PDF of the agreement, created together with the agreement
    (files[0] of the create request, with isDefault true). Learn documents no way to update or to
    delete a file of an existing agreement, and describes isDefault as read-only, so this file is
    fixed when the agreement is created: a later change of any of its values is refused at plan
    time (see "Changing files" in the README) and never reaches Graph.

    - language: language of the file, "languagecode2-country/regioncode2" or a BCP-47 tag, for
      example "en" or "en-US" (Learn). Compared case-insensitively with the other files.
    - fileName: name of the file, for example "TOU.pdf".
    - displayName: localized name that end users see; null leaves it out of the request.
    - content_base64: the PDF, base64 encoded, for example filebase64("terms.pdf"). It must start
      with the PDF header ("%PDF-") and decode to at most 2 MiB. The size limit is this module's
      own, conservative choice: Learn states none and it is not verified against Graph's request limit. The content is sent to Graph, is kept in the Terraform
      state (with the request body) and shows in a plan as a sensitive value; only a SHA-256 of the
      base64 text is exposed as an output.
  EOT
  type = object({
    language       = string
    fileName       = string
    displayName    = optional(string)
    display_name   = optional(any)
    content_base64 = string
  })
  nullable = false

  validation {
    condition     = can(regex("^[A-Za-z]{2,3}(-[A-Za-z0-9]{2,8}){0,3}$", try(var.default_file.language, "")))
    error_message = "default_file.language must look like \"en\" or \"en-US\": a two or three letter language code with optional country or region and BCP-47 subtags separated by hyphens."
  }

  validation {
    condition     = try(trimspace(var.default_file.fileName) != "" && length(var.default_file.fileName) <= 255 && !can(regex("[/\\\\\\p{Cc}]", var.default_file.fileName)), false)
    error_message = "default_file.fileName must not be empty, must be at most 255 characters and must not contain a path separator or a control character."
  }

  validation {
    condition     = try(var.default_file.displayName == null ? true : trimspace(var.default_file.displayName) != "", false)
    error_message = "default_file.displayName must be null or not empty."
  }

  validation {
    condition     = can(regex("^[A-Za-z0-9+/]+={0,2}$", try(var.default_file.content_base64, ""))) && try(length(var.default_file.content_base64) % 4 == 0, false)
    error_message = "default_file.content_base64 must be standard base64 text (A-Z, a-z, 0-9, + and /, padded with =), such as the result of filebase64()."
  }

  validation {
    condition     = try(startswith(var.default_file.content_base64, "JVBERi0"), false)
    error_message = "default_file.content_base64 must hold a PDF: the decoded content has to start with %PDF-."
  }

  validation {
    condition     = try(floor(length(var.default_file.content_base64) / 4) * 3 - (length(var.default_file.content_base64) - length(trimsuffix(trimsuffix(var.default_file.content_base64, "="), "="))) <= 2097152, false)
    error_message = "default_file.content_base64 must decode to at most 2 MiB (this module's conservative limit; Learn states none and it is unverified against Graph)."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = !can(regex("\"(display_name)\":[^n]", jsonencode(var.default_file)))
    error_message = "default_file no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (display_name -> displayName). An old name that is silently dropped would fall back to its default."
  }
}

variable "additional_files" {
  description = <<-EOT
    Further localized PDFs, keyed by a name of your choice. Each is added to the agreement once,
    with the documented "create agreementFileLocalization" call (POST agreements/{id}/files), and
    the request is never sent again on an in-place update. Learn documents no update and no delete
    of a file, so a key can be added at any time, but changing a value of a key that was applied is
    refused at plan time, and removing a key only stops Terraform from tracking the file: the file
    stays in the agreement (see "Changing files" in the README).

    - language, fileName, displayName, content_base64: as in default_file. The language must
      differ (case-insensitively) from every other file's.
    - isMajorVersion: Learn says a major version update invalidates the agreement's acceptances
      for that language. Set it true only when the file has to be accepted again; for a new
      language it is normally false.

    The default file is the one in default_file: isDefault is sent false for these files.
  EOT
  type = map(object({
    language         = string
    fileName         = string
    displayName      = optional(string)
    display_name     = optional(any)
    content_base64   = string
    isMajorVersion   = optional(bool, false)
    is_major_version = optional(any)
  }))
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for key, f in var.additional_files : can(regex("^[a-z][a-z0-9_]{0,62}$", key))])
    error_message = "additional_files keys must start with a lower case letter and contain only lower case letters, digits and underscores (at most 63 characters)."
  }

  validation {
    condition     = alltrue([for key, f in var.additional_files : can(regex("^[A-Za-z]{2,3}(-[A-Za-z0-9]{2,8}){0,3}$", try(f.language, "")))])
    error_message = "Every additional_files language must look like \"fr\" or \"fr-FR\": a two or three letter language code with optional country or region and BCP-47 subtags separated by hyphens."
  }

  validation {
    condition = alltrue([
      for key, f in var.additional_files :
      try(trimspace(f.fileName) != "" && length(f.fileName) <= 255 && !can(regex("[/\\\\\\p{Cc}]", f.fileName)), false)
    ])
    error_message = "Every additional_files fileName must not be empty, must be at most 255 characters and must not contain a path separator or a control character."
  }

  validation {
    condition     = alltrue([for key, f in var.additional_files : try(f.displayName == null ? true : trimspace(f.displayName) != "", false)])
    error_message = "Every additional_files displayName must be null or not empty."
  }

  validation {
    condition = alltrue([
      for key, f in var.additional_files :
      can(regex("^[A-Za-z0-9+/]+={0,2}$", try(f.content_base64, ""))) && try(length(f.content_base64) % 4 == 0, false) && try(startswith(f.content_base64, "JVBERi0"), false)
    ])
    error_message = "Every additional_files content_base64 must be standard base64 text of a PDF (the decoded content starts with %PDF-), such as the result of filebase64()."
  }

  validation {
    condition = alltrue([
      for key, f in var.additional_files :
      try(floor(length(f.content_base64) / 4) * 3 - (length(f.content_base64) - length(trimsuffix(trimsuffix(f.content_base64, "="), "="))) <= 2097152, false)
    ])
    error_message = "Every additional_files content_base64 must decode to at most 2 MiB (this module's conservative limit; Learn states none and it is unverified against Graph)."
  }

  # legacy-names guard: v4.0.0 spelled these attributes in snake_case; the object type would otherwise
  # drop them and fall back to the default.
  validation {
    condition     = alltrue([for f in values(var.additional_files) : try(f.display_name == null && f.is_major_version == null, false)])
    error_message = "additional_files no longer accepts the v4.0.0 snake_case attribute names; rename them to Graph's names (display_name -> displayName, is_major_version -> isMajorVersion). An old name that is silently dropped would fall back to its default."
  }
}

variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "licence_check" {
  description = "Opt-in plan-time licence check. When true, the plan reads the tenant's subscribedSkus (GET /subscribedSkus) and fails unless a subscription with enabled prepaid units lists Microsoft Entra ID P1 (a P2 subscription also qualifies). It needs Organization.Read.All or LicenseAssignment.Read.All, only while it is true. When false, the default, nothing is read and no extra permission is needed."
  type        = bool
  default     = false
  nullable    = false
}
