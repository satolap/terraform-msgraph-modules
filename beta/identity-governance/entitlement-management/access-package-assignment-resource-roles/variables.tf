variable "access_package_resource_role" {
  description = "Microsoft Graph accessPackageResourceRole property."
  type        = any
  default     = null
}

variable "access_package_resource_scope" {
  description = "Microsoft Graph accessPackageResourceScope property."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.accessPackageAssignmentResourceRole"
  nullable    = false
}

variable "origin_id" {
  description = "A unique identifier relative to the origin system, corresponding to the originId property of the accessPackageResourceRole."
  type        = string
  default     = null
}

variable "origin_system" {
  description = "The system where the role assignment is to be created or has been created for an access package assignment, such as SharePointOnline, AadGroup, or AadApplication, corresponding to the originSystem property of the accessPackageResourceRole."
  type        = string
  default     = null
}

variable "status" {
  description = "The value is PendingFulfillment before the access package assignment is delivered to the origin system, and Fulfilled after the access package assignment is delivered to the origin system."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["accessPackageAssignments", "accessPackageSubject", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
