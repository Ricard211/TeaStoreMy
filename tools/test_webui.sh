#!/bin/bash

# Tests the TeaStore WebUI for working endpoints

HOST=${1}           # usually localhost
PROTO=${2}          # supports 'http' and 'https'
WEBUI_PORT=${3}     # 8080 for http, 8443 for https

# Checks HTML GET response for failure/error for given HTTP URL endpoint
function send_request () {
  URL="${PROTO}://${HOST}:${WEBUI_PORT}/tools.descartes.teastore.webui/${1}"
  RES="$(curl -s "${URL}")"
  if echo "${RES}" | grep -E -i 'error|fail|exception'
  then
    echo "Request for URL '${URL}' failed."
    echo "[START HTML]${RES}[END HTML]"
    exit 1
  fi
}

# Checks HTML POST response for failure/error for given HTTP URL endpoint
function send_request_post () {
  URL="${PROTO}://${HOST}:${WEBUI_PORT}/tools.descartes.teastore.webui/${1}"
  RES=$(curl -X POST -s "${URL}")
  if echo "${RES}" | grep -E -i 'error|fail|exception'
  then
    echo "Request for URL '${URL}' failed."
    echo "[START HTML]${RES}[END HTML]"
    exit 1
  fi
}

send_request
send_request login
send_request_post "loginAction?username=user30&password=password"
send_request profile
