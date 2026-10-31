variable "attackTechnique" {
  description = "The social engineering technique used in the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, credentialHarvesting, attachmentMalware, driveByUrl, linkInAttachment, linkToMalwareFile, unknownFutureValue, oAuthConsentGrant, phishTraining. Use the Prefer: include-unknown-enum-members request header to get the following values from this evolvable enum: oAuthConsentGrant, phishTraining. For more information on the types of social engineering attack techniques, see simulations."
  type        = string
  default     = null

  validation {
    condition     = var.attackTechnique == null ? true : contains(["unknown", "credentialHarvesting", "attachmentMalware", "driveByUrl", "linkInAttachment", "linkToMalwareFile"], var.attackTechnique)
    error_message = "attackTechnique must be one of the documented enum values."
  }
}

variable "attackType" {
  description = "Attack type of the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, social, cloud, endpoint, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.attackType == null ? true : contains(["unknown", "social", "cloud", "endpoint"], var.attackType)
    error_message = "attackType must be one of the documented enum values."
  }
}

variable "automationId" {
  description = "Unique identifier for the attack simulation automation."
  type        = string
  default     = null
}

variable "completionDateTime" {
  description = "Date and time of completion of the attack simulation and training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "createdBy" {
  description = "Identity of the user who created the attack simulation and training campaign."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.emailIdentity")
    displayName = optional(string)
    email       = optional(string)
    id          = optional(string)
  })
  default = null
}

variable "createdDateTime" {
  description = "Date and time of creation of the attack simulation and training campaign."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the attack simulation and training campaign."
  type        = string
  default     = null
}

variable "displayName" {
  description = "Display name of the attack simulation and training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "durationInDays" {
  description = "Simulation duration in days."
  type        = number
  default     = null
}

variable "endUserNotificationSetting" {
  description = "Details about the end user notification setting."
  type        = any
  default     = null
}

variable "excludedAccountTarget" {
  description = "Users excluded from the simulation."
  type        = any
  default     = null
}

variable "includedAccountTarget" {
  description = "Users targeted in the simulation."
  type        = any
  default     = null
}

variable "isAutomated" {
  description = "Flag that represents if the attack simulation and training campaign was created from a simulation automation flow. Supports $filter and $orderby."
  type        = bool
  default     = null
}

variable "landingPage" {
  description = "The landing page associated with a simulation during its creation."
  type        = any
  default     = null
}

variable "lastModifiedBy" {
  description = "Identity of the user who most recently modified the attack simulation and training campaign."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.emailIdentity")
    displayName = optional(string)
    email       = optional(string)
    id          = optional(string)
  })
  default = null
}

variable "lastModifiedDateTime" {
  description = "Date and time of the most recent modification of the attack simulation and training campaign."
  type        = string
  default     = null
}

variable "launchDateTime" {
  description = "Date and time of the launch/start of the attack simulation and training campaign. Supports $filter and $orderby."
  type        = string
  default     = null
}

variable "loginPage" {
  description = "The login page associated with a simulation during its creation."
  type        = any
  default     = null
}

variable "oAuthConsentAppDetail" {
  description = "OAuth app details for the OAuth technique."
  type = object({
    odata_type  = optional(string, "#microsoft.graph.oAuthConsentAppDetail")
    appScope    = optional(string)
    displayLogo = optional(string)
    displayName = optional(string)
  })
  default = null

  validation {
    condition     = (var.oAuthConsentAppDetail == null ? true : alltrue([(var.oAuthConsentAppDetail["appScope"] == null ? true : alltrue([(var.oAuthConsentAppDetail["appScope"] == null ? true : contains(["unknown", "readCalendar", "readContact", "readMail", "readAllChat", "readAllFile", "readAndWriteMail", "sendMail"], var.oAuthConsentAppDetail["appScope"]))]))]))
    error_message = "oAuthConsentAppDetail: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.simulation"
  nullable    = false
}

variable "payload" {
  description = "The payload associated with a simulation during its creation."
  type        = any
  default     = null
}

variable "payloadDeliveryPlatform" {
  description = "Method of delivery of the phishing payload used in the attack simulation and training campaign. The possible values are: unknown, sms, email, teams, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.payloadDeliveryPlatform == null ? true : contains(["unknown", "sms", "email", "teams"], var.payloadDeliveryPlatform)
    error_message = "payloadDeliveryPlatform must be one of the documented enum values."
  }
}

variable "report" {
  description = "Report of the attack simulation and training campaign."
  type = object({
    odata_type = optional(string, "#microsoft.graph.simulationReport")
    overview = optional(object({
      odata_type = optional(string, "#microsoft.graph.simulationReportOverview")
      recommendedActions = optional(list(object({
        odata_type           = optional(string, "#microsoft.graph.recommendedAction")
        actionWebUrl         = optional(string)
        potentialScoreImpact = optional(any)
        title                = optional(string)
      })))
      resolvedTargetsCount = optional(number)
      simulationEventsContent = optional(object({
        odata_type      = optional(string, "#microsoft.graph.simulationEventsContent")
        compromisedRate = optional(any)
        events = optional(list(object({
          odata_type = optional(string, "#microsoft.graph.simulationEvent")
          count      = optional(number)
          eventName  = optional(string)
        })))
      }))
      trainingEventsContent = optional(object({
        odata_type = optional(string, "#microsoft.graph.trainingEventsContent")
        assignedTrainingsInfos = optional(list(object({
          odata_type         = optional(string, "#microsoft.graph.assignedTrainingInfo")
          assignedUserCount  = optional(number)
          completedUserCount = optional(number)
          displayName        = optional(string)
        })))
        trainingsAssignedUserCount = optional(number)
      }))
    }))
    simulationUsers = optional(list(object({
      odata_type               = optional(string, "#microsoft.graph.userSimulationDetails")
      assignedTrainingsCount   = optional(number)
      completedTrainingsCount  = optional(number)
      compromisedDateTime      = optional(string)
      inProgressTrainingsCount = optional(number)
      isCompromised            = optional(bool)
      latestSimulationActivity = optional(string)
      reportedPhishDateTime    = optional(string)
      simulationEvents = optional(list(object({
        odata_type              = optional(string, "#microsoft.graph.userSimulationEventInfo")
        browser                 = optional(string)
        clickSource             = optional(string)
        eventDateTime           = optional(string)
        eventName               = optional(string)
        ipAddress               = optional(string)
        osPlatformDeviceDetails = optional(string)
      })))
      simulationUser = optional(object({
        odata_type      = optional(string, "#microsoft.graph.attackSimulationUser")
        displayName     = optional(string)
        email           = optional(string)
        outOfOfficeDays = optional(number)
        userId          = optional(string)
      }))
      trainingEvents = optional(list(object({
        odata_type                  = optional(string, "#microsoft.graph.userTrainingEventInfo")
        displayName                 = optional(string)
        latestTrainingStatus        = optional(string)
        trainingAssignedProperties  = optional(any)
        trainingCompletedProperties = optional(any)
        trainingUpdatedProperties   = optional(any)
      })))
    })))
  })
  default = null

  validation {
    condition     = (var.report == null ? true : alltrue([(var.report["simulationUsers"] == null ? true : alltrue([alltrue([for input1 in var.report["simulationUsers"] : (input1 == null ? true : alltrue([(input1["simulationEvents"] == null ? true : alltrue([alltrue([for input3 in input1["simulationEvents"] : (input3 == null ? true : alltrue([(input3["clickSource"] == null ? true : alltrue([(input3["clickSource"] == null ? true : contains(["unknown", "qrCode", "phishingUrl"], input3["clickSource"]))]))]))])])), (input1["trainingEvents"] == null ? true : alltrue([alltrue([for input3 in input1["trainingEvents"] : (input3 == null ? true : alltrue([(input3["latestTrainingStatus"] == null ? true : alltrue([(input3["latestTrainingStatus"] == null ? true : contains(["unknown", "assigned", "inProgress", "completed", "overdue"], input3["latestTrainingStatus"]))]))]))])]))]))])]))]))
    error_message = "report: nested required attributes must be non-null and enum values must be supported input members."
  }
}

variable "status" {
  description = "Status of the attack simulation and training campaign. Supports $filter and $orderby. The possible values are: unknown, draft, running, scheduled, succeeded, failed, cancelled, excluded, unknownFutureValue."
  type        = string
  default     = null

  validation {
    condition     = var.status == null ? true : contains(["unknown", "draft", "running", "scheduled", "succeeded", "failed", "cancelled", "excluded"], var.status)
    error_message = "status must be one of the documented enum values."
  }
}

variable "trainingSetting" {
  description = "Details about the training settings for a simulation."
  type        = any
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
