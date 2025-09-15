#!/usr/bin/env bash
set -euo pipefail

# Simple local renderer for templates/catalog-info.yaml.tpl
# Usage:
#   ./render.sh [template_type]
# Examples:
#   ./render.sh service
#   ./render.sh system
#   ./render.sh domain

TEMPLATE_TYPE=${1:-service}
ORG=${ORG:-GofiGeeksOrg}
NAME=${NAME:-ai-assistant}
TITLE=${TITLE:-"🤖 AI Assistant Service"}
DESC=${DESC:-"Backstage template for AI Assistant services"}
TAGS=${TAGS:-"[\"backstage\", \"template\", \"ai\", \"assistant\", \"service\"]"}

# Write a temporary tf to render the templatefile with inputs
cat > main.tf <<'TF'
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

  rendered = templatefile("${path.module}/../software_templates/catalog-info.yaml.tpl", local.data)
}

variable "template_name" { type = string }
variable "template_title" { type = string }
variable "template_description" { type = string }
variable "template_type" { type = string }
variable "template_tags" { type = list(string) }
variable "organization" { type = string }

output "rendered" { value = local.rendered }
TF

# Write tfvars for the chosen type
cat > terraform.tfvars <<TFV
organization         = "${ORG}"
template_type        = "${TEMPLATE_TYPE}"
template_name        = "${NAME}"
template_title       = "${TITLE}"
template_description = "${DESC}"
template_tags        = ${TAGS}
TFV

# Initialize and render
terraform init -input=false -no-color >/dev/null
terraform apply -input=false -auto-approve -no-color >/dev/null
terraform output -raw rendered > rendered.yaml

# Show interesting lines
echo "--- rendered.yaml (steps excerpt) ---"
sed -n '68,110p' rendered.yaml | nl -ba -v 68 -w2 -s': '

echo "\nYAML written to $(pwd)/rendered.yaml"
