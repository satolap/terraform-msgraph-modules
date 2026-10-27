locals {
  # The built-in kinds of object names that kinds can give a template. Each
  # kind mirrors the validation of the verified module that takes the name, or
  # Microsoft Learn where that module sets no limit; the README lists the source
  # of each. max_length counts characters as Terraform's length does, pattern is
  # an RE2 expression that the whole name must match, and null sets no rule.
  # Every kind also rejects a blank name, as the verified modules do.
  builtin_kinds = {
    access_package            = { max_length = 90, pattern = null }
    access_review             = { max_length = null, pattern = null }
    administrative_unit       = { max_length = 256, pattern = null }
    application               = { max_length = 120, pattern = null }
    assignment_policy         = { max_length = 90, pattern = null }
    authentication_strength   = { max_length = null, pattern = null }
    catalog                   = { max_length = 90, pattern = null }
    conditional_access_policy = { max_length = null, pattern = null }
    connected_organization    = { max_length = null, pattern = null }
    custom_extension          = { max_length = null, pattern = null }
    custom_task_extension     = { max_length = null, pattern = null }
    group                     = { max_length = 256, pattern = null }
    group_mail_nickname       = { max_length = 64, pattern = "^[^@()\\\\\\[\\]\";:<>, \\x{80}-\\x{10FFFF}]+$" }
    lifecycle_workflow        = { max_length = null, pattern = null }
    named_location            = { max_length = null, pattern = null }
    role_definition           = { max_length = null, pattern = null }
    terms_of_use_agreement    = { max_length = null, pattern = null }
    user                      = { max_length = 256, pattern = null }
    user_mail_nickname        = { max_length = 64, pattern = null }
  }
}
