# Create the resource group
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${var.app_name}-rg"
}

# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "${var.app_name}-webapp-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = var.sku_name
  # reserved            = true # Mandatory for Linux plans?
}

resource "azurerm_linux_web_app" "webapp" {
  for_each = var.web_app_configurations

  name                = "${each.value.web_app_name}-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  # https_only            = true
  site_config {
    always_on = each.value.always_on
    application_stack {
      docker_image     = each.value.docker_image
      docker_image_tag = each.value.docker_image_tag
    }
    app_command_line = each.value.app_command_line
  }

  app_settings = each.value.app_settings
  # dynamic "app_settings" {
  #   for_each = each.value.app_settings
  #   iterator = item #optional
  #   content {
  #     name  = item.value.name
  #     value = item.value.value
  #   }
  # storage_account  optional{
  #   access_key   = each.value.storage_account_access_key
  #   account_name = each.value.storage_account_name
  #   name         = "st"
  #   share_name   = each.value.storage_file_share_name
  #   type         = "AzureFiles"

  #   mount_path = each.value.storage_mount_path
  # }
}




#   # application_logs {
#   #   file_system_level = "Warning"
#   # }
# }


# #  Deploy code from a public GitHub repo
# resource "azurerm_app_service_source_control" "sourcecontrol" {
#   app_id             = azurerm_linux_web_app.webapp.id
#   repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
#   branch             = "master"
#   use_manual_integration = true
#   use_mercurial      = false
# }
