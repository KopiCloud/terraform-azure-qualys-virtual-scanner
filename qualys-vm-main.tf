#############################
## Qualys Appliance - Main ##
#############################

# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "qualys" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an Azure SSH Key
resource "azurerm_ssh_public_key" "qualys" {
  name                = "kopi-qualys-vm-key"
  resource_group_name = azurerm_resource_group.network-rg.name
  location            = azurerm_resource_group.network-rg.location
  public_key          = tls_private_key.qualys.public_key_openssh  

  tags = { 
    application = var.app_name
    environment = var.environment
  }
}

# Save file Locally - Use for Debug
resource "local_file" "qualys" {
  depends_on = [azurerm_ssh_public_key.qualys]
  filename = "kopi-qualys-vm-key.ssh"
  content  = tls_private_key.qualys.private_key_pem
}

# Create Network Card for qualys VM
resource "azurerm_network_interface" "qualys-vm-nic" {
  depends_on=[azurerm_resource_group.network-rg]

  name                = "${var.qualys_vm_name}}-nic"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.network-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = { 
    application = var.app_name
    environment = var.environment
  }
}

# Create Qualys VM with qualys server
resource "azurerm_linux_virtual_machine" "qualys-vm" {
  depends_on=[azurerm_network_interface.qualys-vm-nic]

  location              = azurerm_resource_group.network-rg.location
  resource_group_name   = azurerm_resource_group.network-rg.name
  name                  = var.qualys_vm_name
  network_interface_ids = [azurerm_network_interface.qualys-vm-nic.id]
  size                  = var.qualys_vm_size

  computer_name  = var.qualys_vm_name
  custom_data    = base64encode("PERSCODE=${var.personalization_code}")

  admin_username = var.qualys_admin_username
  admin_ssh_key {
    username   = var.qualys_admin_username
    public_key = azurerm_ssh_public_key.qualys.public_key
  }
  disable_password_authentication = true

  os_disk {
    name                 = "${var.qualys_vm_name}-disk"
    caching              = "None"
    storage_account_type = "StandardSSD_LRS"
  }

  plan {
    publisher = var.image_publisher
    product   = var.image_offer
    name      = var.image_sku
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  tags = {
    application = var.app_name
    environment = var.environment
  }
}

