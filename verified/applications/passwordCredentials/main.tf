locals {
  password = merge(
    { displayName = var.displayName },
    { for key, value in { startDateTime = var.startDateTime, endDateTime = var.endDateTime } : key => value if value != null },
  )
}

# A changed creation input or explicit rotation token replaces both actions.
# Case-only changes to the application GUID do not rotate a password.
resource "terraform_data" "identity" {
  input = {
    application_id   = lower(var.application_id)
    password         = local.password
    rotation_trigger = var.rotation_trigger
  }
}

# Never model this as CRUD or PATCH passwordCredentials: Graph generates the
# secret and returns it only in this POST response. Read on the action is a no-op.
resource "msgraph_resource_action" "add" {
  resource_url = "applications/${lower(var.application_id)}"
  action       = "addPassword"
  method       = "POST"
  api_version  = "v1.0"
  body         = { passwordCredential = local.password }

  # Do not export the whole response or the password hint.
  response_export_values = {
    keyId         = "keyId"
    secretText    = "secretText"
    displayName   = "displayName"
    startDateTime = "startDateTime"
    endDateTime   = "endDateTime"
  }

  lifecycle {
    ignore_changes        = all
    replace_triggered_by  = [terraform_data.identity]
    create_before_destroy = true

    postcondition {
      condition     = can(regex("(?i)^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", self.output.keyId))
      error_message = "Graph did not return a usable keyId. Do not re-send addPassword; reconcile the application credentials and saved action state first."
    }
    postcondition {
      condition     = try(alltrue([length(self.output.secretText) >= 16, length(self.output.secretText) <= 64]), false)
      error_message = "Graph did not return the one-time password. It cannot be recovered by GET; reconcile the saved keyId before rotating."
    }
  }
}

# Bind ownership to the keyId in this creation response and an independent GET,
# never to a display-name search. No secret is requested or exported by this read.
# This proof is acquired before registering removal; keyId is the saved identity
# used at destroy, which does not perform another read.
data "msgraph_resource" "verify" {
  url         = msgraph_resource_action.add.resource_url
  api_version = "v1.0"
  query_parameters = {
    "$select" = ["id,passwordCredentials"]
  }
  response_export_values = {
    id                  = "id"
    passwordCredentials = "passwordCredentials[].{keyId: keyId, displayName: displayName, startDateTime: startDateTime, endDateTime: endDateTime}"
  }
}

locals {
  matched = try([
    for credential in data.msgraph_resource.verify.output.passwordCredentials : credential
    if lower(credential.keyId) == lower(msgraph_resource_action.add.output.keyId)
  ], [])
  verified = try(alltrue([
    lower(data.msgraph_resource.verify.output.id) == lower(split("/", msgraph_resource_action.add.resource_url)[1]),
    length(local.matched) == 1,
    local.matched[0].displayName == msgraph_resource_action.add.output.displayName,
    timecmp(local.matched[0].startDateTime, msgraph_resource_action.add.output.startDateTime) == 0,
    timecmp(local.matched[0].endDateTime, msgraph_resource_action.add.output.endDateTime) == 0,
  ]), false)
}

# This is a provider destroy-only action, not a destroy provisioner (Terraform
# skips those with create_before_destroy). Create persists the verified identity
# without sending removePassword. Replacement first registers the new credential,
# then Delete of the old action removes only the old keyId. No collection PATCH,
# parent delete, caller-selected keyId, private key, CLI token or cleanup script.
resource "msgraph_resource_action" "remove" {
  resource_url = msgraph_resource_action.add.resource_url
  action       = "removePassword"
  method       = "POST"
  when         = "destroy"
  api_version  = "v1.0"
  body         = { keyId = try(lower(msgraph_resource_action.add.output.keyId), "") }

  lifecycle {
    ignore_changes        = all
    replace_triggered_by  = [terraform_data.identity]
    create_before_destroy = true

    precondition {
      condition     = local.verified
      error_message = "The application read did not uniquely verify the created keyId, displayName and validity dates. Removal registration fails closed; reconcile the saved action keyId before retrying."
    }
  }
}
