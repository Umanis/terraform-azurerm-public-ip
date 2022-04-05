locals {
  specific_tags = {
    "description" = var.description
  }

  location      = coalesce(var.custom_location, data.azurerm_resource_group.parent_group.location)
  parent_tags   = { for n, v in data.azurerm_resource_group.parent_group.tags : n => v if n != "description" }
  resource_name = coalesce(var.custom_name, azurecaf_name.self.result)
  tags          = { for n, v in merge(local.parent_tags, local.specific_tags, var.custom_tags) : n => v if v != "" }
}

data "azurerm_resource_group" "parent_group" {
  name = var.resource_group_name
}

resource "azurecaf_name" "self" {
  name          = format("%02d", var.instance_index)
  resource_type = "azurerm_public_ip"
  prefixes      = var.caf_prefixes
  suffixes      = []
  use_slug      = true
  clean_input   = true
  separator     = var.name_separator
}

resource "azurerm_public_ip" "self" {
  name                = local.resource_name
  resource_group_name = data.azurerm_resource_group.parent_group.name
  location            = data.azurerm_resource_group.parent_group.location
  allocation_method   = var.allocation_method
  zones               = var.zones
  sku_tier            = var.sku_tier
  sku                 = var.sku


  tags = local.tags
}
