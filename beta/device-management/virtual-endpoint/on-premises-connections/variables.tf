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
  type        = string
  default     = null

  validation {
    condition     = var.connection_type == null ? true : contains(["hybridAzureADJoin", "azureADJoin"], var.connection_type)
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
    condition     = var.health_check_status == null ? true : contains(["pending", "running", "passed", "failed", "warning", "informational"], var.health_check_status)
    error_message = "health_check_status must be one of the documented enum values."
  }
}

variable "managed_by" {
  description = "Microsoft Graph managedBy property."
  type        = string
  default     = null

  validation {
    condition     = var.managed_by == null ? true : try(alltrue([for value in split(",", var.managed_by) : contains(["windows365", "devbox"], lower(trimspace(value)))]), false)
    error_message = "managed_by must be one or more of the documented enum values, separated by commas."
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
  type        = string
  default     = null

  validation {
    condition     = var.type == null ? true : contains(["hybridAzureADJoin", "azureADJoin"], var.type)
    error_message = "type must be one of the documented enum values."
  }
}

variable "virtual_network_id" {
  description = "The ID of the target virtual network. Required format: /subscriptions/{subscription-id}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["healthCheckPaused", "healthCheckStatusDetail", "healthCheckStatusDetails", "id", "inUse", "inUseByCloudPc", "subnetPrivateIpDetail", "subscriptionName", "virtualNetworkLocation"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
