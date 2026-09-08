resource "azurerm_linux_virtual_machine" "jumpbox" {
  for_each                        = var.jumpbox
  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication

  network_interface_ids = [
    data.azurerm_network_interface.net_front.id
  ]

  dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
      name                 = os_disk.value.name
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
      disk_size_gb         = os_disk.value.disk_size_gb

    }

  }
  identity {
    type = "SystemAssigned"
  }

  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
  custom_data = base64encode(<<-EOF
              #!/bin/bash
              set -e
              curl -sL https://aka.ms/InstallAzureCLIDeb | bash
              az aks install-cli
              Az login --identity
              EOF
  )
}

