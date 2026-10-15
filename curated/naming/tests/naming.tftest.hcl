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
