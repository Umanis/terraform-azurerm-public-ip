# Azure Umanis Public IP

[![Build Status](https://dev.azure.com/umanis-consulting/terraform/_apis/build/status/mod_azu_public_ip?repoName=mod_azu_public_ip&branchName=master)](https://dev.azure.com/umanis-consulting/terraform/_build/latest?definitionId=10&repoName=mod_azu_public_ip&branchName=master)[![Unilicence](https://img.shields.io/badge/licence-The%20Unilicence-green)](LICENCE)


Common Azure terraform module to create a Public IP

## Naming
Resource naming is based on the Microsoft CAF naming convention best practices. Custom naming is available by setting the parameter `custom_name`. We rely on the official Terraform Azure CAF naming provider to generate resource names when available.

## Usage
```hcl

module "umanis_tagging" {
  source = "Umanis/tags/azurerm"

  location          = "France Central"
  client            = "XY2"
  project           = "1234"
  budget            = "FE4567"
  rgpd_personal     = true
  rgpd_confidential = false
}

module "umanis_naming" {
  source = "Umanis/naming/azurerm"

  location    = "France Central"
  client      = "XY2"
  project     = "1234"
  area        = 1
  environment = "tst"
}

module "umanis_resource_group" {
  source = "Umanis/resource-group/azurerm"

  tags         = module.umanis_tagging.tags
  location     = "France Central"
  description  = "Test resource group"
  caf_prefixes = module.umanis_naming.resource_group_prefixes
}

module "public_ip" {
  source = "Umanis/public-ip/azurerm"

  resource_group_name = module.umanis_resource_group.name
  description         = "Test public IP"
  caf_prefixes        = module.umanis_naming.resource_prefixes
  instance_index      = 1
}

```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | >= 1.2.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.62.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance_index"></a> [instance\_index](#input\_instance\_index) | Resource type index on the resource group. | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the parent resource group name. | `string` | n/a | yes |
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | n/a | `string` | `"Static"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | `"Zone-Redundant"` | no |
| <a name="input_caf_prefixes"></a> [caf\_prefixes](#input\_caf\_prefixes) | Prefixes to use for caf naming. | `list(string)` | `[]` | no |
| <a name="input_custom_location"></a> [custom\_location](#input\_custom\_location) | Specifies a custom location for the resource. | `string` | `""` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Specifies a custom name for the resource. | `string` | `""` | no |
| <a name="input_custom_tags"></a> [custom\_tags](#input\_custom\_tags) | The custom tags to add on the resource. | `map(string)` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | Resource group description. | `string` | `""` | no |
| <a name="input_name_separator"></a> [name\_separator](#input\_name\_separator) | Separator for CAF prefixes in name. | `string` | `"-"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | n/a | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | n/a | `string` | `"Regional"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | n/a |
<!-- END_TF_DOCS -->

## Related documentation

Terraform Azure public IP documentation: [https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)

Terraform Azure CAF Naming documentation: [https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name)

