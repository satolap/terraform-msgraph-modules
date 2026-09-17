variable "ad_domain_name" {
  description = "The fully qualified domain name (FQDN) of the Active Directory domain you want to join. Maximum length is 255. Optional."
  type        = string
  default     = null
}

variable "ad_domain_password" {
  description = "The password associated with the username of an Active Directory account (adDomainUsername)."
  type        = string
  default     = null
  sensitive   = true
}

variable "ad_domain_username" {
  description = "The username of an Active Directory account (user or service account) that has permission to create computer objects in Active Directory. Required format: admin@contoso.com. Optional."
  type        = string
  default     = null
}

variable "alternate_resource_url" {
  description = "The interface URL of the partner service's resource that links to this Azure network connection. Requires $select to retrieve."
  type        = string
  default     = null
}

variable "connection_type" {
  description = "Specifies how the provisioned Cloud PC joins to Microsoft Entra. It includes different types, one is Microsoft Entra ID join, which means there's no on-premises Active Directory (AD) in the current tenant, and the Cloud PC device is joined by Microsoft Entra. Another one is hybridAzureADJoin, which means there's also an on-premises Active Directory (AD) in the current tenant and the Cloud PC device joins to on-premises Active Directory (AD) and Microsoft Entra. The type also determines which types of users can be assigned and can sign into a Cloud PC. The azureADJoin type indicates that cloud-only and hybrid users can be assigned and signed into the Cloud PC. hybridAzureADJoin indicates only hybrid users can be assigned and signed into the Cloud PC. The default value is hybridAzureADJoin."
  type        = any
  default     = null

  validation {
    condition     = var.connection_type == null ? true : contains(["hybridAzureADJoin", "azureADJoin", "unknownFutureValue"], var.connection_type)
    error_message = "connection_type must be one of the documented enum values."
  }
}

variable "display_name" {
  description = "The display name for the Azure network connection."
  type        = string
  default     = null
}

variable "health_check_status" {
  description = "Microsoft Graph healthCheckStatus property."
  type        = string
  default     = null

  validation {
    condition     = var.health_check_status == null ? true : contains(["pending", "running", "passed", "failed", "warning", "informational", "unknownFutureValue"], var.health_check_status)
    error_message = "health_check_status must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcOnPremisesConnection"
  nullable    = false
}

variable "organizational_unit" {
  description = "The organizational unit (OU) in which the computer account is created. If left null, the OU configured as the default (a well-known computer object container) in the tenant's Active Directory domain (OU) is used. Optional."
  type        = string
  default     = null
}

variable "resource_group_id" {
  description = "The unique identifier of the target resource group used associated with the on-premises network connectivity for Cloud PCs. Required format: '/subscriptions/{subscription-id}/resourceGroups/{resourceGroupName}'"
  type        = string
  default     = null
}

variable "scope_ids" {
  description = "The scope IDs of the corresponding permission. Currently, it's the Intune scope tag ID."
  type        = list(string)
  default     = null
}

variable "subnet_id" {
  description = "The unique identifier of the target subnet used associated with the on-premises network connectivity for Cloud PCs. Required format: '/subscriptions/{subscription-id}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkId}/subnets/{subnetName}'"
  type        = string
  default     = null
}

variable "subscription_id" {
  description = "The unique identifier of the Azure subscription associated with the tenant."
  type        = string
  default     = null
}

variable "virtual_network_id" {
  description = "The unique identifier of the target virtual network used associated with the on-premises network connectivity for Cloud PCs. Required format: '/subscriptions/{subscription-id}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}'"
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["healthCheckPaused", "healthCheckStatusDetail", "id", "inUse", "inUseByCloudPc", "subscriptionName", "virtualNetworkLocation"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
