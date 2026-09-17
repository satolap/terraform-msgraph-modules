# /domains/{domain-id}/federationConfiguration

Create internalDomainFederation

[Catalog](../../../../README.md) · [Identity and access](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/internaldomainfederation?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /domains/{domain-id}/federationConfiguration`, `GET/PATCH/DELETE /domains/{domain-id}/federationConfiguration/{internalDomainFederation-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./identity-and-access/domains/by-domain-id/federation-configuration"
  domain_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `domain_id` | URL parameter `domain-id` | `string` | yes | no |
| `active_sign_in_uri` | `activeSignInUri` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `federated_idp_mfa_behavior` | `federatedIdpMfaBehavior` | `any` | no | no |
| `is_signed_authentication_request_required` | `isSignedAuthenticationRequestRequired` | `bool` | no | no |
| `issuer_uri` | `issuerUri` | `string` | no | no |
| `metadata_exchange_uri` | `metadataExchangeUri` | `string` | no | no |
| `next_signing_certificate` | `nextSigningCertificate` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `passive_sign_in_uri` | `passiveSignInUri` | `string` | no | no |
| `password_reset_uri` | `passwordResetUri` | `string` | no | yes |
| `preferred_authentication_protocol` | `preferredAuthenticationProtocol` | `any` | no | no |
| `prompt_login_behavior` | `promptLoginBehavior` | `any` | no | no |
| `sign_out_uri` | `signOutUri` | `string` | no | no |
| `signing_certificate` | `signingCertificate` | `string` | no | no |
| `signing_certificate_update_status` | `signingCertificateUpdateStatus` | `any` | no | no |
| `system_browser_enabled_on` | `systemBrowserEnabledOn` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- federatedIdpMfaBehavior: polymorphic schema; accepts an untyped value
- preferredAuthenticationProtocol: polymorphic schema; accepts an untyped value
- promptLoginBehavior: polymorphic schema; accepts an untyped value
- signingCertificateUpdateStatus: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
