#!/bin/bash

set -e

exec 3>&1
exec 1>&2

set +e
FASTLANE_OUT=$(bundle exec fastlane run upload_to_play_store_internal_app_sharing package_name:"$3" apk:"$1" json_key:"$2" | tee /dev/tty)
set -e

IAS_URL="${FASTLANE_OUT##*Result: }"

IAS_URL=$(echo "$IAS_URL" | sed -r 's/\x1B\[[0-9;]*[mK]//g')

cat >&3 <<EOF
IAS_URL=$(printf '%q' "$IAS_URL")
EOF

exit $?
