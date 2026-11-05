#!/bin/bash
# Installs (or updates) Stash: downloads the latest build, puts it in Applications and opens it.
set -euo pipefail
URL="https://github.com/Brady-Agranoff/stash-releases/releases/latest/download/Stash.zip"
DEST="/Applications"
[ -w "$DEST" ] || { DEST="$HOME/Applications"; mkdir -p "$DEST"; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
echo "Downloading Stash…"
curl -fsSL "$URL" -o "$TMP/Stash.zip"
ditto -x -k "$TMP/Stash.zip" "$TMP"

pkill -x Stash 2>/dev/null && sleep 1 || true
rm -rf "$DEST/Stash.app"
mv "$TMP/Stash.app" "$DEST/Stash.app"
xattr -dr com.apple.quarantine "$DEST/Stash.app" 2>/dev/null || true
open "$DEST/Stash.app"
echo "Stash is installed in $DEST and running in your menu bar. It updates itself from now on."
echo "Can't see the menu bar icon? Open Stash again (Spotlight: Stash) to get to Settings, or press ⌥⌘V then ⌘,."
