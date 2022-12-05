#!/bin/bash

# shellcheck disable=SC1091

set -e
#set -o errexit
#set -o nounset
#set -o pipefail
#set -o xtrace # Uncomment this line for debugging purpose

if [ ! -z "${FATCONTROLLER_CONFIG:-}" ]; then
  echo "running 'fatcontrollerd start'..."
  /etc/init.d/fatcontrollerd start ${FATCONTROLLER_CONFIG}
fi
