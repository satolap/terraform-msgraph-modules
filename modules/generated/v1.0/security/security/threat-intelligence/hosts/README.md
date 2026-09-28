# /security/threatIntelligence/hosts

Create new navigation property to hosts for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-host?view=graph-rest-1.0&preserve-view=true)

Generated from Microsoft Graph **v1.0** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/threatIntelligence/hosts`, `GET/PATCH/DELETE /security/threatIntelligence/hosts/{host-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/threat-intelligence/hosts"
  odata_type = "#microsoft.graph.security.hostname"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `odata_type` | `@odata.type` | `string` | yes | no |
| `child_host_pairs` | `childHostPairs` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     }))` | no | no |
| `components` | `components` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostComponent")       category = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)       version = optional(string)     }))` | no | no |
| `cookies` | `cookies` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostCookie")       domain = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)     }))` | no | no |
| `first_seen_date_time` | `firstSeenDateTime` | `string` | no | no |
| `host_pairs` | `hostPairs` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     }))` | no | no |
| `last_seen_date_time` | `lastSeenDateTime` | `string` | no | no |
| `parent_host_pairs` | `parentHostPairs` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     }))` | no | no |
| `passive_dns` | `passiveDns` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(any)       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     }))` | no | no |
| `passive_dns_reverse` | `passiveDnsReverse` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(any)       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     }))` | no | no |
| `ports` | `ports` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPort")       banners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortBanner")       banner = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       scanProtocol = optional(string)       timesObserved = optional(number)     })))       firstSeenDateTime = optional(string)       host = optional(any)       lastScanDateTime = optional(string)       lastSeenDateTime = optional(string)       mostRecentSslCertificate = optional(any)       port = optional(number)       protocol = optional(string)       services = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortComponent")       component = optional(any)       firstSeenDateTime = optional(string)       isRecent = optional(bool)       lastSeenDateTime = optional(string)     })))       status = optional(string)       timesObserved = optional(number)     }))` | no | no |
| `reputation` | `reputation` | `any` | no | no |
| `ssl_certificates` | `sslCertificates` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificate")       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       ports = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificatePort")       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       port = optional(number)     })))       sslCertificate = optional(any)     }))` | no | no |
| `subdomains` | `subdomains` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.subdomain")       firstSeenDateTime = optional(string)       host = optional(any)     }))` | no | no |
| `trackers` | `trackers` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostTracker")       firstSeenDateTime = optional(string)       host = optional(any)       kind = optional(string)       lastSeenDateTime = optional(string)       value = optional(string)     }))` | no | no |
| `whois` | `whois` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults, except for abstract types listed in the generation notes: set their `odata_type` to a concrete type.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- @odata.type: microsoft.graph.security.host is abstract; odata_type has no default and must name a concrete type
- childHostPairs[].childHost: polymorphic schema; accepts an untyped value
- childHostPairs[].parentHost: polymorphic schema; accepts an untyped value
- components[].host: polymorphic schema; accepts an untyped value
- cookies[].host: polymorphic schema; accepts an untyped value
- hostPairs[].childHost: polymorphic schema; accepts an untyped value
- hostPairs[].parentHost: polymorphic schema; accepts an untyped value
- parentHostPairs[].childHost: polymorphic schema; accepts an untyped value
- parentHostPairs[].parentHost: polymorphic schema; accepts an untyped value
- passiveDnsReverse[].artifact: polymorphic schema; accepts an untyped value
- passiveDnsReverse[].parentHost: polymorphic schema; accepts an untyped value
- passiveDns[].artifact: polymorphic schema; accepts an untyped value
- passiveDns[].parentHost: polymorphic schema; accepts an untyped value
- ports[].host: polymorphic schema; accepts an untyped value
- ports[].mostRecentSslCertificate: navigation property; accepts an untyped value
- ports[].services[].component: navigation property; accepts an untyped value
- reputation: navigation property; accepts an untyped value
- sslCertificates[].host: polymorphic schema; accepts an untyped value
- sslCertificates[].sslCertificate: navigation property; accepts an untyped value
- subdomains[].host: polymorphic schema; accepts an untyped value
- trackers[].host: polymorphic schema; accepts an untyped value
- whois: navigation property; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
