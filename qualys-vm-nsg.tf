############################
## Qualys Appliance - NSG ##
############################

# Create Security Group to access Qualys
resource "azurerm_network_security_group" "qualys-vm-nsg" {
  depends_on=[azurerm_resource_group.network-rg]

  name                = "${var.qualys_vm_name}-nsg"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "AllowHTTPS"
    description                = "Allow HTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  
  tags = {
    environment = var.environment
  }
}

# Associate the qualys NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "qualys-vm-nsg-association" {
  depends_on=[azurerm_resource_group.network-rg]

  subnet_id                 = azurerm_subnet.network-subnet.id
  network_security_group_id = azurerm_network_security_group.qualys-vm-nsg.id
}