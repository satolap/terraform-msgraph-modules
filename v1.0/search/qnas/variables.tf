variable "availabilityEndDateTime" {
  description = "Date and time when the QnA stops appearing as a search result. Set as null for always available. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "availabilityStartDateTime" {
  description = "Date and time when the QnA starts to appear as a search result. Set as null for always available. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "description" {
  description = "The search answer description that is shown on the search results page."
  type        = string
  default     = null
}

variable "displayName" {
  description = "The search answer name that is displayed in search results."
  type        = string
  default     = null
}

variable "groupIds" {
  description = "The list of security groups that are able to view this QnA."
  type        = list(string)
  default     = null
}

variable "keywords" {
  description = "Keywords that trigger this QnA to appear in search results."
  type = object({
    odata_type           = optional(string, "#microsoft.graph.search.answerKeyword")
    keywords             = optional(list(string))
    matchSimilarKeywords = optional(bool)
    reservedKeywords     = optional(list(string))
  })
  default = null
}

variable "languageTags" {
  description = "A list of geographically specific language names in which this QnA can be viewed. Each language tag value follows the pattern {language}-{region}. For example, en-us is English as used in the United States. For the list of possible values, see Supported language tags."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.search.qna"
  nullable    = false
}

variable "platforms" {
  description = "List of devices and operating systems that are able to view this QnA. The possible values are: android, androidForWork, ios, macOS, windowsPhone81, windowsPhone81AndLater, windows10AndLater, androidWorkProfile, unknown, androidASOP, androidMobileApplicationManagement, iOSMobileApplicationManagement, unknownFutureValue."
  type        = list(string)
  default     = null

  validation {
    condition     = (var.platforms == null ? true : alltrue([alltrue([for input0 in var.platforms : (input0 == null ? true : alltrue([(input0 == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "unknown", "androidAOSP", "androidMobileApplicationManagement", "iOSMobileApplicationManagement"], input0))]))])]))
    error_message = "platforms: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["published", "draft", "excluded"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "targetedVariations" {
  description = "Variations of a QnA for different countries/regions or devices. Use when you need to show different content to users based on their device, country/region, or both. The date and group settings apply to all variations."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.search.answerVariant")
    description = optional(string)
    displayName = optional(string)
    languageTag = optional(string)
    platform    = optional(string)
    webUrl      = optional(string)
  }))
  default = null

  validation {
    condition     = (var.targetedVariations == null ? true : alltrue([alltrue([for input0 in var.targetedVariations : (input0 == null ? true : alltrue([(input0["platform"] == null ? true : alltrue([(input0["platform"] == null ? true : contains(["android", "androidForWork", "iOS", "macOS", "windowsPhone81", "windows81AndLater", "windows10AndLater", "androidWorkProfile", "unknown", "androidAOSP", "androidMobileApplicationManagement", "iOSMobileApplicationManagement"], input0["platform"]))]))]))])]))
    error_message = "targetedVariations: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "webUrl" {
  description = "The URL link for the search answer. When users select this search answer from the search results, they are directed to the specified URL."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Optional timeouts of the msgraph_resource, each a duration in whole hours, minutes or seconds greater than zero, such as \"30m\" or \"1h30m\". create, update and delete must be at least \"15s\": after each request the provider waits for consistent reads within the same timeout. Every value defaults to null, which keeps the provider defaults and sends no timeouts block. The reviewed replication retries of this module, where it has any, count against these timeouts."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default  = {}
  nullable = false

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.read, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : (can(regex("^([0-9]+[hms])+$", t)) ? !can(regex("^(0+[hms])+$", t)) : false)
    ])
    error_message = "timeouts values must be durations in whole hours, minutes or seconds greater than zero, such as \"10m\" or \"1h30m\"."
  }

  validation {
    condition = alltrue([
      for t in [var.timeouts.create, var.timeouts.update, var.timeouts.delete] :
      t == null ? true : try(sum([for m in regexall("([0-9]+)([hms])", t) : tonumber(m[0]) * lookup({ h = 3600, m = 60, s = 1 }, m[1])]) >= 15, true)
    ])
    error_message = "timeouts.create, timeouts.update and timeouts.delete must be at least \"15s\"."
  }
}

variable "select_response" {
  description = "Opt in to a configured-property GET selection; this narrows response and can remove fields consumers use."
  type        = bool
  default     = false
  nullable    = false
}

variable "additional_properties" {
  description = "Additional writable Graph properties using API field names. Explicit typed inputs take precedence. Null top-level values are omitted; callers must omit nested nulls in untyped values."
  type        = any
  default     = {}
  nullable    = false
  sensitive   = true

  validation {
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "isSuggested", "lastModifiedBy", "lastModifiedDateTime"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
