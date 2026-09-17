# /security/attackSimulation/simulations

Create simulation

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/simulation?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/attackSimulation/simulations`, `GET/PATCH/DELETE /security/attackSimulation/simulations/{simulation-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/attack-simulation/simulations"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `attack_technique` | `attackTechnique` | `any` | no | no |
| `attack_type` | `attackType` | `any` | no | no |
| `automation_id` | `automationId` | `string` | no | no |
| `completion_date_time` | `completionDateTime` | `string` | no | no |
| `created_by` | `createdBy` | `any` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `duration_in_days` | `durationInDays` | `number` | no | no |
| `end_user_notification_setting` | `endUserNotificationSetting` | `any` | no | no |
| `excluded_account_target` | `excludedAccountTarget` | `any` | no | no |
| `included_account_target` | `includedAccountTarget` | `any` | no | no |
| `is_automated` | `isAutomated` | `bool` | no | no |
| `landing_page` | `landingPage` | `any` | no | no |
| `last_modified_by` | `lastModifiedBy` | `any` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `launch_date_time` | `launchDateTime` | `string` | no | no |
| `login_page` | `loginPage` | `any` | no | no |
| `o_auth_consent_app_detail` | `oAuthConsentAppDetail` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `payload` | `payload` | `any` | no | no |
| `payload_delivery_platform` | `payloadDeliveryPlatform` | `any` | no | no |
| `report` | `report` | `any` | no | no |
| `status` | `status` | `any` | no | no |
| `training_setting` | `trainingSetting` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- attackTechnique: polymorphic schema; accepts an untyped value
- attackType: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- endUserNotificationSetting: polymorphic schema; accepts an untyped value
- excludedAccountTarget: polymorphic schema; accepts an untyped value
- includedAccountTarget: polymorphic schema; accepts an untyped value
- landingPage: polymorphic schema; accepts an untyped value
- lastModifiedBy: polymorphic schema; accepts an untyped value
- loginPage: polymorphic schema; accepts an untyped value
- oAuthConsentAppDetail: polymorphic schema; accepts an untyped value
- payload: polymorphic schema; accepts an untyped value
- payloadDeliveryPlatform: polymorphic schema; accepts an untyped value
- report: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value
- trainingSetting: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
