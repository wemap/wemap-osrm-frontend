BRANCH="$1"
AWS_DEFAULT_REGION="eu-west-1"
SECRET_FILE_PATH=act/secrets/.github-actions.conf
ENV_FILE_PATH="act/.env"
EVENT_PATH="act/event_payload.json"
PLATFORM_VERSION="3bcb267"
PLATFORM="028996598430.dkr.ecr.eu-west-1.amazonaws.com/wemap-github-runner:$PLATFORM_VERSION"

aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $PLATFORM
SSH_KEY_GITHUB_ACTIONS="$(cat ~/.ssh/DeployKeys/infra-delivery/github_actions_terraform)"


cat <<EOT > act/event_payload.json
{
    "ref": "refs/heads/$BRANCH",
    "ref_name": "$BRANCH",
    "head_commit": {
      "id": "commit_id",
      "message": "commit message",
      "author": {
        "name": "Author Name",
        "email": "author@email.com"
      }
    }
}
EOT

act -P ubuntu-latest=$PLATFORM --secret-file $SECRET_FILE_PATH \
                               --eventpath $EVENT_PATH \
                               --env-file $ENV_FILE_PATH \
                               --workflows ./act/.github/workflows/ci_cd.yml \
                               --secret SSH_KEY_GITHUB_ACTIONS="$SSH_KEY_GITHUB_ACTIONS" \
                               --container-architecture linux/amd64