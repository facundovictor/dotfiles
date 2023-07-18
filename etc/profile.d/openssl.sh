#!/usr/bin/env bash

# References:
# - https://superuser.com/questions/109213/how-do-i-list-the-ssl-tls-cipher-suites-a-particular-website-offers
# - https://superuser.com/a/224263

function test_ciphers () {
    local server="${1:-}"
    echo

    # OpenSSL requires the port number.
    DELAY=1
    ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g')

    echo Obtaining cipher list from $(openssl version).

    for cipher in ${ciphers[@]}; do
        echo -n "Testing $cipher..." ;
        result=$(echo -n | openssl s_client -cipher "$cipher" -connect "$server" 2>&1)
        if [[ "$result" =~ ":error:" ]] ; then
          error=$(echo -n "$result" | cut -d':' -f6)
          echo "NO \($error\)"
        else
          if [[ "$result" =~ "Cipher is ${cipher}" || "$result" =~ "Cipher    :" ]] ; then
            echo YES
          else
            echo UNKNOWN RESPONSE
            echo "$result"
          fi
        fi
        sleep $DELAY
    done
}

function test_ciphers_silent () {
    local server="${1:-}"
    echo

    # OpenSSL requires the port number.
    DELAY=1
    ciphers=$(openssl ciphers 'ALL:eNULL' | sed -e 's/:/ /g')

    echo Obtaining cipher list from $(openssl version).

    for cipher in ${ciphers[@]}; do
        echo -n "Testing $cipher..." ;
        result=$(echo -n | openssl s_client -cipher "$cipher" -connect "$server" 2>&1)
        if [[ "$result" =~ ":error:" ]] ; then
          error=$(echo -n "$result" | cut -d':' -f6)
          echo NO
        else
          if [[ "$result" =~ "Cipher is ${cipher}" || "$result" =~ "Cipher    :" ]] ; then
            echo YES
          else
            echo UNKNOWN RESPONSE
            echo "$result"
          fi
        fi
        sleep $DELAY
    done
}
