#!/usr/bin/env bash
###############################################################################
# Authors: @juanjbrown, @facundovictor
###############################################################################

# Set bash unofficial strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
# set -euo pipefail
# IFS=$'\n\t'

function aws-setprofile() {
    profile=$1
    if [[ -z $profile ]]; then
        profile="$(cat ~/.aws/credentials ~/.aws/config | grep -e "\[" | sed -e 's/profile //g' -e 's/[][]//g' | fzf)"
        [[ -z $profile ]] && echo "Nothing selected" && return 1
    fi
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_DEFAULT_PROFILE AWS_PROFILE
    export AWS_DEFAULT_PROFILE=$profile
    export AWS_PROFILE=$profile
    echo "Set \"$profile\""
}

function aws-setcredentials() {
    creds=$1
    if [[ -z $creds ]]; then
        creds="$(grep -e "\[" ~/.aws/credentials | sed -e 's/[][]//g' | fzf)"
        [ -z "$creds" ] && echo "Nothing selected" && return 1
    fi
    unset region aws_access_key_id aws_secret_access_key
    aws_access_key_id="$(grep -A 4 -i "\[$creds\]" ~/.aws/credentials | grep -i aws_access_key_id | head -1 | awk 'BEGIN {FS="="}{print $2}' | xargs)"
    aws_secret_access_key="$(grep -A 4 -i "\[$creds\]" ~/.aws/credentials | grep -i aws_secret_access_key | head -1 | awk 'BEGIN {FS="="}{print $2}' | xargs)"
    region="$(grep -A 4 -i "\[$creds\]" ~/.aws/credentials | grep -i region | head -1 | awk 'BEGIN {FS="="}{print $2}' | xargs)"
    if [[ -n $aws_access_key_id ]]; then
        unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_DEFAULT_PROFILE AWS_PROFILE
        export AWS_ACCESS_KEY_ID=$aws_access_key_id
        export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
    fi
    if [[ -n $region ]]; then
        unset AWS_DEFAULT_REGION AWS_REGION
        export AWS_REGION=$region
        export AWS_DEFAULT_REGION=$region
    fi
    echo "Set \"$creds\""
}

function aws-assume-profile() {
    profile=$1
    if [[ -z $profile ]]; then
        profile="$(cat ~/.aws/credentials ~/.aws/config | grep -e "\[" | sed -e 's/profile //g' -e 's/[][]//g' | fzf)"
        [[ -z $profile ]] && echo "Nothing selected" && return 1
    fi
    role_arn="$(cat ~/.aws/config | grep -A 1000 -i "profile\ $profile" | grep -i role_arn | head -1 | awk 'BEGIN {FS="="}{print $2}' | xargs)"
    [[ -z $role_arn ]] && echo "ROLE_ARN not found" && return 1
    response=`aws sts assume-role --role-arn $role_arn --role-session-name tmp-$profile`
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_DEFAULT_PROFILE AWS_PROFILE
    export AWS_ACCESS_KEY_ID=`jq -r '.Credentials.AccessKeyId' <<< $response`
    export AWS_SECRET_ACCESS_KEY=`jq -r '.Credentials.SecretAccessKey' <<< $response`
    export AWS_SESSION_TOKEN=`jq -r '.Credentials.SessionToken' <<< $response`
}
