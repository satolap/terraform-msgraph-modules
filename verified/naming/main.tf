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

  # The allowed values of the tokens that token_rules limits.
  allowed_values = { for name, rule in var.token_rules : name => rule.allowed_values if rule.allowed_values != null }

  # The values that run through the filters: the value of every placeholder,
  # keyed like placeholders, and, for the patterns output, every allowed value
  # of its token through the same filters, keyed "<placeholder>/<index>".
  chains = merge(
    { for key, placeholder in local.placeholders : key => { value = placeholder.value, filters = placeholder.filters } },
    [for key, placeholder in local.placeholders : {
      for i, value in lookup(local.allowed_values, placeholder.token, []) : "${key}/${i}" => { value = value, filters = placeholder.filters }
    }]...
  )

  # The filters run from left to right, one step per position; the templates
  # validations allow at most four. A chain with fewer filters keeps its value
  # through the remaining steps. Each step computes every filter and picks the
  # one the chain names.
  step_1 = {
    for key, chain in local.chains : key => length(chain.filters) < 1 ? chain.value : {
      lower   = lower(chain.value)
      upper   = upper(chain.value)
      trim    = trimspace(chain.value)
      ascii   = replace(join("", [for character in split("", chain.value) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(chain.value, "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(chain.value, "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(chain.value), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[chain.filters[0]]
  }

  step_2 = {
    for key, chain in local.chains : key => length(chain.filters) < 2 ? local.step_1[key] : {
      lower   = lower(local.step_1[key])
      upper   = upper(local.step_1[key])
      trim    = trimspace(local.step_1[key])
      ascii   = replace(join("", [for character in split("", local.step_1[key]) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(local.step_1[key], "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(local.step_1[key], "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(local.step_1[key]), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[chain.filters[1]]
  }

  step_3 = {
    for key, chain in local.chains : key => length(chain.filters) < 3 ? local.step_2[key] : {
      lower   = lower(local.step_2[key])
      upper   = upper(local.step_2[key])
      trim    = trimspace(local.step_2[key])
      ascii   = replace(join("", [for character in split("", local.step_2[key]) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(local.step_2[key], "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(local.step_2[key], "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(local.step_2[key]), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[chain.filters[2]]
  }

  rendered = {
    for key, chain in local.chains : key => length(chain.filters) < 4 ? local.step_3[key] : {
      lower   = lower(local.step_3[key])
      upper   = upper(local.step_3[key])
      trim    = trimspace(local.step_3[key])
      ascii   = replace(join("", [for character in split("", local.step_3[key]) : lookup(local.transliterations, character, character)]), "/[^\\x00-\\x7F]/", "")
      alnum   = replace(local.step_3[key], "/[^\\p{L}\\p{N}]/", "")
      nospace = replace(local.step_3[key], "/[\\s\\p{Z}]/", "")
      slug    = trim(replace(lower(local.step_3[key]), "/[^\\p{L}\\p{N}]+/", "-"), "-")
    }[chain.filters[3]]
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

  # Every name checked against every built-in kind, keyed by template and kind.
  # The kinds validation picks the findings of the kind that each template
  # declares; it cannot use a value derived from kinds itself.
  kind_findings = {
    for name, value in local.names : name => {
      for kind, rule in local.builtin_kinds : kind => concat(
        trimspace(value) == "" ? ["${name} (${kind}) is blank"] : [],
        rule.max_length != null && length(value) > coalesce(rule.max_length, 0) ? ["${name} (${kind}) has ${length(value)} characters, more than ${coalesce(rule.max_length, 0)}"] : [],
        rule.pattern != null && !can(regex(rule.pattern == null ? "(?:)" : rule.pattern, value)) ? ["${name} (${kind}) \"${value}\" does not match ${rule.pattern == null ? "" : rule.pattern}"] : [],
      )
    }
  }

  # The patterns output. A trait is what a placeholder's filters guarantee
  # about its rendered value: ascii, only ASCII characters; alnum, only letters
  # and digits; slug, words of letters and digits joined by single hyphens;
  # dashed, only letters, digits and hyphens; nospace, no whitespace; lower and
  # upper, a value that lower or upper leaves unchanged, so no A-Z or no a-z.
  # A trait holds when a filter that sets it runs after every filter that
  # clears it. ascii keeps an earlier trait only when no entry of the
  # transliteration table can break it, such as a replacement with a space.
  ascii_keeps = {
    alnum   = alltrue([for value in values(local.transliterations) : can(regex("^[A-Za-z0-9]*$", value))])
    nospace = alltrue([for value in values(local.transliterations) : !strcontains(value, " ")])
    lower   = alltrue([for character, value in local.transliterations : lower(character) != character || !can(regex("[A-Z]", value))])
    upper   = alltrue([for character, value in local.transliterations : upper(character) != character || !can(regex("[a-z]", value))])
  }

  trait_filters = {
    ascii   = { set = ["ascii"], clear = [] }
    alnum   = { set = ["alnum"], clear = local.ascii_keeps.alnum ? ["slug"] : ["slug", "ascii"] }
    slug    = { set = ["slug"], clear = ["alnum", "ascii"] }
    dashed  = { set = ["alnum", "slug"], clear = local.ascii_keeps.alnum ? [] : ["ascii"] }
    nospace = { set = ["nospace", "alnum", "slug"], clear = local.ascii_keeps.nospace ? [] : ["ascii"] }
    lower   = { set = ["lower", "slug"], clear = local.ascii_keeps.lower ? ["upper"] : ["upper", "ascii"] }
    upper   = { set = ["upper"], clear = local.ascii_keeps.upper ? ["lower", "slug"] : ["lower", "slug", "ascii"] }
  }

  traits = {
    for key, placeholder in local.placeholders : key => {
      for trait, filters in local.trait_filters : trait => (
        max(-1, [for i, filter in placeholder.filters : i if contains(filters.set, filter)]...) >
        max(-1, [for i, filter in placeholder.filters : i if contains(filters.clear, filter)]...)
      )
    }
  }

  # The letters and digits that a placeholder can render, and the characters
  # that its filters removed, for a negated class.
  character_classes = {
    for key, trait in local.traits : key => {
      word = trait.ascii ? (trait.lower ? "a-z0-9" : trait.upper ? "A-Z0-9" : "A-Za-z0-9") : "\\p{L}\\p{N}"
      excluded = join("", [
        trait.nospace ? "\\s\\p{Z}" : "",
        trait.lower ? "A-Z" : "",
        trait.upper ? "a-z" : "",
        trait.ascii ? "\\x{80}-\\x{10FFFF}" : "",
      ])
    }
  }

  # Literal text is escaped wherever RE2 would read it as syntax.
  regex_metacharacters = "/[\\\\.+*?()|\\[\\]{}^$]/"

  # The allowed values of a placeholder's token, after its filters. A value that
  # renders empty never renders the placeholder, so it is left out.
  allowed_atoms = {
    for key, placeholder in local.placeholders : key => compact(distinct([
      for i, value in lookup(local.allowed_values, placeholder.token, []) : replace(local.rendered["${key}/${i}"], local.regex_metacharacters, "\\$0")
    ]))
    if contains(keys(local.allowed_values), placeholder.token)
  }

  # The expression that matches one placeholder: the character of a built-in
  # token, one of its token's allowed values, or a run of the characters that
  # its filters leave. [^\x00-\x{10FFFF}] matches nothing, for a token whose
  # allowed values all render empty.
  atoms = {
    for key, placeholder in local.placeholders : key => (
      contains(keys(local.builtin_tokens), placeholder.token) ? replace(lookup(local.rendered, key, ""), local.regex_metacharacters, "\\$0") :
      contains(keys(local.allowed_atoms), key) ? (length(lookup(local.allowed_atoms, key, [])) > 0 ? "(?:${join("|", lookup(local.allowed_atoms, key, []))})" : "[^\\x00-\\x{10FFFF}]") :
      local.traits[key].slug ? "[${local.character_classes[key].word}]+(?:-[${local.character_classes[key].word}]+)*" :
      local.traits[key].alnum ? "[${local.character_classes[key].word}]+" :
      local.traits[key].dashed ? "[${local.character_classes[key].word}-]+" :
      local.character_classes[key].excluded == "" ? ".+" : "[^${local.character_classes[key].excluded}]+"
    )
  }

  # A template's pattern joins its pieces in order, an optional segment as an
  # optional group, anchored at both ends. (?s) lets . match a line break when
  # a placeholder can render any character.
  patterns = {
    for name, pieces in local.pieces : name => format("%s^%s$",
      anytrue([for key, placeholder in local.placeholders : placeholder.template == name && local.atoms[key] == ".+"]) ? "(?s)" : "",
      join("", [
        for i, piece in pieces : format(piece.optional ? "(?:%s)?" : "%s", join("", [
          for j, part in piece.parts : part.token == null ? replace(part.literal, local.regex_metacharacters, "\\$0") : local.atoms["${name}/${i}/${j}"]
        ]))
      ])
    )
  }
}
