#!/bin/bash

export EFS_FILE_SYSTEM_ID=$(/opt/elasticbeanstalk/bin/get-config environment | jq -r ."EFS_FILE_SYSTEM_ID")
export EFS_MOUNT_POINT_PATH=$(/opt/elasticbeanstalk/bin/get-config environment | jq -r ."EFS_MOUNT_POINT_PATH")

# Check if both variables are not empty
if [ "$EFS_FILE_SYSTEM_ID" != "null" ] && [ "$EFS_MOUNT_POINT_PATH" != "null" ]; then
    mkdir -p $EFS_MOUNT_POINT_PATH
    mount -t efs -o tls $EFS_FILE_SYSTEM_ID:/ $EFS_MOUNT_POINT_PATH
else
    echo "Either EFS_FILE_SYSTEM_ID or EFS_MOUNT_POINT_PATH are missing"
    echo "Skipping mounting EFS..."
fi
