# The module makes no request and has no provider, so every run is a plan: the
# names are known at plan time when the tokens are.

variables {
  templates = {
    catalog       = "{organization}"
    access_group  = "{organization|ascii|alnum}-access"
    access_unit   = "Partners/{organization}/Groups"
    partner_title = "{organization|upper} partner"
  }
  tokens = {
    organization = "Contoso Ltd"
  }
}

run "substitutes_tokens_and_applies_filters" {
  command = plan

  assert {
    condition = output.names == {
      catalog       = "Contoso Ltd"
      access_group  = "ContosoLtd-access"
      access_unit   = "Partners/Contoso Ltd/Groups"
      partner_title = "CONTOSO LTD partner"
    }
    error_message = "Each template must render with its token values and filters."
  }
}

run "ascii_keeps_base_letters_and_drops_other_characters" {
  command = plan

  variables {
    templates = {
      plain   = "{organization|ascii}"
      compact = "{organization|ascii|alnum}"
      group   = "{organization|ascii|alnum}-G-Guests"
    }
    tokens = {
      organization = "Zürich Ærø & Søn Łódź ß Ș 東京"
    }
  }

  assert {
    condition = output.names == {
      plain   = "Zurich AEro & Son Lodz ss S "
      compact = "ZurichAEroSonLodzssS"
      group   = "ZurichAEroSonLodzssS-G-Guests"
    }
    error_message = "ascii must map letters with diacritics to their base letters, spell out ligatures and drop characters it cannot map."
  }
}

run "combining_marks_are_normalized_before_the_table" {
  command = plan

  variables {
    templates = { name = "{organization|ascii}" }
    tokens    = { organization = "Zürich" }
  }

  assert {
    condition     = output.names.name == "Zurich"
    error_message = "A base letter followed by a combining mark must arrive precomposed (NFC) and map like the precomposed letter."
  }
}

run "alnum_keeps_letters_and_digits_of_every_script" {
  command = plan

  variables {
    templates = { name = "{organization|alnum}" }
    tokens    = { organization = "Zürich-AG 1 / 東京" }
  }

  assert {
    condition     = output.names.name == "ZürichAG1東京"
    error_message = "alnum must keep Unicode letters and digits and drop everything else."
  }
}

run "remaining_filters" {
  command = plan

  variables {
    templates = {
      lower   = "{organization|lower}"
      upper   = "{organization|upper}"
      trim    = "[{organization|trim}]"
      nospace = "{organization|nospace}"
      slug    = "{organization|slug}"
      chain   = "{organization|trim|ascii|slug|upper}"
    }
    tokens = {
      organization = "  Fabrikam Café & Co.  "
    }
  }

  assert {
    condition = output.names == {
      lower   = "  fabrikam café & co.  "
      upper   = "  FABRIKAM CAFÉ & CO.  "
      trim    = "Fabrikam Café & Co."
      nospace = "FabrikamCafé&Co."
      slug    = "fabrikam-café-co"
      chain   = "FABRIKAM-CAFE-CO"
    }
    error_message = "lower, upper, trim, nospace (including no-break spaces) and slug must transform the value, and filters must run from left to right."
  }
}

# The examples in the README's filter table and usage section.
run "readme_examples" {
  command = plan

  variables {
    templates = {
      lower           = "{organization|lower}"
      upper           = "{organization|upper}"
      trim            = "{organization|trim}"
      ascii           = "{organization|ascii}"
      alnum           = "{organization|alnum}"
      nospace         = "{organization|nospace}"
      slug            = "{organization|slug}"
      ascii_alnum     = "{organization|ascii|alnum}"
      ascii_slug      = "{organization|ascii|slug}"
      guests_group    = "{company|ascii|alnum}-guests"
      guests_nickname = "{company|ascii|slug}-guests"
    }
    tokens = {
      organization = "Zürich Søn & Co."
      company      = "Fabrikam Café"
    }
  }

  assert {
    condition = output.names == {
      lower           = "zürich søn & co."
      upper           = "ZÜRICH SØN & CO."
      trim            = "Zürich Søn & Co."
      ascii           = "Zurich Son & Co."
      alnum           = "ZürichSønCo"
      nospace         = "ZürichSøn&Co."
      slug            = "zürich-søn-co"
      ascii_alnum     = "ZurichSonCo"
      ascii_slug      = "zurich-son-co"
      guests_group    = "FabrikamCafe-guests"
      guests_nickname = "fabrikam-cafe-guests"
    }
    error_message = "The README examples must match what the module renders."
  }
}

run "optional_segments_drop_when_a_placeholder_is_empty" {
  command = plan

  variables {
    templates = {
      key_vault       = "kv-{company|lower}-{region}[-{workload}][-{subresource}][-{environment}]-{instance}"
      storage_account = "st{company|lower}{region}[{workload}][{subresource}][{environment}]{instance}"
      both_or_none    = "app[-{workload}-{environment}]"
    }
    tokens = {
      company     = "CT01"
      region      = "weu"
      workload    = "data"
      subresource = ""
      environment = null
      instance    = "001"
    }
  }

  assert {
    condition = output.names == {
      key_vault       = "kv-ct01-weu-data-001"
      storage_account = "stct01weudata001"
      both_or_none    = "app"
    }
    error_message = "An optional segment must render only when every placeholder in it is non-empty, and a null token counts as empty."
  }
}

run "an_optional_segment_is_left_out_when_a_filter_empties_it" {
  command = plan

  variables {
    templates = { name = "partner[-{suffix|alnum}]" }
    tokens    = { suffix = " - " }
  }

  assert {
    condition     = output.names.name == "partner"
    error_message = "Emptiness must be judged after the filters."
  }
}

run "built_in_tokens_insert_reserved_characters" {
  command = plan

  variables {
    templates = { name = "{lbracket}External{rbracket} {organization} {lbrace}{rbrace}" }
  }

  assert {
    condition     = output.names.name == "[External] Contoso Ltd {}"
    error_message = "lbrace, rbrace, lbracket and rbracket must insert the characters that the syntax reserves."
  }
}

run "transliterations_change_the_ascii_table" {
  command = plan

  variables {
    templates = { name = "{organization|ascii}" }
    tokens    = { organization = "Müller Österreich Straße" }
    transliterations = {
      "ü" = "ue"
      "Ö" = "Oe"
      "ß" = ""
    }
  }

  assert {
    condition     = output.names.name == "Mueller Oesterreich Strae"
    error_message = "transliterations must be merged over the built-in table, and an empty replacement must drop the character."
  }
}

run "token_rules_that_hold_pass" {
  command = plan

  variables {
    templates = { key_vault = "kv-{company|lower}-{region}[-{environment}]-{instance}" }
    tokens = {
      company     = "CT01"
      region      = "weu"
      environment = ""
      instance    = "001"
    }
    token_rules = {
      company     = { required = true }
      region      = { required = true, allowed_values = ["weu", "neu"] }
      environment = { allowed_values = ["d", "q", "p"], pattern = "^[dqp]$" }
      instance    = { pattern = "^[0-9]{3}$" }
    }
  }

  assert {
    condition     = output.names.key_vault == "kv-ct01-weu-001"
    error_message = "Tokens within their rules must render, and an empty value must pass allowed_values and pattern when it is not required."
  }
}

# The contingency form of a Conditional Access policy name: Microsoft Learn's
# naming standard starts emergency policies with "ENABLE IN EMERGENCY".
run "conditional_access_names_with_and_without_the_emergency_prefix" {
  command = plan

  variables {
    templates = {
      normal    = "[{emergency} - ]CA{sequence}-{apps}-{response}-{users}"
      emergency = "[{contingency} - ]CA{sequence}-{apps}-{response}-{users}"
    }
    tokens = {
      emergency   = ""
      contingency = "ENABLE IN EMERGENCY"
      sequence    = "001"
      apps        = "AllApps"
      response    = "BlockLegacyAuth"
      users       = "AllUsers"
    }
  }

  assert {
    condition = output.names == {
      normal    = "CA001-AllApps-BlockLegacyAuth-AllUsers"
      emergency = "ENABLE IN EMERGENCY - CA001-AllApps-BlockLegacyAuth-AllUsers"
    }
    error_message = "An optional prefix segment must render only when its token is set."
  }
}

run "constraints_that_hold_pass" {
  command = plan

  variables {
    constraints = {
      access_group = { max_length = 17, pattern = "^[A-Za-z0-9-]+$" }
      catalog      = { max_length = 90 }
    }
  }

  assert {
    condition     = output.names.access_group == "ContosoLtd-access"
    error_message = "Names within their constraints must render unchanged."
  }
}

run "no_templates_render_no_names" {
  command = plan

  variables {
    templates = {}
  }

  assert {
    condition     = output.names == {}
    error_message = "An empty templates map must render an empty names map."
  }
}

run "literal_text_needs_no_tokens" {
  command = plan

  variables {
    templates = { policy = "Partner requests | approval required" }
    tokens    = {}
  }

  assert {
    condition     = output.names.policy == "Partner requests | approval required"
    error_message = "A template without placeholders must render as written, a | in literal text included."
  }
}

# Failures of the rendered names: the preconditions on the names output.

run "missing_token_fails" {
  command = plan

  variables {
    templates = { name = "{organization}-{unit}" }
  }

  expect_failures = [output.names]
}

run "empty_required_placeholder_fails" {
  command = plan

  variables {
    tokens = { organization = "" }
  }

  expect_failures = [output.names]
}

run "required_placeholder_emptied_by_a_filter_fails" {
  command = plan

  variables {
    templates = { name = "{organization|ascii|alnum}-guests" }
    tokens    = { organization = "東京" }
  }

  expect_failures = [output.names]
}

run "empty_name_fails" {
  command = plan

  variables {
    templates = { name = "[{suffix}]" }
    tokens    = { suffix = "" }
  }

  expect_failures = [output.names]
}

run "constraints_for_an_unknown_template_fail" {
  command = plan

  variables {
    constraints = { owners_group = { max_length = 64 } }
  }

  expect_failures = [output.names]
}

run "too_long_fails" {
  command = plan

  variables {
    constraints = { access_group = { max_length = 16 } }
  }

  expect_failures = [output.names]
}

run "pattern_mismatch_fails" {
  command = plan

  variables {
    constraints = { catalog = { pattern = "^[A-Za-z]+$" } }
  }

  expect_failures = [output.names]
}

run "missing_required_token_fails" {
  command = plan

  variables {
    token_rules = { environment = { required = true } }
  }

  expect_failures = [output.names]
}

run "empty_required_token_fails" {
  command = plan

  variables {
    tokens      = { organization = "Contoso Ltd", environment = "" }
    token_rules = { environment = { required = true } }
  }

  expect_failures = [output.names]
}

run "disallowed_token_value_fails" {
  command = plan

  variables {
    tokens      = { organization = "Contoso Ltd", environment = "x" }
    token_rules = { environment = { allowed_values = ["d", "q", "p"] } }
  }

  expect_failures = [output.names]
}

run "token_pattern_mismatch_fails" {
  command = plan

  variables {
    tokens      = { organization = "Contoso Ltd", instance = "1" }
    token_rules = { instance = { pattern = "^[0-9]{3}$" } }
  }

  expect_failures = [output.names]
}

# Failures of the inputs: the variable validations.

run "token_rule_key_must_be_an_identifier" {
  command = plan

  variables {
    token_rules = { "Env" = { required = true } }
  }

  expect_failures = [var.token_rules]
}

run "token_rule_allowed_values_must_not_be_empty" {
  command = plan

  variables {
    token_rules = { environment = { allowed_values = [] } }
  }

  expect_failures = [var.token_rules]
}

run "token_rule_pattern_must_compile" {
  command = plan

  variables {
    token_rules = { environment = { pattern = "([" } }
  }

  expect_failures = [var.token_rules]
}

run "template_key_must_be_an_identifier" {
  command = plan

  variables {
    templates = { "Access-Group" = "{organization}" }
  }

  expect_failures = [var.templates]
}

run "unbalanced_brace_fails" {
  command = plan

  variables {
    templates = { name = "{organization" }
  }

  expect_failures = [var.templates]
}

run "nested_optional_segment_fails" {
  command = plan

  variables {
    templates = { name = "a[-{organization}[-{organization}]]" }
  }

  expect_failures = [var.templates]
}

run "upper_case_token_name_fails" {
  command = plan

  variables {
    templates = { name = "{Organization}" }
  }

  expect_failures = [var.templates]
}

run "empty_template_fails" {
  command = plan

  variables {
    templates = { name = "" }
  }

  expect_failures = [var.templates]
}

run "unknown_filter_fails" {
  command = plan

  variables {
    templates = { name = "{organization|title}" }
  }

  expect_failures = [var.templates]
}

run "five_filters_fail" {
  command = plan

  variables {
    templates = { name = "{organization|trim|ascii|alnum|lower|upper}" }
  }

  expect_failures = [var.templates]
}

run "optional_segment_without_placeholder_fails" {
  command = plan

  variables {
    templates = { name = "{organization}[-guests]" }
  }

  expect_failures = [var.templates]
}

run "token_key_must_be_an_identifier" {
  command = plan

  variables {
    tokens = { organization = "Contoso", "Org Unit" = "x" }
  }

  expect_failures = [var.tokens]
}

run "reserved_token_fails" {
  command = plan

  variables {
    tokens = { organization = "Contoso", lbrace = "(" }
  }

  expect_failures = [var.tokens]
}

run "max_length_must_be_a_whole_number" {
  command = plan

  variables {
    constraints = { catalog = { max_length = 0 } }
  }

  expect_failures = [var.constraints]
}

run "pattern_must_compile" {
  command = plan

  variables {
    constraints = { catalog = { pattern = "([" } }
  }

  expect_failures = [var.constraints]
}

run "transliteration_key_must_be_one_character" {
  command = plan

  variables {
    transliterations = { "ae" = "a" }
  }

  expect_failures = [var.transliterations]
}

# Terraform's length counts this skin-tone emoji as one character, but it is two
# code points, and the ascii filter looks up one code point at a time.
run "transliteration_key_must_be_one_code_point" {
  command = plan

  variables {
    transliterations = { "👍🏽" = "ok" }
  }

  expect_failures = [var.transliterations]
}

run "transliteration_value_must_be_ascii" {
  command = plan

  variables {
    transliterations = { "ü" = "ü" }
  }

  expect_failures = [var.transliterations]
}

# The patterns output: every rendered name matches the pattern of its template,
# and a pattern describes the convention, so other values of its tokens match too.

run "patterns_follow_the_filters" {
  command = plan

  variables {
    templates = {
      plain             = "Partners/{organization}"
      alnum             = "{organization|alnum}-guests"
      ascii_alnum       = "{organization|ascii|alnum}"
      ascii_alnum_lower = "{organization|ascii|alnum|lower}"
      slug              = "{organization|slug}"
      ascii_slug        = "{organization|ascii|slug}-guests"
      slug_ascii        = "{organization|slug|ascii}"
      nospace           = "{organization|nospace}"
      lower             = "{organization|lower}"
      upper             = "{organization|upper}"
      ascii             = "{organization|ascii}"
      ascii_upper       = "{organization|ascii|upper}"
      upper_ascii       = "{organization|upper|ascii}"
      trim              = "{organization|trim}"
    }
    tokens = {
      organization = "Zürich Søn & Co. 東京"
    }
  }

  assert {
    condition = output.patterns == {
      plain             = "(?s)^Partners/.+$"
      alnum             = "^[\\p{L}\\p{N}]+-guests$"
      ascii_alnum       = "^[A-Za-z0-9]+$"
      ascii_alnum_lower = "^[a-z0-9]+$"
      slug              = "^[\\p{L}\\p{N}]+(?:-[\\p{L}\\p{N}]+)*$"
      ascii_slug        = "^[a-z0-9]+(?:-[a-z0-9]+)*-guests$"
      slug_ascii        = "^[a-z0-9-]+$"
      nospace           = "^[^\\s\\p{Z}]+$"
      lower             = "^[^A-Z]+$"
      upper             = "^[^a-z]+$"
      ascii             = "^[^\\x{80}-\\x{10FFFF}]+$"
      ascii_upper       = "^[^a-z\\x{80}-\\x{10FFFF}]+$"
      upper_ascii       = "^[^\\x{80}-\\x{10FFFF}]+$"
      trim              = "(?s)^.+$"
    }
    error_message = "Each placeholder must become a run of the characters that its filters leave, and slug must keep its shape only when ascii does not run after it."
  }

  assert {
    condition     = output.names.slug_ascii == "zurich-son-co-"
    error_message = "ascii after slug can leave a trailing hyphen, which is why its pattern drops the slug shape."
  }

  assert {
    condition     = alltrue([for name, value in output.names : can(regex(output.patterns[name], value))])
    error_message = "Every rendered name must match its own pattern."
  }
}

run "patterns_keep_segments_allowed_values_and_literal_text" {
  command = plan

  variables {
    templates = {
      key_vault = "kv-{company|ascii|alnum|lower}-{region}[-{workload|slug}][-{environment|upper}]-{instance|ascii|alnum}"
      literal   = "{lbracket}{code}{rbracket} a.b+c (x)? $1 ^|\\"
    }
    tokens = {
      company     = "CT01"
      region      = "weu"
      workload    = ""
      environment = "p"
      instance    = "001"
      code        = "B"
    }
    token_rules = {
      region      = { allowed_values = ["weu", "neu"] }
      environment = { allowed_values = ["d", "p"] }
      code        = { allowed_values = ["A", "B", "B"] }
    }
  }

  assert {
    condition = output.patterns == {
      key_vault = "^kv-[a-z0-9]+-(?:weu|neu)(?:-[\\p{L}\\p{N}]+(?:-[\\p{L}\\p{N}]+)*)?(?:-(?:D|P))?-[A-Za-z0-9]+$"
      literal   = "^\\[(?:A|B)\\] a\\.b\\+c \\(x\\)\\? \\$1 \\^\\|\\\\$"
    }
    error_message = "Optional segments must become optional groups, allowed values an alternation after their filters, and literal text, built-in tokens included, must be escaped."
  }

  assert {
    condition     = output.names == { key_vault = "kv-ct01-weu-P-001", literal = "[B] a.b+c (x)? $1 ^|\\" }
    error_message = "The names must render as before."
  }

  assert {
    condition     = alltrue([for name, value in output.names : can(regex(output.patterns[name], value))])
    error_message = "Every rendered name must match its own pattern."
  }
}

run "patterns_match_other_values_of_the_convention" {
  command = plan

  variables {
    templates = {
      key_vault = "kv-{company|ascii|alnum|lower}-{region}[-{workload|slug}][-{environment|upper}]-{instance|ascii|alnum}"
    }
    tokens = {
      company     = "Fabrikam Café"
      region      = "neu"
      workload    = "Data Lake"
      environment = ""
      instance    = "002"
    }
    token_rules = {
      region      = { allowed_values = ["weu", "neu"] }
      environment = { allowed_values = ["d", "p"] }
    }
  }

  assert {
    condition     = output.patterns.key_vault == "^kv-[a-z0-9]+-(?:weu|neu)(?:-[\\p{L}\\p{N}]+(?:-[\\p{L}\\p{N}]+)*)?(?:-(?:D|P))?-[A-Za-z0-9]+$"
    error_message = "The pattern must not depend on the token values."
  }

  assert {
    condition     = output.names.key_vault == "kv-fabrikamcafe-neu-data-lake-002" && can(regex(output.patterns.key_vault, output.names.key_vault))
    error_message = "A name with other values, a filled workload and no environment must match the same pattern."
  }
}

run "patterns_follow_custom_transliterations" {
  command = plan

  variables {
    templates = {
      alnum_ascii = "{name|alnum|ascii}"
      slug_ascii  = "{name|slug|ascii}"
      lower_ascii = "{name|lower|ascii}"
      ascii_lower = "{name|ascii|lower}"
    }
    tokens = {
      name = "Bär König"
    }
    # A replacement with a space or an upper case letter breaks what alnum,
    # slug and lower guaranteed before ascii ran.
    transliterations = {
      "ä" = "a e"
      "ö" = "O"
    }
  }

  assert {
    condition = output.patterns == {
      alnum_ascii = "^[^\\x{80}-\\x{10FFFF}]+$"
      slug_ascii  = "^[^\\x{80}-\\x{10FFFF}]+$"
      lower_ascii = "^[^\\x{80}-\\x{10FFFF}]+$"
      ascii_lower = "^[^A-Z\\x{80}-\\x{10FFFF}]+$"
    }
    error_message = "ascii must keep an earlier trait only when the transliteration table cannot break it."
  }

  assert {
    condition     = output.names == { alnum_ascii = "Ba erKOnig", slug_ascii = "ba er-kOnig", lower_ascii = "ba er kOnig", ascii_lower = "ba er konig" }
    error_message = "The custom table must apply."
  }

  assert {
    condition     = alltrue([for name, value in output.names : can(regex(output.patterns[name], value))])
    error_message = "Every rendered name must match its own pattern."
  }
}

run "readme_patterns_render_as_documented" {
  command = plan

  variables {
    templates = {
      catalog         = "Partners/{organization}"
      guests_group    = "{organization|ascii|alnum}-guests"
      guests_nickname = "{organization|ascii|slug}-guests"
      key_vault       = "kv-{company|lower}-{region}[-{workload}]-{instance}"
    }
    tokens = {
      organization = "Fabrikam Café"
      company      = "CT01"
      region       = "weu"
      workload     = ""
      instance     = "001"
    }
    token_rules = {
      region = { allowed_values = ["weu", "neu"] }
    }
  }

  assert {
    condition = output.patterns == {
      catalog         = "(?s)^Partners/.+$"
      guests_group    = "^[A-Za-z0-9]+-guests$"
      guests_nickname = "^[a-z0-9]+(?:-[a-z0-9]+)*-guests$"
      key_vault       = "(?s)^kv-[^A-Z]+-(?:weu|neu)(?:-.+)?-.+$"
    }
    error_message = "The patterns must be the ones that the README documents."
  }

  assert {
    condition     = output.names.guests_group == "FabrikamCafe-guests" && output.names.guests_nickname == "fabrikam-cafe-guests"
    error_message = "The names must be the ones that the README usage example documents."
  }

  assert {
    condition     = alltrue([for name, value in output.names : can(regex(output.patterns[name], value))])
    error_message = "Every rendered name must match its own pattern."
  }
}

run "patterns_match_nothing_for_allowed_values_that_render_empty" {
  command = plan

  variables {
    templates   = { name = "[{city|ascii}-]x" }
    tokens      = { city = "東京" }
    token_rules = { city = { allowed_values = ["東京"] } }
  }

  assert {
    condition     = output.patterns.name == "^(?:[^\\x00-\\x{10FFFF}]-)?x$"
    error_message = "A token whose allowed values all render empty can never render its segment."
  }

  assert {
    condition     = output.names.name == "x" && can(regex(output.patterns.name, output.names.name))
    error_message = "The name without the segment must match."
  }
}

# The kinds input: each kind's limits, as its verified module or Microsoft Learn
# sets them. A name at the limit passes, and one character more fails.

run "kinds_accept_names_at_their_limits" {
  command = plan

  variables {
    templates = {
      access_package            = "{n90}"
      access_review             = "{n300}"
      administrative_unit       = "{n256}"
      application               = "{n120}"
      assignment_policy         = "{n90}"
      catalog                   = "{n90}"
      conditional_access_policy = "{n300}"
      connected_organization    = "{n300}"
      custom_extension          = "{n300}"
      custom_task_extension     = "{n300}"
      group                     = "{n256}"
      group_mail_nickname       = "{n64}"
      lifecycle_workflow        = "{n300}"
      named_location            = "{n300}"
      terms_of_use_agreement    = "{n300}"
      user                      = "{n256}"
      user_mail_nickname        = "{n64}"
    }
    tokens = {
      n64  = format("%064d", 0)
      n90  = format("%090d", 0)
      n120 = format("%0120d", 0)
      n256 = format("%0256d", 0)
      n300 = format("%0300d", 0)
    }
    kinds = {
      access_package            = "access_package"
      access_review             = "access_review"
      administrative_unit       = "administrative_unit"
      application               = "application"
      assignment_policy         = "assignment_policy"
      catalog                   = "catalog"
      conditional_access_policy = "conditional_access_policy"
      connected_organization    = "connected_organization"
      custom_extension          = "custom_extension"
      custom_task_extension     = "custom_task_extension"
      group                     = "group"
      group_mail_nickname       = "group_mail_nickname"
      lifecycle_workflow        = "lifecycle_workflow"
      named_location            = "named_location"
      terms_of_use_agreement    = "terms_of_use_agreement"
      user                      = "user"
      user_mail_nickname        = "user_mail_nickname"
    }
  }

  assert {
    condition     = length(output.names.catalog) == 90 && length(output.names.group_mail_nickname) == 64 && length(output.names.named_location) == 300
    error_message = "Names at their kind's limit, and long names of kinds without one, must pass."
  }
}

run "kind_access_package_rejects_91_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%091d", 0) }
    kinds     = { name = "access_package" }
  }

  expect_failures = [var.kinds]
}

run "kind_administrative_unit_rejects_257_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%0257d", 0) }
    kinds     = { name = "administrative_unit" }
  }

  expect_failures = [var.kinds]
}

run "kind_application_rejects_121_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%0121d", 0) }
    kinds     = { name = "application" }
  }

  expect_failures = [var.kinds]
}

run "kind_assignment_policy_rejects_91_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%091d", 0) }
    kinds     = { name = "assignment_policy" }
  }

  expect_failures = [var.kinds]
}

run "kind_catalog_rejects_91_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%091d", 0) }
    kinds     = { name = "catalog" }
  }

  expect_failures = [var.kinds]
}

run "kind_group_rejects_257_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%0257d", 0) }
    kinds     = { name = "group" }
  }

  expect_failures = [var.kinds]
}

run "kind_group_mail_nickname_rejects_65_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%065d", 0) }
    kinds     = { name = "group_mail_nickname" }
  }

  expect_failures = [var.kinds]
}

run "kind_user_rejects_257_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%0257d", 0) }
    kinds     = { name = "user" }
  }

  expect_failures = [var.kinds]
}

run "kind_user_mail_nickname_rejects_65_characters" {
  command = plan

  variables {
    templates = { name = "{n}" }
    tokens    = { n = format("%065d", 0) }
    kinds     = { name = "user_mail_nickname" }
  }

  expect_failures = [var.kinds]
}

run "kind_group_mail_nickname_rejects_characters_outside_its_set" {
  command = plan

  variables {
    templates = { name = "{organization}-guests" }
    tokens    = { organization = "Zürich" }
    kinds     = { name = "group_mail_nickname" }
  }

  expect_failures = [var.kinds]
}

run "kind_rejects_a_blank_name" {
  command = plan

  variables {
    templates = { name = "{organization}" }
    tokens    = { organization = "   " }
    kinds     = { name = "connected_organization" }
  }

  expect_failures = [var.kinds]
}

run "kinds_must_name_existing_templates" {
  command = plan

  variables {
    kinds = { missing = "group" }
  }

  expect_failures = [var.kinds]
}

run "kinds_must_be_built_in" {
  command = plan

  variables {
    kinds = { catalog = "team" }
  }

  expect_failures = [var.kinds]
}
