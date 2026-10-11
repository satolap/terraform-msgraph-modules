variable "templates" {
  description = "The naming convention: one template per name, keyed by a name of your choice, such as catalog or owners_group (lower case letters, digits and underscores, starting with a letter). A template is literal text with placeholders. {token} inserts the value of a token, and {token|filter|filter} applies up to four filters from left to right: lower, upper, trim, ascii, alnum, nospace or slug. [text] is an optional segment, left out when a placeholder in it renders empty; it must hold a placeholder and cannot nest. The characters { } [ ] are syntax only: the built-in tokens lbrace, rbrace, lbracket and rbracket insert them."
  type        = map(string)
  nullable    = false

  validation {
    condition     = alltrue([for name in keys(var.templates) : can(regex("^[a-z][a-z0-9_]*$", name))])
    error_message = "templates keys must start with a lower case letter and contain only lower case letters, digits and underscores."
  }

  validation {
    condition     = alltrue([for template in values(var.templates) : try(can(regex("^(?:[^\\[\\]{}]|\\{[a-z][a-z0-9_]*(?:\\|[a-z]+)*\\}|\\[(?:[^\\[\\]{}]|\\{[a-z][a-z0-9_]*(?:\\|[a-z]+)*\\})*\\])+$", template)), false)])
    error_message = "Every template must be non-empty text whose placeholders look like {token} or {token|filter}, with token names in lower case letters, digits and underscores, and whose optional segments are [text] without nesting. Insert a literal { } [ or ] with the built-in tokens {lbrace}, {rbrace}, {lbracket} and {rbracket}."
  }

  validation {
    condition = alltrue(flatten([
      for template in values(var.templates) : [
        for placeholder in regexall("\\{[a-z][a-z0-9_]*((?:\\|[a-z]+)*)\\}", template) : [
          for filter in compact(split("|", placeholder[0])) : contains(["lower", "upper", "trim", "ascii", "alnum", "nospace", "slug"], filter)
        ]
      ]
    ]))
    error_message = "Template filters must be lower, upper, trim, ascii, alnum, nospace or slug."
  }

  validation {
    condition = alltrue(flatten([
      for template in values(var.templates) : [
        for placeholder in regexall("\\{[a-z][a-z0-9_]*((?:\\|[a-z]+)*)\\}", template) : length(compact(split("|", placeholder[0]))) <= 4
      ]
    ]))
    error_message = "A placeholder can apply at most four filters."
  }

  validation {
    condition = alltrue(flatten([
      for template in values(var.templates) : [
        for segment in regexall("\\[([^\\[\\]]*)\\]", template) : strcontains(segment[0], "{")
      ]
    ]))
    error_message = "Every optional segment [text] must hold a placeholder: a segment without one would always render, so leave out the brackets."
  }
}

variable "tokens" {
  description = "The values that the placeholders insert, keyed by token name (lower case letters, digits and underscores, starting with a letter). An empty or null value renders empty: an optional segment that holds it is left out, and a placeholder outside an optional segment fails the plan. The names lbrace, rbrace, lbracket and rbracket are built in and reserved."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = alltrue([for name in keys(var.tokens) : can(regex("^[a-z][a-z0-9_]*$", name))])
    error_message = "tokens keys must start with a lower case letter and contain only lower case letters, digits and underscores."
  }

  validation {
    condition     = length(setintersection(keys(var.tokens), ["lbrace", "rbrace", "lbracket", "rbracket"])) == 0
    error_message = "lbrace, rbrace, lbracket and rbracket are built-in tokens; they cannot be set in tokens."
  }
}

variable "token_rules" {
  description = "Rules for token values, keyed by token name, that make a convention's parts checkable: required (default false) fails the plan when the token is not set or empty; allowed_values lists the only values a non-empty token may take, such as a convention's environment codes; pattern is a regular expression in RE2 syntax that a non-empty value must match (not anchored unless it says so). The rules check the value as set in tokens, before any filter, and apply whether or not a template uses the token."
  type = map(object({
    required       = optional(bool, false)
    allowed_values = optional(list(string))
    pattern        = optional(string)
  }))
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for name in keys(var.token_rules) : can(regex("^[a-z][a-z0-9_]*$", name))])
    error_message = "token_rules keys must start with a lower case letter and contain only lower case letters, digits and underscores."
  }

  validation {
    condition     = alltrue([for rule in values(var.token_rules) : rule.allowed_values == null || try(length(rule.allowed_values) > 0, false)])
    error_message = "token_rules allowed_values must list at least one value when it is set."
  }

  validation {
    condition     = alltrue([for rule in values(var.token_rules) : rule.pattern == null || can(regexall(rule.pattern, ""))])
    error_message = "token_rules pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "constraints" {
  description = "Rules that a rendered name must meet, keyed like templates: max_length, a whole number of characters of at least 1, and pattern, a regular expression in RE2 syntax that the name must match (not anchored unless it says so). A name that breaks a rule fails the plan."
  type = map(object({
    max_length = optional(number)
    pattern    = optional(string)
  }))
  default  = {}
  nullable = false

  validation {
    condition     = alltrue([for rule in values(var.constraints) : rule.max_length == null || try(rule.max_length >= 1 && floor(rule.max_length) == rule.max_length, false)])
    error_message = "constraints max_length must be a whole number of at least 1."
  }

  validation {
    condition     = alltrue([for rule in values(var.constraints) : rule.pattern == null || can(regexall(rule.pattern, ""))])
    error_message = "constraints pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "transliterations" {
  description = "Changes to the character table of the ascii filter: a map from one character (one Unicode code point) to its replacement, which is printable ASCII or empty to drop the character. It is merged over the built-in table, which maps the Latin letters with diacritics of Latin-1 Supplement and Latin Extended-A, and Ș and Ț, to their base letters, and spells out ß, æ, œ, þ and ĳ (ss, ae, oe, th, ij). For example, { \"ä\" = \"ae\", \"ö\" = \"oe\", \"ü\" = \"ue\" } spells umlauts with an e."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = alltrue([for character in keys(var.transliterations) : length(split("", character)) == 1])
    error_message = "transliterations keys must be single characters, each one Unicode code point: the ascii filter looks up one code point at a time."
  }

  validation {
    condition     = alltrue([for replacement in values(var.transliterations) : replacement != null && can(regex("^[ -~]*$", replacement))])
    error_message = "transliterations values must be printable ASCII text, or empty to drop the character."
  }
}
