#!/bin/bash
#
# Tool to parse tsig-keygen generated files and convert into .ini file
# <C> 2026 Juann Antonio Martínez <juanantonio.martinez@upm.es>
#
# Usage: tsig2ini.sh dnsserver [keyfile [inifile]]
#   if "keyfile" is not given, read data from stdin
#   if "inifile" is not declared, send output to stdout
#

usage () {
    echo "$0" usage:
    echo "    tsig2ini.sh dnsserver [keyfile [inifile]]"
    echo "    dnsserver: ip address (not fqdn) of DNS Server"
    echo "    keyfile: tsig-keygen generated file (or stdin)"
    echo "    inifile: certbot compatible .ini data format"
    echo ""
}

infile=""
outfile=""
case $# in
    3 ) outfile=$3; infile=$2 ;;
    2 ) outfile="/dev/stdout"; infile=$2 ;;
    1 ) outfile="/dev/stdout"; infile="/dev/stdin" ;;
    * ) usage; exit 1 ;;
esac

if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    usage
    exit 1
fi

cat "${infile}"| awk '
/key/{ print $2; }
/algorithm/ { print $2; }
/secret/ {print $2;}    
' | read key algorihtm secret 

read -r -d '' ini_data << __EOF
[__KEYNAME__]
# Target DNS server (IPv4 or IPv6 address, not a hostname)
dns_rfc2136_server = __DNS_SERVER__
# Target DNS port
dns_rfc2136_port = 53
# TSIG key name
dns_rfc2136_name = __KEY_NAME__
# TSIG key secret (base64 encoded)
dns_rfc2136_secret = __KEY_SECRET__
# TSIG key algorithm
dns_rfc2136_algorithm = __KEY_ALGORITHM__
# TSIG sign SOA query (optional, default: false)
dns_rfc2136_sign_query = false
__EOF