# Integration-test helper: waits, then reads the group back with a fresh GET so
# a test can assert what Graph stored, not only that the group id is unchanged.
# A new run_label replaces the wait, so every read happens after its own delay.
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0"
    }
  }
}

variable "group_id" {
  type = string
}

variable "run_label" {
  type = string
}

variable "delay_seconds" {
  type    = number
  default = 15
}

resource "time_sleep" "settle" {
  create_duration = "${var.delay_seconds}s"

  triggers = {
    group_id  = var.group_id
    run_label = var.run_label
  }
}

data "msgraph_resource" "group" {
  url         = "groups/${var.group_id}"
  api_version = "v1.0"

  query_parameters = {
    "$select" = ["id,groupTypes,mailEnabled,membershipRule,membershipRuleProcessingState"]
  }

  response_export_values = {
    all = "@"
  }

  depends_on = [time_sleep.settle]
}

output "id" {
  value = data.msgraph_resource.group.output.all.id
}

output "group_types" {
  value = try(data.msgraph_resource.group.output.all.groupTypes, [])
}

output "mail_enabled" {
  value = try(data.msgraph_resource.group.output.all.mailEnabled, null)
}

output "membership_rule" {
  value = try(data.msgraph_resource.group.output.all.membershipRule, null)
}

output "membership_rule_processing_state" {
  value = try(data.msgraph_resource.group.output.all.membershipRuleProcessingState, null)
}
