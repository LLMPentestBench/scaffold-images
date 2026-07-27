#!/bin/bash
tmp=$(mktemp)
jq ".provider.[].api_key = \"$1\"" /root/.cache/deadend/config.json > "$tmp"
mv "$tmp" /root/.cache/deadend/config.json
