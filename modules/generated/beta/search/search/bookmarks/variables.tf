variable "availability_end_date_time" {
  description = "Date and time when the bookmark stops appearing as a search result. Set as null for always available. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "availability_start_date_time" {
  description = "Date and time when the bookmark starts to appear as a search result. Set as null for always available. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "categories" {
  description = "Categories commonly used to describe this bookmark. For example, IT and HR."
  type        = list(string)
  default     = null
}

variable "description" {
  description = "The search answer description that is shown on the search results page."
  type        = string
  default     = null
}

variable "display_name" {
  description = "The search answer name that is displayed in search results."
  type        = string
  default     = null
}

variable "group_ids" {
  description = "The list of security groups that are able to view this bookmark."
  type        = list(string)
  default     = null
}

variable "keywords" {
  description = "Keywords that trigger this bookmark to appear in search results."
  type        = any
  default     = null
}

variable "language_tags" {
  description = "A list of geographically specific language names in which this bookmark can be viewed. Each language tag value follows the pattern {language}-{region}. For example, en-us is English as used in the United States. For the list of possible values, see Supported language tags."
  type        = list(string)
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.search.bookmark"
  nullable    = false
}

variable "platforms" {
  description = "List of devices and operating systems that are able to view this bookmark. The possible values are: android, androidForWork, ios, macOS, windowsPhone81, windowsPhone81AndLater, windows10AndLater, androidWorkProfile, unknown, androidASOP, androidMobileApplicationManagement, iOSMobileApplicationManagement, unknownFutureValue."
  type        = list(string)
  default     = null
}

variable "power_app_ids" {
  description = "List of Power Apps associated with this bookmark. If users add existing Power Apps to a bookmark, they can complete tasks directly on the search results page, such as entering vacation time or reporting expenses."
  type        = list(string)
  default     = null
}

variable "state" {
  description = "Microsoft Graph state property."
  type        = string
  default     = null

  validation {
    condition     = var.state == null ? true : contains(["published", "draft", "excluded", "unknownFutureValue"], var.state)
    error_message = "state must be one of the documented enum values."
  }
}

variable "targeted_variations" {
  description = "Variations of a bookmark for different countries/regions or devices. Use when you need to show different content to users based on their device, country/region, or both. The date and group settings apply to all variations."
  type = list(object({
    odata_type  = optional(string, "#microsoft.graph.search.answerVariant")
    description = optional(string)
    displayName = optional(string)
    languageTag = optional(string)
    platform    = optional(any)
    webUrl      = optional(string)
  }))
  default = null
}

variable "web_url" {
  description = "The URL link for the search answer. When users select this search answer from the search results, they're directed to the specified URL."
  type        = string
  default     = null
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
