#!/bin/bash

set -e


if [[ $ENVIRONMENT == *"prod"* ]]; then
    export CLOUDFLARE_ZONE_ID=$CLOUDFLARE_PROD_ZONE_ID
else
    export CLOUDFLARE_ZONE_ID=$CLOUDFLARE_DEV_ZONE_ID
fi

# Create elasticbeanstalk application independently from environments
modules=("eb-app" "eb-environment")

valid_command=false

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --deploy)
            valid_command=true
            command="apply"
            shift
            ;;
        --destroy)
            valid_command=true
            command="destroy"
            shift
            ;;
        *)
            echo "Invalid option: $key"
            echo "Available options: --deploy, --destroy"
            exit 1
            ;;
    esac
done

if [ "$valid_command" = false ]; then
    echo "Please specify a command: --deploy, --destroy"
    exit 1
fi

if [ "$command" = "destroy" ]; then
    modules=("eb-environment" "eb-app") # Reverse the order of modules for destroy command
fi

for module in "${modules[@]}"; do
    cd "$module"
    echo yes | terragrunt init --terragrunt-non-interactive
    echo yes | terragrunt "$command" --terragrunt-non-interactive
    cd ..
done
