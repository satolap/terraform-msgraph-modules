# /education/schools

Create educationSchool

[Catalog](../../../README.md) · [Education](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/educationschool?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /education/schools`, `GET/PATCH/DELETE /education/schools/{educationSchool-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "git::https://github.com/benhaspalace/GraphModules.git//modules/generated/v1.0/education/education/schools?ref=<release-tag>"
}
```

Replace `<release-tag>` with a `graphmodules-*` release tag; the [GraphModules README](https://github.com/benhaspalace/GraphModules#install-a-module-from-github) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `address` | `address` | `object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     })` | no | no |
| `administrative_unit` | `administrativeUnit` | `any` | no | no |
| `classes` | `classes` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationCategory")       displayName = optional(string)     })))       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(string)       addedStudentAction = optional(string)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       modules = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationModule")       description = optional(string)       displayName = optional(string)       isPinned = optional(bool)       resources = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       teachers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     }))` | no | yes |
| `created_by` | `createdBy` | `any` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `external_id` | `externalId` | `string` | no | no |
| `external_principal_id` | `externalPrincipalId` | `string` | no | no |
| `external_source` | `externalSource` | `string` | no | no |
| `external_source_detail` | `externalSourceDetail` | `string` | no | no |
| `fax` | `fax` | `string` | no | no |
| `highest_grade` | `highestGrade` | `string` | no | no |
| `lowest_grade` | `lowestGrade` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `phone` | `phone` | `string` | no | no |
| `principal_email` | `principalEmail` | `string` | no | no |
| `principal_name` | `principalName` | `string` | no | no |
| `school_number` | `schoolNumber` | `string` | no | no |
| `users` | `users` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(string)       addedStudentAction = optional(string)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       businessPhones = optional(list(string))       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       rubrics = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationRubric")       description = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       displayName = optional(string)       grading = optional(any)       levels = optional(any)       qualities = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)     }))       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- administrativeUnit: navigation property; accepts an untyped value
- classes[].assignmentDefaults: navigation property; accepts an untyped value
- classes[].assignmentSettings: navigation property; accepts an untyped value
- classes[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- classes[].assignments[].grading: polymorphic schema; accepts an untyped value
- classes[].assignments[].gradingCategory: navigation property; accepts an untyped value
- classes[].assignments[].gradingScheme: navigation property; accepts an untyped value
- classes[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].assignments[].rubric: navigation property; accepts an untyped value
- classes[].createdBy: polymorphic schema; accepts an untyped value
- classes[].group: navigation property; accepts an untyped value
- classes[].members[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].classes[]: recursive schema; accepts an untyped value
- classes[].members[].createdBy: polymorphic schema; accepts an untyped value
- classes[].members[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].members[].taughtClasses[]: recursive schema; accepts an untyped value
- classes[].members[].user: polymorphic schema; accepts an untyped value
- classes[].modules[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].schools[].administrativeUnit: navigation property; accepts an untyped value
- classes[].schools[].classes[]: recursive schema; accepts an untyped value
- classes[].schools[].createdBy: polymorphic schema; accepts an untyped value
- classes[].schools[].users[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].classes[]: recursive schema; accepts an untyped value
- classes[].teachers[].createdBy: polymorphic schema; accepts an untyped value
- classes[].teachers[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- classes[].teachers[].taughtClasses[]: recursive schema; accepts an untyped value
- classes[].teachers[].user: polymorphic schema; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
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
- users[].classes[].group: navigation property; accepts an untyped value
- users[].classes[].members[]: recursive schema; accepts an untyped value
- users[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- users[].classes[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- users[].classes[].teachers[]: recursive schema; accepts an untyped value
- users[].createdBy: polymorphic schema; accepts an untyped value
- users[].rubrics[].grading: polymorphic schema; accepts an untyped value
- users[].rubrics[].levels[]: nested schema exceeds depth limit; accepts an untyped value
- users[].rubrics[].qualities[]: nested schema exceeds depth limit; accepts an untyped value
- users[].schools[].administrativeUnit: navigation property; accepts an untyped value
- users[].schools[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- users[].schools[].createdBy: polymorphic schema; accepts an untyped value
- users[].schools[].users[]: recursive schema; accepts an untyped value
- users[].taughtClasses[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- users[].taughtClasses[].assignmentDefaults: navigation property; accepts an untyped value
- users[].taughtClasses[].assignmentSettings: navigation property; accepts an untyped value
- users[].taughtClasses[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- users[].taughtClasses[].createdBy: polymorphic schema; accepts an untyped value
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
