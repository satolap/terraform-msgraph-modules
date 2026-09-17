# /bookingBusinesses/{bookingBusiness-id}/services

Create new navigation property to services for bookingBusinesses

[Catalog](../../../../README.md) · [Customer booking](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/bookingservice?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /bookingBusinesses/{bookingBusiness-id}/services`, `GET/PATCH/DELETE /bookingBusinesses/{bookingBusiness-id}/services/{bookingService-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./customer-booking/booking-businesses/by-booking-business-id/services"
  booking_business_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `booking_business_id` | URL parameter `bookingBusiness-id` | `string` | yes | no |
| `additional_information` | `additionalInformation` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `custom_questions` | `customQuestions` | `list(object({       odata_type = optional(string, "#microsoft.graph.bookingQuestionAssignment")       isRequired = optional(bool)       questionId = optional(string)     }))` | no | no |
| `default_duration` | `defaultDuration` | `string` | no | no |
| `default_location` | `defaultLocation` | `any` | no | no |
| `default_price` | `defaultPrice` | `any` | no | no |
| `default_price_type` | `defaultPriceType` | `string` | no | no |
| `default_reminders` | `defaultReminders` | `list(object({       odata_type = optional(string, "#microsoft.graph.bookingReminder")       message = optional(string)       offset = optional(string)       recipients = optional(string)     }))` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `is_anonymous_join_enabled` | `isAnonymousJoinEnabled` | `bool` | no | no |
| `is_customer_allowed_to_manage_booking` | `isCustomerAllowedToManageBooking` | `bool` | no | no |
| `is_hidden_from_customers` | `isHiddenFromCustomers` | `bool` | no | no |
| `is_location_online` | `isLocationOnline` | `bool` | no | no |
| `language_tag` | `languageTag` | `string` | no | no |
| `last_updated_date_time` | `lastUpdatedDateTime` | `string` | no | no |
| `maximum_attendees_count` | `maximumAttendeesCount` | `number` | no | no |
| `notes` | `notes` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `post_buffer` | `postBuffer` | `string` | no | no |
| `pre_buffer` | `preBuffer` | `string` | no | no |
| `scheduling_policy` | `schedulingPolicy` | `any` | no | no |
| `sms_notifications_enabled` | `smsNotificationsEnabled` | `bool` | no | no |
| `staff_member_ids` | `staffMemberIds` | `list(string)` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- defaultLocation: polymorphic schema; accepts an untyped value
- defaultPrice: polymorphic schema; accepts an untyped value
- schedulingPolicy: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
