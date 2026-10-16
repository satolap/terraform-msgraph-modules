# Accessibility statement

GraphModules is a catalog of Terraform modules and their Markdown documentation. It
has no application interface of its own, so accessibility here means documentation
that works with assistive technology.

## Commitment

Documentation is written in plain Markdown with a logical heading structure,
descriptive link text, and text alternatives for any image or diagram, so that it
renders well in GitHub, the Terraform Registry, screen readers, and the command line.

## Supported environments

The documentation is intended to be read on GitHub and on the
[Terraform Registry](https://registry.terraform.io/modules/satolap/modules/msgraph)
in current versions of major browsers, with or without a screen reader.

## Known limitations

- Generated module READMEs are produced from Microsoft Graph schemas and can contain
  long tables that are harder to navigate with a screen reader.
- GitHub and the Terraform Registry control how Markdown is rendered. Their own
  accessibility limitations apply.

## Report a barrier

Open a [GitHub issue](https://github.com/satolap/terraform-msgraph-modules/issues)
with the page or module path and a description of the barrier and the assistive
technology you use. For a suspected vulnerability, follow [SECURITY.md](SECURITY.md)
instead.
