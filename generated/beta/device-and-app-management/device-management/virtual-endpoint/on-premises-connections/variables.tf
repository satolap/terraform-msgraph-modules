variable "ad_domain_name" {
  description = "The fully qualified domain name (FQDN) of the Active Directory domain you want to join. Optional."
  type        = string
  default     = null
}

variable "ad_domain_password" {
  description = "The password associated with adDomainUsername."
  type        = string
  default     = null
  sensitive   = true
}

variable "ad_domain_username" {
  description = "The username of an Active Directory account (user or service account) that has permissions to create computer objects in Active Directory. Required format: admin@contoso.com. Optional."
  type        = string
  default     = null
}

variable "alternate_resource_url" {
  description = "The interface URL of the partner service's resource that links to this Azure network connection. Requires $select to retrieve."
  type        = string
  default     = null
}

variable "connection_type" {
  description = "Specifies the method by which a provisioned Cloud PC is joined to Microsoft Entra. The azureADJoin option indicates the absence of an on-premises Active Directory (AD) in the current tenant which results in the Cloud PC device only joining to Microsoft Entra. The hybridAzureADJoin option indicates the presence of an on-premises AD in the current tenant and that the Cloud PC joins both the on-premises AD and Microsoft Entra. The selected option also determines the types of users who can be assigned and can sign into a Cloud PC. The azureADJoin option allows both cloud-only and hybrid users to be assigned and sign in, whereas hybridAzureADJoin is restricted to hybrid users only. The default value is hybridAzureADJoin. The possible values are: hybridAzureADJoin, azureADJoin, unknownFutureValue."
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

variable "managed_by" {
  description = "Microsoft Graph managedBy property."
  type        = string
  default     = null

  validation {
    condition     = var.managed_by == null ? true : contains(["windows365", "devBox", "unknownFutureValue", "rpaBox", "microsoft365Opal", "microsoft365BizChat"], var.managed_by)
    error_message = "managed_by must be one of the documented enum values."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.cloudPcOnPremisesConnection"
  nullable    = false
}

variable "organizational_unit" {
  description = "The organizational unit (OU) in which the computer account is created. If left null, the OU configured as the default (a well-known computer object container) in your Active Directory domain (OU) is used. Optional."
  type        = string
  default     = null
}

variable "resource_group_id" {
  description = "The ID of the target resource group. Required format: /subscriptions/{subscription-id}/resourceGroups/{resourceGroupName}."
  type        = string
  default     = null
}

variable "scope_ids" {
  description = "The scope IDs of the corresponding permission. Currently, it's the Intune scope tag ID."
  type        = list(string)
  default     = null
}

variable "subnet_id" {
  description = "The ID of the target subnet. Required format: /subscriptions/{subscription-id}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkId}/subnets/{subnetName}."
  type        = string
  default     = null
}

variable "subscription_id" {
  description = "The ID of the target Azure subscription associated with your tenant."
  type        = string
  default     = null
}

variable "type" {
  description = "Specifies the method by which a provisioned Cloud PC is joined to Microsoft Entra. The azureADJoin option indicates the absence of an on-premises Active Directory (AD) in the current tenant, which results in the Cloud PC device only joining to Microsoft Entra. The hybridAzureADJoin option indicates the presence of an on-premises AD in the current tenant and that the Cloud PC joins both the on-premises AD and Microsoft Entra. The selected option also determines the types of users who can be assigned and can sign into a Cloud PC. The azureADJoin option allows both cloud-only and hybrid users to be assigned and sign in, whereas hybridAzureADJoin is restricted to hybrid users only. The default value is hybridAzureADJoin. The possible values are: hybridAzureADJoin, azureADJoin, unknownFutureValue. The type property is deprecated and stopped returning data on January 31, 2024. Going forward, use the connectionType property."
  type        = any
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["hybridAzureADJoin", "azureADJoin", "unknownFutureValue"], var.type)
    error_message = "type must be one of the documented enum values."
  }
}

variable "virtual_network_id" {
  description = "The ID of the target virtual network. Required format: /subscriptions/{subscription-id}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["healthCheckPaused", "healthCheckStatusDetail", "healthCheckStatusDetails", "id", "inUse", "inUseByCloudPc", "subnetPrivateIpDetail", "subscriptionName", "virtualNetworkLocation"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
