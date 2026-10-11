output "names" {
  description = "The rendered names, keyed like templates. The plan fails when a template uses a token that is not set, a token breaks its token_rules, a placeholder outside an optional segment renders empty, a name renders empty, constraints names a template that does not exist, or a name breaks its constraints. A name that depends on a value known only after apply is checked during the apply."
  value       = local.names

  precondition {
    condition     = length(local.missing_required_tokens) == 0
    error_message = "Required tokens are not set or empty: ${join(", ", local.missing_required_tokens)}."
  }

  precondition {
    condition     = length(local.disallowed_token_values) == 0
    error_message = "Tokens have values that their allowed_values do not list: ${join("; ", local.disallowed_token_values)}."
  }

  precondition {
    condition     = length(local.token_pattern_mismatches) == 0
    error_message = "Token values do not match their pattern: ${join("; ", local.token_pattern_mismatches)}."
  }

  precondition {
    condition     = length(local.missing_tokens) == 0
    error_message = "Templates use tokens that are not set: ${join(", ", local.missing_tokens)}. Add them to tokens."
  }

  precondition {
    condition     = length(local.empty_placeholders) == 0
    error_message = "Placeholders outside an optional segment rendered empty: ${join(", ", local.empty_placeholders)}. Give the token a value that stays non-empty after its filters, or put the placeholder in an optional segment [...]."
  }

  precondition {
    condition     = length(local.empty_names) == 0
    error_message = "Templates rendered an empty name: ${join(", ", local.empty_names)}. Every name needs at least one character outside optional segments that were left out."
  }

  precondition {
    condition     = length(local.unknown_constraints) == 0
    error_message = "constraints names templates that do not exist: ${join(", ", local.unknown_constraints)}."
  }

  precondition {
    condition     = length(local.too_long) == 0
    error_message = "Rendered names are longer than their max_length: ${join("; ", local.too_long)}."
  }

  precondition {
    condition     = length(local.pattern_mismatches) == 0
    error_message = "Rendered names do not match their pattern: ${join("; ", local.pattern_mismatches)}."
  }
}
