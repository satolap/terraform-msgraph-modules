locals {
  # The four characters that the template syntax reserves, inserted literally.
  builtin_tokens = {
    lbrace   = "{"
    rbrace   = "}"
    lbracket = "["
    rbracket = "]"
  }

  tokens           = merge({ for name, value in var.tokens : name => value == null ? "" : value }, local.builtin_tokens)
  transliterations = merge(local.default_transliterations, var.transliterations)

  # A template splits into pieces: an optional segment (capture 1 holds the text
  # between the brackets) or a run of text outside brackets (capture 2). A piece
  # splits into parts: a placeholder (capture 1 is the token name, capture 2 the
  # filters, each with its leading |) or literal text (capture 3). Terraform
  # returns null for a capture group that took no part in the match. The
  # templates validations reject anything these patterns would misread.
  pieces = {
    for name, template in var.templates : name => [
      for piece in regexall("\\[([^\\[\\]]*)\\]|([^\\[\\]]+)", template) : {
        optional = piece[0] != null
        parts = [
          for part in regexall("\\{([^{}|]*)((?:\\|[^{}|]*)*)\\}|([^{}]+)", piece[0] != null ? piece[0] : piece[1]) : {
            token   = part[0]
            filters = part[0] == null ? [] : compact(split("|", coalesce(part[1], "|")))
            literal = part[2]
          }
        ]
      }
    ]
  }

  # Every placeholder of every template, keyed "<template>/<piece>/<part>".
  placeholders = merge({}, flatten([
    for name, pieces in local.pieces : [
      for i, piece in pieces : {
        for j, part in piece.parts : "${name}/${i}/${j}" => {
          template = name
          token    = part.token
          optional = piece.optional
          value    = lookup(local.tokens, part.token, "")
          filters  = part.filters
        } if part.token != null
      }
    ]
  ])...)

  # The filters run from left to right, one step per position; the templates
  # validations allow at most four. A placeholder with fewer filters keeps its
  # value through the remaining steps. Each step computes every filter and picks
  # the one the placeholder names.
  step_1 = {
    for key, placeholder in local.placeholders : key => length(placeholder.filters) < 1 ? placeholder.value : {
      lower   = lower(placeholder.value)
      upper   = upper(placeholder.value)
      trim    = trimspace(placeholder.value)
      ascii   = replace(join("", [for character in split("", placeholder.value) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(placeholder.value, "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(placeholder.value, "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(placeholder.value), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[placeholder.filters[0]]
  }

  step_2 = {
    for key, placeholder in local.placeholders : key => length(placeholder.filters) < 2 ? local.step_1[key] : {
      lower   = lower(local.step_1[key])
      upper   = upper(local.step_1[key])
      trim    = trimspace(local.step_1[key])
      ascii   = replace(join("", [for character in split("", local.step_1[key]) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(local.step_1[key], "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(local.step_1[key], "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(local.step_1[key]), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[placeholder.filters[1]]
  }

  step_3 = {
    for key, placeholder in local.placeholders : key => length(placeholder.filters) < 3 ? local.step_2[key] : {
      lower   = lower(local.step_2[key])
      upper   = upper(local.step_2[key])
      trim    = trimspace(local.step_2[key])
      ascii   = replace(join("", [for character in split("", local.step_2[key]) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(local.step_2[key], "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(local.step_2[key], "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(local.step_2[key]), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[placeholder.filters[2]]
  }

  rendered = {
    for key, placeholder in local.placeholders : key => length(placeholder.filters) < 4 ? local.step_3[key] : {
      lower   = lower(local.step_3[key])
      upper   = upper(local.step_3[key])
      trim    = trimspace(local.step_3[key])
      ascii   = replace(join("", [for character in split("", local.step_3[key]) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(local.step_3[key], "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(local.step_3[key], "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(local.step_3[key]), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[placeholder.filters[3]]
  }

  # An optional segment renders only when none of its placeholders is empty.
  names = {
    for name, pieces in local.pieces : name => join("", [
      for i, piece in pieces : piece.optional && contains([
        for j, part in piece.parts : local.rendered["${name}/${i}/${j}"] if part.token != null
        ], "") ? "" : join("", [
        for j, part in piece.parts : part.token == null ? part.literal : lookup(local.rendered, "${name}/${i}/${j}", "")
      ])
    ])
  }

  # What the preconditions on the names output report. Each list is sorted so
  # that the messages are stable.
  missing_tokens = sort(distinct([
    for placeholder in values(local.placeholders) : "${placeholder.template}: {${placeholder.token}}"
    if !contains(keys(local.tokens), placeholder.token)
  ]))

  empty_placeholders = sort(distinct([
    for key, placeholder in local.placeholders : "${placeholder.template}: {${placeholder.token}}"
    if !placeholder.optional && local.rendered[key] == "" && contains(keys(local.tokens), placeholder.token)
  ]))

  empty_names = sort([for name, value in local.names : name if value == ""])

  # The token_rules findings, on the values as set: a null counts as empty, and an
  # empty value is checked only by required. Every operand is safe on its own,
  # because Terraform 1.7 does not short-circuit &&.
  rule_values = { for name in keys(var.token_rules) : name => lookup(local.tokens, name, "") }

  missing_required_tokens = sort([
    for name, rule in var.token_rules : name if rule.required && local.rule_values[name] == ""
  ])

  disallowed_token_values = sort([
    for name, rule in var.token_rules : "${name} = \"${local.rule_values[name]}\" (allowed: ${join(", ", rule.allowed_values == null ? [] : rule.allowed_values)})"
    if rule.allowed_values != null && local.rule_values[name] != "" && !contains(rule.allowed_values == null ? [] : rule.allowed_values, local.rule_values[name])
  ])

  token_pattern_mismatches = sort([
    for name, rule in var.token_rules : "${name} = \"${local.rule_values[name]}\" does not match ${rule.pattern == null ? "" : rule.pattern}"
    if rule.pattern != null && local.rule_values[name] != "" && !can(regex(rule.pattern == null ? "(?:)" : rule.pattern, local.rule_values[name]))
  ])

  unknown_constraints = sort([for name in keys(var.constraints) : name if !contains(keys(var.templates), name)])

  too_long = sort([
    for name, rule in var.constraints : "${name} has ${length(lookup(local.names, name, ""))} characters, more than ${coalesce(rule.max_length, 0)}"
    if rule.max_length != null && length(lookup(local.names, name, "")) > coalesce(rule.max_length, 0)
  ])

  pattern_mismatches = sort([
    for name, rule in var.constraints : "${name} \"${lookup(local.names, name, "")}\" does not match ${coalesce(rule.pattern, "(?:)")}"
    if rule.pattern != null && contains(keys(local.names), name) && !can(regex(coalesce(rule.pattern, "(?:)"), lookup(local.names, name, "")))
  ])
}
