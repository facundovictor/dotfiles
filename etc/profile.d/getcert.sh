#!/usr/bin/env bash

# Print out the details of the fqdn certificate
function getcert () {
	local fqdn="${1:-}"
	echo | \
		openssl s_client -showcerts -servername "$fqdn" -connect "$fqdn":443 2>/dev/null | \
		openssl x509 -inform pem -noout -text
}
