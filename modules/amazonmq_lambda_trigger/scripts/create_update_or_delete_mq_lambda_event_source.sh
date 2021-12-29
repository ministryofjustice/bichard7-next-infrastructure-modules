#!/bin/bash

set -e

function matches_condition {
  local trigger_uuid=$1
  local wait_condition=$2

  match=$(aws lambda get-event-source-mapping \
    --uuid "$trigger_uuid" | \
    jq -r "select(.State == \"$wait_condition\") | .UUID")

  if [[ -z "$match" ]]; then
    return 1
  else
    return 0
  fi
}

function wait_for_trigger_if {
  local trigger_uuid=$1
  local wait_condition=$2

  until ! matches_condition "$trigger_uuid" "$wait_condition"; do
    echo "Waiting for trigger $trigger_uuid to finish $wait_condition..."
    sleep 3
  done

  echo "Trigger $trigger_uuid is no longer in '$wait_condition' state"
}

function get_trigger_uuid {
  local function_arn=$1
  local queue_name=$2

  aws lambda list-event-source-mappings \
    --function-name "$function_arn" | \
    jq -r "try .EventSourceMappings[0] | select(.Queues[] == \"$queue_name\") | .UUID"
}

function create_trigger {
  local mq_arn=$1
  local function_arn=$2
  local amq_secret_arn=$3
  local queue_name=$4
  local batch_size=$5

  trigger_uuid=$(get_trigger_uuid "$function_arn" "$queue_name")

  if [[ -n "$trigger_uuid" ]]; then
    wait_for_trigger_if "$trigger_uuid" "Deleting"
  fi

  echo "Creating lambda event trigger..."
  aws lambda create-event-source-mapping \
    --event-source-arn "$mq_arn" \
    --function-name "$function_arn" \
    --source-access-configuration Type=BASIC_AUTH,URI="$amq_secret_arn" \
    --queues "$queue_name" \
    --batch-size $batch_size \
    --enabled
}

function should_update {
  local tigger_uuid=$1
  local function_arn=$2
  local amq_secret_arn=$3
  local batch_size=$4

  local resource=$(aws lambda get-event-source-mapping \
    --uuid "$trigger_uuid" | \
    jq -r ".EventSourceMappings[0]")

  echo $resource | jq -r " \
        .FunctionArn != \"$function_arn\" or \
        .SourceAccessConfigurations[].URI != \"$amq_secret_arn\" or \
        .BatchSize != $batch_size"
}

function update_trigger {
  local trigger_uuid=$1
  local function_arn=$2
  local amq_secret_arn=$3
  local batch_size=$4

  wait_for_trigger_if "$trigger_uuid" "Creating"
  wait_for_trigger_if "$trigger_uuid" "Updating"

  local shouldUpdateResult=$(should_update "$trigger_uuid" "$function_arn" "$amq_secret_arn" "$batch_size")

  if [[ "${shouldUpdateResult}" = "true" ]]
  then
    echo "Updating lambda event trigger..."
    aws lambda update-event-source-mapping \
      --uuid "$trigger_uuid" \
      --function-name "$function_arn" \
      --source-access-configuration Type=BASIC_AUTH,URI="$amq_secret_arn" \
      --batch-size $batch_size \
      --enabled
  else
    echo "Lambda event trigger $trigger_uuid has not changed"
  fi
}

function delete_trigger {
  local function_name=$1
  local queue_name=$2

  trigger_uuid=$(get_trigger_uuid "$function_name" "$queue_name")

  if [[ -n "$trigger_uuid" ]]; then
    wait_for_trigger_if "$trigger_uuid" "Creating"
    wait_for_trigger_if "$trigger_uuid" "Updating"

    echo "Deleting lambda event trigger..."
    aws lambda delete-event-source-mapping \
      --uuid "$trigger_uuid"
  fi
}

region_id=$1
role_arn=$2
mq_arn=$3
function_arn=$4
amq_secret_arn=$5
queue_name=$6
should_delete=$8

batch_size=20

role_session_name=$(echo "$queue_name" | sed "s/_/-/g" | awk '{print tolower($0)}')

credentials=($(aws sts assume-role \
  --role-arn "$role_arn" \
  --role-session-name "$role_session_name-event-listener" \
  --query "[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]" \
  --output text \
))

unset AWS_PROFILE
unset AWS_SECURITY_TOKEN
export AWS_DEFAULT_REGION=$region_id
export AWS_ACCESS_KEY_ID="${credentials[0]}"
export AWS_SECRET_ACCESS_KEY="${credentials[1]}"
export AWS_SESSION_TOKEN="${credentials[2]}"

if [[ "$should_delete" = "delete" ]]; then
  delete_trigger "$function_arn" "$queue_name"
else
  trigger_uuid=$(get_trigger_uuid "$function_arn" "$queue_name")

  if [[ -n "$trigger_uuid" ]] && ! matches_condition "$trigger_uuid" "Deleting"; then
    update_trigger "$trigger_uuid" "$function_arn" "$amq_secret_arn" $batch_size
  else
    create_trigger "$mq_arn" "$function_arn" "$amq_secret_arn" "$queue_name" $batch_size
  fi
fi
