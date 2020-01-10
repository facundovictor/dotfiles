#!/usr/bin/env bash
# Reference:
# - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#verify-key-pair-fingerprints

function awsKeyFingerprint () {
    local key_path="${1:-}"
    openssl pkcs8 -in "$key_path" -inform PEM -outform DER -topk8 -nocrypt | openssl sha1 -c
}

function awsKeyFingerprint-third-party () {
    local key_path="${1:-}"
    openssl rsa -in "$key_path" -pubout -outform DER | openssl md5 -c
}

function public_pem_to_ssh_rsa_format () {
    local key_path="${1:-}"
    ssh-keygen -f "$key_path" -i -m PKCS8
}

function ssh_rsa_to_public_pem_format () {
    local key_path="${1:-}"
    ssh-keygen -f "$key_path" -e -m pem
}

function public_key_from_private_key () {
    local key_path="${1?Missing key path}"
    local output_path="${2?Missing destination}"
    local algorithm="${3:-rsa}"

    openssl "$algorithm" -in "$key_path" -pubout > "$output_path"
}

