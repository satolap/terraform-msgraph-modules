# /security/attackSimulation/simulations

Create simulation

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/simulation?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/attackSimulation/simulations`, `GET/PATCH/DELETE /security/attackSimulation/simulations/{simulation-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/security/security/attack-simulation/simulations?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `attack_technique` | `attackTechnique` | `string` | no | no |
| `attack_type` | `attackType` | `string` | no | no |
| `automation_id` | `automationId` | `string` | no | no |
| `completion_date_time` | `completionDateTime` | `string` | no | no |
| `created_by` | `createdBy` | `object({       odata_type = optional(string, "#microsoft.graph.emailIdentity")       displayName = optional(string)       email = optional(string)       id = optional(string)     })` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `duration_in_days` | `durationInDays` | `number` | no | no |
| `end_user_notification_setting` | `endUserNotificationSetting` | `any` | no | no |
| `excluded_account_target` | `excludedAccountTarget` | `any` | no | no |
| `included_account_target` | `includedAccountTarget` | `any` | no | no |
| `is_automated` | `isAutomated` | `bool` | no | no |
| `landing_page` | `landingPage` | `any` | no | no |
| `last_modified_by` | `lastModifiedBy` | `object({       odata_type = optional(string, "#microsoft.graph.emailIdentity")       displayName = optional(string)       email = optional(string)       id = optional(string)     })` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `launch_date_time` | `launchDateTime` | `string` | no | no |
| `login_page` | `loginPage` | `any` | no | no |
| `o_auth_consent_app_detail` | `oAuthConsentAppDetail` | `object({       odata_type = optional(string, "#microsoft.graph.oAuthConsentAppDetail")       appScope = optional(string)       displayLogo = optional(string)       displayName = optional(string)     })` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `payload` | `payload` | `any` | no | no |
| `payload_delivery_platform` | `payloadDeliveryPlatform` | `string` | no | no |
| `report` | `report` | `object({       odata_type = optional(string, "#microsoft.graph.simulationReport")       overview = optional(object({       odata_type = optional(string, "#microsoft.graph.simulationReportOverview")       recommendedActions = optional(list(object({       odata_type = optional(string, "#microsoft.graph.recommendedAction")       actionWebUrl = optional(string)       potentialScoreImpact = optional(any)       title = optional(string)     })))       resolvedTargetsCount = optional(number)       simulationEventsContent = optional(object({       odata_type = optional(string, "#microsoft.graph.simulationEventsContent")       compromisedRate = optional(any)       events = optional(list(object({       odata_type = optional(string, "#microsoft.graph.simulationEvent")       count = optional(number)       eventName = optional(string)     })))     }))       trainingEventsContent = optional(object({       odata_type = optional(string, "#microsoft.graph.trainingEventsContent")       assignedTrainingsInfos = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedTrainingInfo")       assignedUserCount = optional(number)       completedUserCount = optional(number)       displayName = optional(string)     })))       trainingsAssignedUserCount = optional(number)     }))     }))       simulationUsers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.userSimulationDetails")       assignedTrainingsCount = optional(number)       completedTrainingsCount = optional(number)       compromisedDateTime = optional(string)       inProgressTrainingsCount = optional(number)       isCompromised = optional(bool)       reportedPhishDateTime = optional(string)       simulationEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.userSimulationEventInfo")       browser = optional(string)       clickSource = optional(string)       eventDateTime = optional(string)       eventName = optional(string)       ipAddress = optional(string)       osPlatformDeviceDetails = optional(string)     })))       simulationUser = optional(object({       odata_type = optional(string, "#microsoft.graph.attackSimulationUser")       displayName = optional(string)       email = optional(string)       userId = optional(string)     }))       trainingEvents = optional(list(object({       odata_type = optional(string, "#microsoft.graph.userTrainingEventInfo")       displayName = optional(string)       latestTrainingStatus = optional(string)       trainingAssignedProperties = optional(any)       trainingCompletedProperties = optional(any)       trainingUpdatedProperties = optional(any)     })))     })))     })` | no | no |
| `status` | `status` | `string` | no | no |
| `training_setting` | `trainingSetting` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- endUserNotificationSetting: polymorphic schema; accepts an untyped value
- excludedAccountTarget: polymorphic schema; accepts an untyped value
- includedAccountTarget: polymorphic schema; accepts an untyped value
- landingPage: navigation property; accepts an untyped value
- loginPage: navigation property; accepts an untyped value
- payload: navigation property; accepts an untyped value
- report.overview.recommendedActions[].potentialScoreImpact: polymorphic schema; accepts an untyped value
- report.overview.simulationEventsContent.compromisedRate: polymorphic schema; accepts an untyped value
- report.simulationUsers[].trainingEvents[].trainingAssignedProperties: nested schema exceeds depth limit; accepts an untyped value
- report.simulationUsers[].trainingEvents[].trainingCompletedProperties: nested schema exceeds depth limit; accepts an untyped value
- report.simulationUsers[].trainingEvents[].trainingUpdatedProperties: nested schema exceeds depth limit; accepts an untyped value
- trainingSetting: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
