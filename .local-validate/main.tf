terraform {
  required_version = ">= 1.6"
}

locals {
  data = {
    template_name        = var.template_name
    template_title       = var.template_title
    template_description = var.template_description
    template_tags        = var.template_tags
    template_type        = var.template_type
    organization         = var.organization
  }

  rendered = templatefile("${path.module}/../templates/catalog-info.yaml.tpl", local.data)
}

variable "template_name" { type = string }
variable "template_title" { type = string }
variable "template_description" { type = string }
variable "template_type" { type = string }
variable "template_tags" { type = list(string) }
variable "organization" { type = string }

output "rendered" { value = local.rendered }
