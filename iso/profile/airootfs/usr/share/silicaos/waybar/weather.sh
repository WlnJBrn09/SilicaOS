#!/bin/bash
# Quiet weather glyph for Waybar. Empty (hidden) when offline.
set -euo pipefail
text=$(curl -fsS --max-time 3 'https://wttr.in/?format=%c' 2>/dev/null || true)
text=${text//$'\n'/}
if [[ -n $text ]]; then
  printf '{"text":"%s","class":"available"}\n' "${text//\"/\\\"}"
else
  printf '{"text":"","class":"unavailable"}\n'
fi
