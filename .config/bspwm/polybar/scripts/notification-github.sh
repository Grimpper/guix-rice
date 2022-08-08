#!/bin/sh

USER="Grimpper"
# You can get your Personal access tokens from here : https://github.com/settings/tokens #
TOKEN="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"

notifications=$(echo "user = \"$USER:$TOKEN\"" | curl -sf -K- https://api.github.com/notifications | jq ".[].unread" | grep -c true)

echo "%{T3} $notifications"

