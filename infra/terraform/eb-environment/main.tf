terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.31.0"
    }
  }
}


// Uncomment to Run locally
// provider "aws" {
//   shared_config_files      = [""]
//   shared_credentials_files = [""]
//   profile                  = "default"
// }

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "cf-eb" {
  source                            = "git::git@github.com:wemap/infra-delivery.git?ref=cf-eb"
  application                       = var.application
  environment                       = var.environment
  solution_stack                    = var.solution_stack
  vpc                               = var.vpc
  loadbalancer_security_groups      = var.loadbalancer_security_groups
  autoscaling_security_groups       = var.autoscaling_security_groups
  subnets                           = var.subnets
  ssh_access_key                    = var.ssh_access_key
  notification_endpoint             = var.notification_endpoint
  notification_topic_arn            = var.notification_topic_arn
  command_timeout                   = var.command_timeout
  ssh_source_restriction            = var.ssh_source_restriction
  instance_types                    = var.instance_types
  min_instance                      = var.min_instance
  max_instance                      = var.max_instance
  mesure_name                       = var.mesure_name
  statistic                         = var.statistic
  unit                              = var.unit
  upper_threshold                   = var.upper_threshold
  upper_breach_scale_increment      = var.upper_breach_scale_increment
  lower_threshold                   = var.lower_threshold
  lower_breach_scale_increment      = var.lower_breach_scale_increment
  breach_duration                   = var.breach_duration
  period                            = var.period
  healthcheck_endpoint              = var.healthcheck_endpoint
  application_variables             = var.application_variables
  cloudflare_zone_id                = var.cloudflare_zone_id
  subdomain                         = var.subdomain
  allow_overwrite                   = var.allow_overwrite
}