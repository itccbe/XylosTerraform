<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.50.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.50.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_services"></a> [services](#module\_services) | ./modules | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storageaccount](https://registry.terraform.io/providers/hashicorp/azurerm/2.50.0/docs/resources/storage_account) | resource |
| [azurerm_storage_share.azureshare](https://registry.terraform.io/providers/hashicorp/azurerm/2.50.0/docs/resources/storage_share) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.50.0/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.terraform](https://registry.terraform.io/providers/hashicorp/azurerm/2.50.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_abbreviation"></a> [customer\_abbreviation](#input\_customer\_abbreviation) | n/a | `string` | `"itcc"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"devtst"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `"terraform"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->