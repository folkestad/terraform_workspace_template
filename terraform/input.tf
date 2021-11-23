variable "env" {
  description = "Environment to deploy infrastructure for"
  type        = string
}

variable "repo" {
  description = "Application code repo"
  type        = string
}

variable "project" {
  description = "Project to deploy infrastructure to"
  type        = string
}

locals {
  labels_mapping = {
    production = {
      environment = "production"
      namespace   = "production"
      repo        = var.repo
      managed-by  = "terraform"
    },
    staging = {
      environment = "staging"
      namespace   = "staging"
      repo        = var.repo
      managed-by  = "terraform"
    },
    test = {
      environment = "test"
      namespace   = "test"
      repo        = var.repo
      managed-by  = "terraform"
      temporary   = "yes"
    }
  }

  labels = local.labels_mapping[terraform.workspace]

  only_in_production_mapping = {
    test       = 0
    staging    = 0
    production = 1
  }

  only_in_production = local.only_in_production_mapping[terraform.workspace]
}