#!/bin/bash
certbot certonly \
	-v \
	--dns-rfc2136 \
	--dns-rfc2136-credentials /etc/letsencrypt/certbot-ddns.ini \
	--dns-rfc2136-propagation-seconds 30 \
	--preferred-challenges=dns-01 \
	--server https://acme-v02.harica.gr/acme/e00a95e2-56ff-4cdd-becf-e715cdeb342d/directory \
	--eab-kid  UmXFJrRu5m6xWY02Q2Re \
	--eab-hmac-key KsUtJSl5hsaZqRttNbG0-B_TcuPB6VHQ4t7oEKhDVjI \
	--email juanantonio.martinez@upm.es \
	-d jonsy.dit.upm.es
