variable "assigned_role_count" {
  description = "The number of directory roles assigned to the group. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "calculated_date_time" {
  description = "The date and time when the analytics for the group were last calculated. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = string
  default     = null
}

variable "created_date_time" {
  description = "The date and time when the group was created. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = string
  default     = null
}

variable "direct_group_member_count" {
  description = "The number of direct members of the group that are themselves groups. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "display_name" {
  description = "The display name of the group. Supports $filter (eq, ne, startsWith, endsWith, contains) and $orderby."
  type        = string
  default     = null
}

variable "dynamic_membership_type" {
  description = "The dynamic membership classification of the group, derived from its membership rule. Supports $filter (eq, ne, startsWith, endsWith, contains) and $orderby."
  type        = string
  default     = null
}

variable "group_expiration_date_time" {
  description = "The date and time when the group expires. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = string
  default     = null
}

variable "group_type" {
  description = "Microsoft Graph groupType property."
  type        = string
  default     = null

  validation {
    condition     = var.group_type == null ? true : contains(["isCloudGroup", "isOnPremiseGroup", "isSoftDeletedGroup"], var.group_type)
    error_message = "group_type must be one of the documented enum values."
  }
}

variable "guest_owner_count" {
  description = "The number of owners of the group that are guest users. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "guest_transitive_user_count" {
  description = "The number of transitive user members of the group that are guest users. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "is_cloud_distribution_list_group" {
  description = "Indicates whether the group is a non-soft-deleted cloud distribution list group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_cloud_m365_group" {
  description = "Indicates whether the group is a non-soft-deleted cloud Microsoft 365 group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_cloud_mail_enabled_security_group" {
  description = "Indicates whether the group is a non-soft-deleted cloud mail-enabled security group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_cloud_security_group" {
  description = "Indicates whether the group is a non-soft-deleted cloud security group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_dynamic_group" {
  description = "Indicates whether the group is a dynamic group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_on_premise_distribution_list_group" {
  description = "Indicates whether the group is a non-soft-deleted on-premises distribution list group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_on_premise_mail_enabled_security_group" {
  description = "Indicates whether the group is a non-soft-deleted on-premises mail-enabled security group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_on_premise_security_group" {
  description = "Indicates whether the group is a non-soft-deleted on-premises security group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "is_valid_group" {
  description = "Indicates whether the group is a valid (non-soft-deleted) group. Supports $filter (eq, ne) and $orderby."
  type        = bool
  default     = null
}

variable "last_restoration_date_time" {
  description = "The date and time when the group was last restored from a soft-deleted state. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = string
  default     = null
}

variable "member_owner_count" {
  description = "The number of owners of the group that are member (non-guest) users. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "member_transitive_user_count" {
  description = "The number of transitive user members of the group that are member (non-guest) users. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "membership_rule_contains_count" {
  description = "The number of contains expressions in the membership rule of the group. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "membership_rule_expression_count" {
  description = "The number of expressions in the membership rule of the group. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "membership_rule_match_count" {
  description = "The number of match expressions in the membership rule of the group. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "membership_rule_member_of_count" {
  description = "The number of memberOf expressions in the membership rule of the group. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "membership_rule_processing_state" {
  description = "The processing state of the membership rule of the group. Supports $filter (eq, ne, startsWith, endsWith, contains) and $orderby."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.groupAnalytics"
  nullable    = false
}

variable "preferred_data_location" {
  description = "The preferred data location of the group. Supports $filter (eq, ne, startsWith, endsWith, contains) and $orderby."
  type        = string
  default     = null
}

variable "sensitivity_label_count" {
  description = "The number of sensitivity labels applied to the group. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "service_principal_owner_count" {
  description = "The number of owners of the group that are service principals. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "soft_deletion_date_time" {
  description = "The date and time when the group was soft-deleted. If this property is empty, the group isn't soft-deleted. The timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2014 is 2014-01-01T00:00:00Z. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "The unique identifier of the tenant that the group belongs to. Supports $filter (eq, ne) and $orderby."
  type        = string
  default     = null
}

variable "transitive_service_principal_count" {
  description = "The number of transitive members of the group that are service principals. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
  default     = null
}

variable "transitive_user_count" {
  description = "The total number of transitive user members of the group. Supports $filter (eq, ne, gt, ge, lt, le) and $orderby."
  type        = number
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
