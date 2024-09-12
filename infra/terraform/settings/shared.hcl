locals {
    application="${get_env("EB_APP_NAME")}"
    cloudflare_api_token = "${get_env("CLOUDFLARE_API_TOKEN")}"
    backend_bucket_name="wemap-terraform-states-backend"
    aws_region="eu-west-1"
    notification_endpoint="monitoring@getwemap.com"
    notification_topic_arn="arn:aws:sns:eu-west-1:028996598430:WemapApplicationMonitoring"
    min_instance=1
    max_instance=2
    mesure_name="CPUUtilization"
    statistic="Average"
    unit="Percent"
    upper_threshold=40
    upper_breach_scale_increment=1
    lower_threshold=20
    lower_breach_scale_increment=-1
    breach_duration=1
    period=1
    vpc="vpc-1ae08f7f"
    subnets="subnet-6eee7037,subnet-81154ae4,subnet-00e7a377"
    ssh_source_restriction="tcp,22,22,sg-c1b7bca7"
    solution_stack="64bit Amazon Linux 2 v3.6.4 running Docker"
    ssh_access_key="wemap-devops"
    healthcheck_endpoint="/health"
}