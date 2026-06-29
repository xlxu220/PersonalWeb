#!/bin/bash
# Double-click to preview xiaolan.in locally.
# Opens the Hugo dev server and your browser at http://localhost:1313

cd "$(dirname "$0")" || exit 1

if ! command -v hugo >/dev/null 2>&1; then
  echo "Hugo isn't installed. Install it once with:  brew install hugo"
  echo "(You need the 'extended' edition — check with: hugo version)"
  read -n 1 -s -r -p "Press any key to close..."
  exit 1
fi

echo "Starting Hugo preview for xiaolan.in..."
echo "When it's running, open: http://localhost:1313"
echo "Press Ctrl+C in this window to stop."
echo

# Open the browser a moment after the server starts
( sleep 2 && open "http://localhost:1313" ) &

hugo server
