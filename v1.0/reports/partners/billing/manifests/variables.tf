variable "blob_count" {
  description = "The total file count for this partner tenant ID."
  type        = number
  default     = null
}

variable "blobs" {
  description = "A collection of blob objects that contain details of all the files for the partner tenant ID."
  type = list(object({
    odata_type     = optional(string, "#microsoft.graph.partners.billing.blob")
    name           = optional(string)
    partitionValue = optional(string)
  }))
  default = null
}

variable "created_date_time" {
  description = "The date and time when a manifest resource was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z."
  type        = string
  default     = null
}

variable "data_format" {
  description = "The billing data file format. The possible value is: compressedJSONLines. Each blob is a compressed file and data in the file is in JSON lines format. Decompress the file to access the data."
  type        = string
  default     = null
}

variable "e_tag" {
  description = "Version of data represented by the manifest. Any change in eTag indicates a new data version."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.partners.billing.manifest"
  nullable    = false
}

variable "partition_type" {
  description = "Indicates the division of data. If a given partition has more than the supported number, the data is split into multiple files, each file representing a specific partitionValue. By default, the data in the file is partitioned by the number of line items."
  type        = string
  default     = null
}

variable "partner_tenant_id" {
  description = "The Microsoft Entra tenant ID of the partner."
  type        = string
  default     = null
}

variable "root_directory" {
  description = "The root directory that contains all the files."
  type        = string
  default     = null
}

variable "sas_token" {
  description = "The SAS token for accessing the directory or an individual file in the directory."
  type        = string
  default     = null
}

variable "schema_version" {
  description = "The version of the manifest schema."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
