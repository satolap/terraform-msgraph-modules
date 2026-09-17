# /security/threatIntelligence/hostPorts

Create new navigation property to hostPorts for security

[Catalog](../../../../README.md) · [Security](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-hostport?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/threatIntelligence/hostPorts`, `GET/PATCH/DELETE /security/threatIntelligence/hostPorts/{hostPort-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/threat-intelligence/host-ports"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `banners` | `banners` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortBanner")       banner = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       scanProtocol = optional(string)       timesObserved = optional(number)     }))` | no | no |
| `first_seen_date_time` | `firstSeenDateTime` | `string` | no | no |
| `host` | `host` | `object({       odata_type = optional(string, "#microsoft.graph.security.host")       childHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       components = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostComponent")       category = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)       version = optional(string)     })))       cookies = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostCookie")       domain = optional(string)       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       name = optional(string)     })))       firstSeenDateTime = optional(string)       hostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       lastSeenDateTime = optional(string)       parentHostPairs = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPair")       childHost = optional(any)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       linkKind = optional(string)       parentHost = optional(any)     })))       passiveDns = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(object({       odata_type = optional(string, "#microsoft.graph.security.artifact")     }))       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       passiveDnsReverse = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.passiveDnsRecord")       artifact = optional(object({       odata_type = optional(string, "#microsoft.graph.security.artifact")     }))       collectedDateTime = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       parentHost = optional(any)       recordType = optional(string)     })))       ports = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPort")       banners = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortBanner")       banner = optional(string)       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       scanProtocol = optional(string)       timesObserved = optional(number)     })))       firstSeenDateTime = optional(string)       host = optional(any)       lastScanDateTime = optional(string)       lastSeenDateTime = optional(string)       mostRecentSslCertificate = optional(any)       port = optional(number)       protocol = optional(any)       services = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortComponent")       component = optional(any)       firstSeenDateTime = optional(string)       isRecent = optional(bool)       lastSeenDateTime = optional(string)     })))       status = optional(any)       timesObserved = optional(number)     })))       reputation = optional(any)       sslCertificates = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificate")       firstSeenDateTime = optional(string)       host = optional(any)       lastSeenDateTime = optional(string)       ports = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostSslCertificatePort")       firstSeenDateTime = optional(string)       lastSeenDateTime = optional(string)       port = optional(number)     })))       sslCertificate = optional(any)     })))       subdomains = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.subdomain")       firstSeenDateTime = optional(string)       host = optional(any)     })))       trackers = optional(list(object({       odata_type = optional(string, "#microsoft.graph.security.hostTracker")       firstSeenDateTime = optional(string)       host = optional(any)       kind = optional(string)       lastSeenDateTime = optional(string)       value = optional(string)     })))       whois = optional(any)     })` | no | no |
| `last_scan_date_time` | `lastScanDateTime` | `string` | no | no |
| `last_seen_date_time` | `lastSeenDateTime` | `string` | no | no |
| `most_recent_ssl_certificate` | `mostRecentSslCertificate` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `port` | `port` | `number` | no | no |
| `protocol` | `protocol` | `any` | no | no |
| `services` | `services` | `list(object({       odata_type = optional(string, "#microsoft.graph.security.hostPortComponent")       component = optional(any)       firstSeenDateTime = optional(string)       isRecent = optional(bool)       lastSeenDateTime = optional(string)     }))` | no | no |
| `status` | `status` | `any` | no | no |
| `times_observed` | `timesObserved` | `number` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- host.childHostPairs[].childHost: recursive schema; accepts an untyped value
- host.childHostPairs[].parentHost: recursive schema; accepts an untyped value
- host.components[].host: recursive schema; accepts an untyped value
- host.cookies[].host: recursive schema; accepts an untyped value
- host.hostPairs[].childHost: recursive schema; accepts an untyped value
- host.hostPairs[].parentHost: recursive schema; accepts an untyped value
- host.parentHostPairs[].childHost: recursive schema; accepts an untyped value
- host.parentHostPairs[].parentHost: recursive schema; accepts an untyped value
- host.passiveDnsReverse[].parentHost: recursive schema; accepts an untyped value
- host.passiveDns[].parentHost: recursive schema; accepts an untyped value
- host.ports[].host: recursive schema; accepts an untyped value
- host.ports[].mostRecentSslCertificate: polymorphic schema; accepts an untyped value
- host.ports[].protocol: polymorphic schema; accepts an untyped value
- host.ports[].services[].component: polymorphic schema; accepts an untyped value
- host.ports[].status: polymorphic schema; accepts an untyped value
- host.reputation: polymorphic schema; accepts an untyped value
- host.sslCertificates[].host: polymorphic schema; accepts an untyped value
- host.sslCertificates[].sslCertificate: polymorphic schema; accepts an untyped value
- host.subdomains[].host: recursive schema; accepts an untyped value
- host.trackers[].host: recursive schema; accepts an untyped value
- host.whois: polymorphic schema; accepts an untyped value
- mostRecentSslCertificate: polymorphic schema; accepts an untyped value
- protocol: polymorphic schema; accepts an untyped value
- services[].component: polymorphic schema; accepts an untyped value
- status: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
