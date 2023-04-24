module "azure-docker" {
  source = "./modules/azure-docker-web-app-starter"
  # sku_name = 
  docker_registry_url      = ""
  docker_registry_username = ""
  docker_registry_password = ""

  app_name = "nex-work-prod"
  web_app_configurations = {
    "webapp-1" = {

      web_app_name     = "nex-work-prod"
      always_on        = false
      docker_image     = "nginx"
      docker_image_tag = "alpine"
      app_command_line = ""
      app_settings = {
        # addi = {
        url = "asasdadadd"
        # }
        DOCKER_REGISTRY_SERVER_URL      = var.docker_registry_url
        DOCKER_REGISTRY_SERVER_USERNAME = var.docker_registry_username
        DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_registry_password
      }
      # storage_account = {
      # storage_account_access_key = var.storage_account_access_key
      # storage_account_name       = var.storage_account_name
      # storage_file_share_name    = var.storage_file_share_name
      # storage_mount_path         = var.storage_mount_path
      # }

      # app_settings = [
      #   {name = "DOCKER_REGISTRY_SERVER_URL", value = var.docker_registry_url},
      #   {name = "DOCKER_REGISTRY_SERVER_USERNAME", value = var.docker_registry_username},
      #   {name = "DOCKER_REGISTRY_SERVER_PASSWORD", value = var.docker_registry_password},
      #   {name = "rtrte", value = "asdasdsad"},
      # ]

    },
    "webapp-2" = {

      web_app_name     = "nex-work-prod-2"
      always_on        = false
      docker_image     = "nginx"
      docker_image_tag = "alpine"
      app_command_line = ""
      app_settings = {


        DOCKER_REGISTRY_SERVER_URL      = var.docker_registry_url
        DOCKER_REGISTRY_SERVER_USERNAME = var.docker_registry_username
        DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_registry_password
      }
      
    }

    #   # "app-2" = {}
  }
}

# TODO: extend each app setting 
# resource "azurerm_linux_web_app" "webapp" {
#   location            = module.azure-docker.resource_group_location
#   resource_group_name = module.azure-docker.resource_group_name
#   service_plan_id     = module.azure-docker.resource_group_plan_id
#   storage_account {
#     access_key   = var.storage_account_access_key
#     account_name = var.storage_account_name
#     name         = "st"
#     share_name   = var.storage_file_share_name
#     type         = "AzureFiles"
#     mount_path   = "/usr/share/nginx/html"
#   }
# }

# output "test" {
#   value = module.azure-docker.resource_group_id
# }
