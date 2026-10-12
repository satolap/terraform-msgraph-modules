variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcGalleryImage"
  nullable    = false
}

variable "offer_display_name" {
  description = "The official display offer name of this gallery image. For example, Windows 11 Enterprise. The offerDisplayName property is deprecated and will stop returning data on January 31, 2024."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["displayName", "endDate", "expirationDate", "id", "offer", "offerName", "osVersionNumber", "publisher", "publisherName", "recommendedSku", "sizeInGB", "sku", "skuDisplayName", "skuName", "startDate", "status"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
