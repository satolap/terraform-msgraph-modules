variable "displayName" {
  description = "Display name of the new custom authentication strength policy. Built-in policies cannot be selected or adopted."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.displayName)) > 0
    error_message = "displayName must not be empty or whitespace."
  }
}

# A control of this module, not a Graph property, so it keeps the snake_case name
# that every verified module uses for it.
variable "name_pattern" {
  description = "Regular expression (RE2 syntax, not anchored unless it says so) that displayName must match, such as the pattern of a naming convention. When it is set and displayName does not match, the plan fails. Null, the default, accepts any displayName."
  type        = string
  default     = null

  validation {
    condition     = var.name_pattern == null || can(regexall(var.name_pattern, ""))
    error_message = "name_pattern must be a valid regular expression (RE2 syntax)."
  }
}

variable "detached_maintenance" {
  description = "Enable only while every CA reference is detached to create or replace restriction configurations. Both live usage collections must be empty. Set false before reattaching; false requires child IDs and saved configuration outputs to remain known during planning, refusing any child replacement even when portal drift matches the desired body."
  type        = bool
  default     = false
  nullable    = false
}

variable "description" {
  description = "Description. Null omits the property and does not clear a previous description."
  type        = string
  default     = null
}

variable "allowedCombinations" {
  description = "Complete desired set of combinations, in the canonical comma-separated spelling from the pinned Graph combinations contract. Changes invoke updateAllowedCombinations; they never PATCH this property."
  type        = set(string)
  nullable    = false

  validation {
    condition = alltrue([
      length(var.allowedCombinations) > 0,
      alltrue([for combination in var.allowedCombinations : combination == null ? false : contains([
        "windowsHelloForBusiness", "fido2", "x509CertificateMultiFactor", "deviceBasedPush",
        "temporaryAccessPassOneTime", "temporaryAccessPassMultiUse",
        "password,microsoftAuthenticatorPush", "password,softwareOath", "password,hardwareOath",
        "password,sms", "password,voice", "federatedMultiFactor",
        "microsoftAuthenticatorPush,federatedSingleFactor", "softwareOath,federatedSingleFactor",
        "hardwareOath,federatedSingleFactor", "sms,federatedSingleFactor", "voice,federatedSingleFactor",
        "x509CertificateSingleFactor", "sms", "password", "federatedSingleFactor", "email",
      ], combination)]),
    ])
    error_message = "allowedCombinations must be nonempty and use only canonical combinations from the pinned Graph combinations contract; null, unknownFutureValue, unknown flags and arbitrary flag combinations are refused."
  }
}

variable "allowedAAGUIDs" {
  description = "Optional FIDO2 configuration: a nonempty set of Authenticator Attestation GUIDs. Null creates no FIDO2 configuration; changing the set replaces only that configuration."
  type        = set(string)
  default     = null

  validation {
    condition = var.allowedAAGUIDs == null ? true : alltrue([
      length(var.allowedAAGUIDs) > 0,
      alltrue([for value in var.allowedAAGUIDs : can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", value))]),
    ])
    error_message = "allowedAAGUIDs must be null or a nonempty set of GUIDs without null entries."
  }
}

variable "x509CertificateCombinationConfigurations" {
  description = "Certificate restrictions keyed by x509CertificateSingleFactor or x509CertificateMultiFactor. Each value contains only allowedIssuerSkis and/or allowedPolicyOIDs, with at least one nonempty restriction. A change replaces that configuration."
  type        = map(map(set(string)))
  default     = {}
  nullable    = false

  validation {
    condition = alltrue([for combination, restrictions in var.x509CertificateCombinationConfigurations : alltrue([
      contains(["x509CertificateSingleFactor", "x509CertificateMultiFactor"], combination),
      restrictions == null ? false : alltrue([
        length(restrictions) > 0,
        alltrue([for key, values in restrictions : alltrue([
          contains(["allowedIssuerSkis", "allowedPolicyOIDs"], key),
          values == null ? false : alltrue([
            length(values) > 0,
            alltrue([for value in values : value == null ? false : length(trimspace(value)) > 0]),
          ]),
        ])]),
      ]),
    ])])
    error_message = "Certificate configuration keys must be x509CertificateSingleFactor or x509CertificateMultiFactor, containing only nonempty allowedIssuerSkis/allowedPolicyOIDs sets without null or blank entries."
  }
}
