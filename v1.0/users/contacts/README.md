# /users/{user-id}/contacts

Create new navigation property to contacts for users

[Catalog](../../README.md) Â· [Personal contacts](../../README.md#personal-contacts) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /users/{user-id}/contacts`, `GET/PATCH/DELETE /users/{user-id}/contacts/{contact-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//v1.0/users/contacts"
  version = "<version>"

  user_id = "parent-object-id"
}
```

Replace `<version>` with a release version, such as `1.0.0`; the [GraphModules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `user_id` | URL parameter `user-id` | `string` | yes | no | not replaced or moved: the update targets the existing object; recreate it to move it |
| `assistant_name` | `assistantName` | `string` | no | no | in place |
| `birthday` | `birthday` | `string` | no | no | in place |
| `business_address` | `businessAddress` | `object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     })` | no | no | in place |
| `business_home_page` | `businessHomePage` | `string` | no | no | in place |
| `business_phones` | `businessPhones` | `list(string)` | no | no | in place |
| `categories` | `categories` | `list(string)` | no | no | in place |
| `children` | `children` | `list(string)` | no | no | in place |
| `company_name` | `companyName` | `string` | no | no | in place |
| `created_date_time` | `createdDateTime` | `string` | no | no | in place |
| `department` | `department` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `email_addresses` | `emailAddresses` | `list(object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     }))` | no | no | in place |
| `file_as` | `fileAs` | `string` | no | no | in place |
| `generation` | `generation` | `string` | no | no | in place |
| `given_name` | `givenName` | `string` | no | no | in place |
| `home_address` | `homeAddress` | `object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     })` | no | no | in place |
| `home_phones` | `homePhones` | `list(string)` | no | no | in place |
| `im_addresses` | `imAddresses` | `list(string)` | no | no | in place |
| `initials` | `initials` | `string` | no | no | in place |
| `job_title` | `jobTitle` | `string` | no | no | in place |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no | in place |
| `manager` | `manager` | `string` | no | no | in place |
| `middle_name` | `middleName` | `string` | no | no | in place |
| `mobile_phone` | `mobilePhone` | `string` | no | no | in place |
| `nick_name` | `nickName` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `office_location` | `officeLocation` | `string` | no | no | in place |
| `other_address` | `otherAddress` | `object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     })` | no | no | in place |
| `parent_folder_id` | `parentFolderId` | `string` | no | no | in place |
| `personal_notes` | `personalNotes` | `string` | no | no | in place |
| `photo` | `photo` | `any` | no | no | in place |
| `primary_email_address` | `primaryEmailAddress` | `object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     })` | no | no | in place |
| `profession` | `profession` | `string` | no | no | in place |
| `secondary_email_address` | `secondaryEmailAddress` | `object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     })` | no | no | in place |
| `spouse_name` | `spouseName` | `string` | no | no | in place |
| `surname` | `surname` | `string` | no | no | in place |
| `tertiary_email_address` | `tertiaryEmailAddress` | `object({       odata_type = optional(string, "#microsoft.graph.emailAddress")       address = optional(string)       name = optional(string)     })` | no | no | in place |
| `title` | `title` | `string` | no | no | in place |
| `yomi_company_name` | `yomiCompanyName` | `string` | no | no | in place |
| `yomi_given_name` | `yomiGivenName` | `string` | no | no | in place |
| `yomi_surname` | `yomiSurname` | `string` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `changeKey`, `extensions`, `id`, `multiValueExtendedProperties`, `singleValueExtendedProperties`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- photo: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
