# /education/schools

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `classes`, `users`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create educationSchool

[Catalog](../../README.md) Â· [Education](../../README.md#education) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/educationschool?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /education/schools`, `GET/PATCH/DELETE /education/schools/{educationSchool-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/education/schools"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `1.0.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

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
| `address` | `address` | `object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     })` | no | no | in place |
| `administrative_unit` | `administrativeUnit` | `any` | no | no | in place |
| `classes` | `classes` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationCategory")       displayName = optional(string)     })))       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(string)       addedStudentAction = optional(string)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       modules = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationModule")       description = optional(string)       displayName = optional(string)       isPinned = optional(bool)       languageTag = optional(string)       resources = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       teachers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     }))` | no | yes | in place |
| `created_by` | `createdBy` | `any` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `display_name` | `displayName` | `string` | no | no | in place |
| `external_id` | `externalId` | `string` | no | no | in place |
| `external_principal_id` | `externalPrincipalId` | `string` | no | no | in place |
| `external_source` | `externalSource` | `string` | no | no | in place |
| `external_source_detail` | `externalSourceDetail` | `string` | no | no | in place |
| `fax` | `fax` | `string` | no | no | in place |
| `highest_grade` | `highestGrade` | `string` | no | no | in place |
| `lowest_grade` | `lowestGrade` | `string` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `phone` | `phone` | `string` | no | no | in place |
| `principal_email` | `principalEmail` | `string` | no | no | in place |
| `principal_name` | `principalName` | `string` | no | no | in place |
| `school_number` | `schoolNumber` | `string` | no | no | in place |
| `users` | `users` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(string)       addedStudentAction = optional(string)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       businessPhones = optional(list(string))       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.relatedContact")       accessConsent = optional(bool)       displayName = optional(string)       emailAddress = optional(string)       id = optional(string)       mobilePhone = optional(string)       relationship = optional(string)     })))       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       rubrics = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationRubric")       description = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       displayName = optional(string)       grading = optional(any)       levels = optional(any)       qualities = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes | in place |
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

Server-assigned properties in `response`: `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /education/schools` | DelegatedWork | Unknown / not annotated | — |
| `POST /education/schools` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /education/schools` | Application | `EduRoster.ReadWrite.All` | — |
| `GET /education/schools/{educationSchool-id}` | DelegatedWork | `EduRoster.ReadBasic` | — |
| `GET /education/schools/{educationSchool-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /education/schools/{educationSchool-id}` | Application | `EduRoster.Read.All` | — |
| `GET /education/schools/{educationSchool-id}` | Application | `EduRoster.ReadWrite.All` | — |
| `PATCH /education/schools/{educationSchool-id}` | DelegatedWork | Unknown / not annotated | — |
| `PATCH /education/schools/{educationSchool-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /education/schools/{educationSchool-id}` | Application | `EduRoster.ReadWrite.All` | — |
| `DELETE /education/schools/{educationSchool-id}` | DelegatedWork | Unknown / not annotated | — |
| `DELETE /education/schools/{educationSchool-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /education/schools/{educationSchool-id}` | Application | `EduRoster.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- administrativeUnit: navigation property; accepts an untyped value
- classes[].assignmentDefaults: navigation property; accepts an untyped value
- classes[].assignmentSettings: navigation property; accepts an untyped value
- classes[].assignments[].addToCalendarAction: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: studentsOnly; excluded from typed input validation
- classes[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- classes[].assignments[].grading: polymorphic schema; accepts an untyped value
- classes[].assignments[].gradingCategory: navigation property; accepts an untyped value
- classes[].assignments[].gradingScheme: navigation property; accepts an untyped value
- classes[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].assignments[].rubric: navigation property; accepts an untyped value
- classes[].createdBy: polymorphic schema; accepts an untyped value
- classes[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- classes[].group: navigation property; accepts an untyped value
- classes[].members[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].classes[]: recursive schema; accepts an untyped value
- classes[].members[].createdBy: polymorphic schema; accepts an untyped value
- classes[].members[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- classes[].members[].primaryRole: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: faculty; excluded from typed input validation
- classes[].members[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].taughtClasses[]: recursive schema; accepts an untyped value
- classes[].members[].user: polymorphic schema; accepts an untyped value
- classes[].modules[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].schools[].administrativeUnit: navigation property; accepts an untyped value
- classes[].schools[].classes[]: recursive schema; accepts an untyped value
- classes[].schools[].createdBy: polymorphic schema; accepts an untyped value
- classes[].schools[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- classes[].schools[].users[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].classes[]: recursive schema; accepts an untyped value
- classes[].teachers[].createdBy: polymorphic schema; accepts an untyped value
- classes[].teachers[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- classes[].teachers[].primaryRole: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: faculty; excluded from typed input validation
- classes[].teachers[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].taughtClasses[]: recursive schema; accepts an untyped value
- classes[].teachers[].user: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- users[].assignments[].addToCalendarAction: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: studentsOnly; excluded from typed input validation
- users[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- users[].assignments[].grading: polymorphic schema; accepts an untyped value
- users[].assignments[].gradingCategory: navigation property; accepts an untyped value
- users[].assignments[].gradingScheme: navigation property; accepts an untyped value
- users[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- users[].assignments[].rubric: navigation property; accepts an untyped value
- users[].classes[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- users[].classes[].assignmentDefaults: navigation property; accepts an untyped value
- users[].classes[].assignmentSettings: navigation property; accepts an untyped value
- users[].classes[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- users[].classes[].createdBy: polymorphic schema; accepts an untyped value
- users[].classes[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- users[].classes[].group: navigation property; accepts an untyped value
- users[].classes[].members[]: recursive schema; accepts an untyped value
- users[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- users[].classes[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- users[].classes[].teachers[]: recursive schema; accepts an untyped value
- users[].createdBy: polymorphic schema; accepts an untyped value
- users[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- users[].primaryRole: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: faculty; excluded from typed input validation
- users[].rubrics[].grading: polymorphic schema; accepts an untyped value
- users[].rubrics[].levels[]: nested schema exceeds depth limit; accepts an untyped value
- users[].rubrics[].qualities[]: nested schema exceeds depth limit; accepts an untyped value
- users[].schools[].administrativeUnit: navigation property; accepts an untyped value
- users[].schools[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- users[].schools[].createdBy: polymorphic schema; accepts an untyped value
- users[].schools[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- users[].schools[].users[]: recursive schema; accepts an untyped value
- users[].taughtClasses[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- users[].taughtClasses[].assignmentDefaults: navigation property; accepts an untyped value
- users[].taughtClasses[].assignmentSettings: navigation property; accepts an untyped value
- users[].taughtClasses[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- users[].taughtClasses[].createdBy: polymorphic schema; accepts an untyped value
- users[].taughtClasses[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- users[].taughtClasses[].group: navigation property; accepts an untyped value
- users[].taughtClasses[].members[]: recursive schema; accepts an untyped value
- users[].taughtClasses[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- users[].taughtClasses[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- users[].taughtClasses[].teachers[]: recursive schema; accepts an untyped value
- users[].user: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
