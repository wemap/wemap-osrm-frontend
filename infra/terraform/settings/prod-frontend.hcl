locals {
    environment = "${get_env("ENVIRONMENT")}"
    cloudflare_zone_id = "${get_env("CLOUDFLARE_ZONE_ID")}"
    instance_types="t2.small"
    subdomain="routing-osrm"
    autoscaling_security_groups="sg-0622ee47c47378eeb"
    application_variables={"PORT": "9966"}
}
