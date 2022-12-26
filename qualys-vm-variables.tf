##################################
## Qualys Appliance - Variables ##
##################################

## Qualys VM Variables

variable "qualys_vm_name" {
  type        = string
  description = "Qualys Virtual Machine Name"
  default     = "kopi-qualys-vm"
}

variable "qualys_vm_size" {
  type        = string
  description = "Qualys Virtual Machine Size"
  default     = "Standard_D2s_v3"
}

variable "qualys_admin_username" {
  type        = string
  description = "Administrator username for Qualys VM"
  default     = "qualyssupport"
}

variable "personalization_code" {
  type        = string
  description = "Qualys Virtual Scanner personalization code"
}

## Images Variables 

variable "image_publisher" {
  type        = string
  description = "Virtual machine image publisher"
  default     = "qualysguard"
}
    
variable "image_offer" {
  type        = string
  description = "Virtual machine image offer"
  default     = "qualys-virtual-scanner"
}

variable "image_sku" {
  type        = string
  description = "Virtual machine image sku"
  default     = "qvsa"
}

variable "image_version" {
  type        = string
  description = "Virtual machine image version"
  default     = "2.7.3102"
}