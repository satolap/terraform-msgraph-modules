variable "servicePrincipal-id" {
  description = "The unique identifier of servicePrincipal"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.servicePrincipal-id)) > 0
    error_message = "servicePrincipal-id must not be empty."
  }
}

variable "bulkUpload" {
  description = "The bulk upload operation for the job."
  type        = any
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.synchronizationJob"
  nullable    = false
}

variable "schema" {
  description = "The synchronization schema configured for the job."
  type        = any
  default     = null
}

variable "status" {
  description = "Status of the job, which includes when the job was last run, current job state, and errors."
  type = object({
    odata_type                      = optional(string, "#microsoft.graph.synchronizationStatus")
    code                            = optional(string)
    countSuccessiveCompleteFailures = optional(number)
    escrowsPruned                   = optional(bool)
    lastExecution = optional(object({
      odata_type                   = optional(string, "#microsoft.graph.synchronizationTaskExecution")
      activityIdentifier           = optional(string)
      countEntitled                = optional(number)
      countEntitledForProvisioning = optional(number)
      countEscrowed                = optional(number)
      countEscrowedRaw             = optional(number)
      countExported                = optional(number)
      countExports                 = optional(number)
      countImported                = optional(number)
      countImportedDeltas          = optional(number)
      countImportedReferenceDeltas = optional(number)
      error = optional(object({
        odata_type       = optional(string, "#microsoft.graph.synchronizationError")
        code             = optional(string)
        message          = optional(string)
        tenantActionable = optional(bool)
      }))
      state     = optional(string)
      timeBegan = optional(string)
      timeEnded = optional(string)
    }))
    lastSuccessfulExecution = optional(object({
      odata_type                   = optional(string, "#microsoft.graph.synchronizationTaskExecution")
      activityIdentifier           = optional(string)
      countEntitled                = optional(number)
      countEntitledForProvisioning = optional(number)
      countEscrowed                = optional(number)
      countEscrowedRaw             = optional(number)
      countExported                = optional(number)
      countExports                 = optional(number)
      countImported                = optional(number)
      countImportedDeltas          = optional(number)
      countImportedReferenceDeltas = optional(number)
      error = optional(object({
        odata_type       = optional(string, "#microsoft.graph.synchronizationError")
        code             = optional(string)
        message          = optional(string)
        tenantActionable = optional(bool)
      }))
      state     = optional(string)
      timeBegan = optional(string)
      timeEnded = optional(string)
    }))
    lastSuccessfulExecutionWithExports = optional(object({
      odata_type                   = optional(string, "#microsoft.graph.synchronizationTaskExecution")
      activityIdentifier           = optional(string)
      countEntitled                = optional(number)
      countEntitledForProvisioning = optional(number)
      countEscrowed                = optional(number)
      countEscrowedRaw             = optional(number)
      countExported                = optional(number)
      countExports                 = optional(number)
      countImported                = optional(number)
      countImportedDeltas          = optional(number)
      countImportedReferenceDeltas = optional(number)
      error = optional(object({
        odata_type       = optional(string, "#microsoft.graph.synchronizationError")
        code             = optional(string)
        message          = optional(string)
        tenantActionable = optional(bool)
      }))
      state     = optional(string)
      timeBegan = optional(string)
      timeEnded = optional(string)
    }))
    progress = optional(list(object({
      odata_type                  = optional(string, "#microsoft.graph.synchronizationProgress")
      completedUnits              = optional(number)
      progressObservationDateTime = optional(string)
      totalUnits                  = optional(number)
      units                       = optional(string)
    })))
    quarantine = optional(object({
      odata_type   = optional(string, "#microsoft.graph.synchronizationQuarantine")
      currentBegan = optional(string)
      error = optional(object({
        odata_type       = optional(string, "#microsoft.graph.synchronizationError")
        code             = optional(string)
        message          = optional(string)
        tenantActionable = optional(bool)
      }))
      nextAttempt = optional(string)
      reason      = optional(string)
      seriesBegan = optional(string)
      seriesCount = optional(number)
    }))
    steadyStateFirstAchievedTime = optional(string)
    steadyStateLastAchievedTime  = optional(string)
    synchronizedEntryCountByType = optional(list(object({
      odata_type = optional(string, "#microsoft.graph.stringKeyLongValuePair")
      key        = optional(string)
      value      = optional(number)
    })))
    troubleshootingUrl = optional(string)
  })
  default = null

  validation {
    condition     = (var.status == null ? true : alltrue([(var.status["code"] == null ? true : alltrue([(var.status["code"] == null ? true : contains(["NotConfigured", "NotRun", "Active", "Paused", "Quarantine"], var.status["code"]))])), (var.status["lastExecution"] == null ? true : alltrue([(var.status["lastExecution"]["state"] == null ? true : alltrue([(var.status["lastExecution"]["state"] == null ? true : contains(["Succeeded", "Failed", "EntryLevelErrors"], var.status["lastExecution"]["state"]))]))])), (var.status["lastSuccessfulExecution"] == null ? true : alltrue([(var.status["lastSuccessfulExecution"]["state"] == null ? true : alltrue([(var.status["lastSuccessfulExecution"]["state"] == null ? true : contains(["Succeeded", "Failed", "EntryLevelErrors"], var.status["lastSuccessfulExecution"]["state"]))]))])), (var.status["lastSuccessfulExecutionWithExports"] == null ? true : alltrue([(var.status["lastSuccessfulExecutionWithExports"]["state"] == null ? true : alltrue([(var.status["lastSuccessfulExecutionWithExports"]["state"] == null ? true : contains(["Succeeded", "Failed", "EntryLevelErrors"], var.status["lastSuccessfulExecutionWithExports"]["state"]))]))])), (var.status["quarantine"] == null ? true : alltrue([(var.status["quarantine"]["reason"] == null ? true : alltrue([(var.status["quarantine"]["reason"] == null ? true : contains(["EncounteredBaseEscrowThreshold", "EncounteredTotalEscrowThreshold", "EncounteredEscrowProportionThreshold", "EncounteredQuarantineException", "Unknown", "QuarantinedOnDemand", "TooManyDeletes", "IngestionInterrupted"], var.status["quarantine"]["reason"]))]))]))]))
    error_message = "status: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "synchronizationJobSettings" {
  description = "Settings associated with the job. Some settings are inherited from the template."
  type = list(object({
    odata_type = optional(string, "#microsoft.graph.keyValuePair")
    name       = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "templateId" {
  description = "Identifier of the synchronization template this job is based on."
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id", "schedule"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
