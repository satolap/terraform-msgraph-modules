variable "changeType" {
  description = "Required. Indicates the type of change in the subscribed resource that raises a change notification. The supported values are: created, updated, deleted. Multiple values can be combined using a comma-separated list. Note:  Drive root item and list change notifications support only the updated changeType. User and group change notifications support updated and deleted changeType. Use updated to receive notifications when user or group is created, updated, or soft deleted. Use deleted to receive notifications when user or group is permanently deleted."
  type        = string
  nullable    = false
}

variable "expirationDateTime" {
  description = "Required. Specifies the date and time when the webhook subscription expires. The time is in UTC, and can be an amount of time from subscription creation that varies for the resource subscribed to. Any value under 45 minutes after the time of the request is automatically set to 45 minutes after the request time. For the maximum supported subscription length of time, see Subscription lifetime."
  type        = string
  nullable    = false
}

variable "notificationUrl" {
  description = "Required. The URL of the endpoint that receives the change notifications. This URL must make use of the HTTPS protocol. Any query string parameter included in the notificationUrl property is included in the HTTP POST request when Microsoft Graph sends the change notifications."
  type        = string
  nullable    = false
}

variable "resource" {
  description = "Required. Specifies the resource that is monitored for changes. Don't include the base URL (https://graph.microsoft.com/v1.0/). See the possible resource path values for each supported resource."
  type        = string
  nullable    = false
}

variable "clientState" {
  description = "Optional. Specifies the value of the clientState property sent by the service in each change notification. The maximum length is 128 characters. The client can check that the change notification came from the service by comparing the value of the clientState property sent with the subscription with the value of the clientState property received with each change notification."
  type        = string
  default     = null
}

variable "encryptionCertificate" {
  description = "Optional. A base64-encoded representation of a certificate with a public key used to encrypt resource data in change notifications. Optional but required when includeResourceData is true."
  type        = string
  default     = null
}

variable "encryptionCertificateId" {
  description = "Optional. A custom app-provided identifier to help identify the certificate needed to decrypt resource data."
  type        = string
  default     = null
}

variable "includeResourceData" {
  description = "Optional. When set to true, change notifications include resource data (such as content of a chat message)."
  type        = bool
  default     = null
}

variable "latestSupportedTlsVersion" {
  description = "Optional. Specifies the latest version of Transport Layer Security (TLS) that the notification endpoint, specified by notificationUrl, supports. The possible values are: v10, v11, v12, v13. For subscribers whose notification endpoint supports a version lower than the currently recommended version (TLS 1.2), specifying this property by a set timeline allows them to temporarily use their deprecated version of TLS before completing their upgrade to TLS 1.2. For these subscribers, not setting this property per the timeline would result in subscription operations failing. For subscribers whose notification endpoint already supports TLS 1.2, setting this property is optional. In such cases, Microsoft Graph defaults the property to v1_2."
  type        = string
  default     = null
}

variable "lifecycleNotificationUrl" {
  description = "Required for Teams resources if  the expirationDateTime value is more than 1 hour from now; optional otherwise. The URL of the endpoint that receives lifecycle notifications, including subscriptionRemoved, reauthorizationRequired, and missed notifications. This URL must make use of the HTTPS protocol. For more information, see Reduce missing subscriptions and change notifications."
  type        = string
  default     = null
}

variable "notificationQueryOptions" {
  description = "Optional. OData query options for specifying value for the targeting resource. Clients receive notifications when resource reaches the state matching the query options provided here. With this new property in the subscription creation payload along with all existing properties, Webhooks deliver notifications whenever a resource reaches the desired state mentioned in the notificationQueryOptions property. For example, when the print job is completed or when a print job resource isFetchable property value becomes true etc.  Supported only for Universal Print Service. For more information, see Subscribe to change notifications from cloud printing APIs using Microsoft Graph."
  type        = string
  default     = null
}

variable "notificationUrlAppId" {
  description = "Optional. The app ID that the subscription service can use to generate the validation token. The value allows the client to validate the authenticity of the notification received."
  type        = string
  default     = null
}

variable "odata_type" {
  description = "Microsoft Graph @odata.type property."
  type        = string
  default     = "#microsoft.graph.subscription"
  nullable    = false
}

variable "vapidPublicKey" {
  description = "Optional. The application server's VAPID public key, base64url-encoded (P-256 uncompressed point, 65 bytes pre-encoding). Obtained by calling the getVapidPublicKey function on the subscription collection. The browser passes this value to PushManager.subscribe({ applicationServerKey: vapidPublicKey }) to bind the push subscription to this server identity. Required when notificationUrl targets a known Web Push service origin (for example, *.push.apple.com, fcm.googleapis.com, updates.push.services.mozilla.com); rejected with 400 Bad Request if supplied on a standard webhook subscription. For more information, see RFC 8292."
  type        = string
  default     = null
}

variable "webPushEncryptionP256dhPublicKey" {
  description = "Optional. The subscriber's ECDH public key, base64url-encoded (P-256 uncompressed point, 65 bytes pre-encoding). Obtained from the browser via PushSubscription.getKey('p256dh'). Used as the peer public key during ECDH key agreement to derive the per-message content encryption key for RFC 8291 payload encryption. Required when notificationUrl targets a known Web Push service origin; rejected with 400 Bad Request if supplied on a standard webhook subscription. For more information, see RFC 8291 Section 3."
  type        = string
  default     = null
}

variable "webPushEncryptionSecret" {
  description = "Optional. The subscriber's auth secret, base64url-encoded (16 bytes pre-encoding). Obtained from the browser via PushSubscription.getKey('auth'). Used as the HMAC-SHA-256 salt for the HKDF combine step that derives key material for RFC 8291 payload encryption. Write-only: this value is never returned in GET responses (returned as null). Treat as a secret. Required when notificationUrl targets a known Web Push service origin; rejected with 400 Bad Request if supplied on a standard webhook subscription. For more information, see RFC 8291 Section 3."
  type        = string
  default     = null
  sensitive   = true
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
    condition     = can(keys(var.additional_properties)) ? alltrue([for key in keys(var.additional_properties) : !contains(["applicationId", "creatorId", "id"], key)]) : false
    error_message = "additional_properties must be an object without documented read-only properties."
  }
}
