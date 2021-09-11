variable "custom_tags" {
  type        = map(string)
  default     = {}
  description = "The custom tags to add on the resource."
}

variable "custom_location" {
  type        = string
  default     = ""
  description = "Specifies a custom location for the resource."
}

variable "custom_name" {
  type        = string
  default     = ""
  description = "Specifies a custom name for the resource."
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the parent resource group name."
}

variable "description" {
  type        = string
  default     = ""
  description = "Resource group description."
}

variable "caf_prefixes" {
  type        = list(string)
  default     = []
  description = "Prefixes to use for caf naming."
}

variable "name_separator" {
  type        = string
  description = "Separator for CAF prefixes in name."
  default     = "-"
}

variable "sku" {
  type    = string
  default = "Standard"
}

variable "sku_tier" {
  type    = string
  default = "Regional"
}

variable "allocation_method" {
  type    = string
  default = "Static"
}

variable "availability_zone" {
  type    = string
  default = "Zone-Redundant"
}

variable "instance_index" {
  type = number
  validation {
    condition     = var.instance_index > 0 && var.instance_index < 100
    error_message = "Must be a 2 dights number."
  }
  description = "Resource type index on the resource group."
}
