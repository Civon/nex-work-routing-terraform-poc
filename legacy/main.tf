# Create the resource group
resource "azurerm_resource_group" "webapp" {
  location = var.resource_group_location
  name     = "${var.app_name}-rg"
}

# Create the Linux App Service Plan
resource "azurerm_service_plan" "webapp" {
  name                = "${var.app_name}-webapp-asp"
  location            = azurerm_resource_group.webapp.location
  resource_group_name = azurerm_resource_group.webapp.name
  os_type             = "Linux"
  sku_name            = "B1" # $12.41/month
  # reserved            = true # Mandatory for Linux plans
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.app_name}-webapp"
  location            = azurerm_resource_group.webapp.location
  resource_group_name = azurerm_resource_group.webapp.name
  service_plan_id     = azurerm_service_plan.webapp.id
  # https_only            = true
  site_config {
    always_on = false # must be explicitly set to false when using Free, F1, D1, or Shared Service Plans.
    application_stack {
      docker_image     = "nginx"
      docker_image_tag = "alpine"
    }
    # app_command_line = "-v /home/site/wwwroot/docker-mount:/var/lib/ghost"
  }

  app_settings = {
    # /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = var.docker_registry_url
    DOCKER_REGISTRY_SERVER_USERNAME = var.docker_registry_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_registry_password
    # */

    # url = "https://${var.app_name}-webapp.azurewebsites.net"
  }
  # storage_account {
  #   access_key   = var.storage_account_access_key
  #   account_name = var.storage_account_name
  #   share_name   = "mlab-image-staging"
  #   name         = "st"
  #   type         = "AzureFiles"
  #   mount_path   = "/usr/share/nginx/html"
  # }
    storage_account {
    access_key   = var.storage_account_access_key
    account_name = var.storage_account_name
    share_name   = "nex-work-config"
    name         = "cfg"
    type         = "AzureFiles"
    mount_path   = "/etc/nginx"
  }
    storage_account {
    access_key   = var.storage_account_access_key
    account_name = var.storage_account_name
    share_name   = "nex-work-log"
    name         = "log"
    type         = "AzureFiles"
    mount_path   = "/var/log/nginx"
  }

  # application_logs {
  #   file_system_level = "Warning"
  # }
}

resource "azurerm_app_service_custom_hostname_binding" "webapp" {
  hostname            = "work-test.nexf.org"
  app_service_name    = azurerm_linux_web_app.webapp.name
  resource_group_name = azurerm_resource_group.webapp.name
}
#TODO: SSL gernate? 

output "url" {
  value = "https://${var.app_name}-webapp.azurewebsites.net"
}

# #  Deploy code from a public GitHub repo
# resource "azurerm_app_service_source_control" "sourcecontrol" {
#   app_id             = azurerm_linux_web_app.webapp.id
#   repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
#   branch             = "master"
#   use_manual_integration = true
#   use_mercurial      = false
# }
