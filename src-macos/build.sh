#!/bin/sh
# Ricompila MappAzzone.app e sincronizza index.html + fonts nel bundle.
# Uso: ./build.sh
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SRC")"
APP="/Applications/MappAzzone.app"

swiftc -O -target arm64-apple-macos11 -o "$SRC/MappAzzone-arm64" "$SRC/main.swift" -framework Cocoa -framework WebKit
swiftc -O -target x86_64-apple-macos11 -o "$SRC/MappAzzone-x64" "$SRC/main.swift" -framework Cocoa -framework WebKit
lipo -create "$SRC/MappAzzone-arm64" "$SRC/MappAzzone-x64" -output "$SRC/MappAzzone"
rm "$SRC/MappAzzone-arm64" "$SRC/MappAzzone-x64"

mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources/www/fonts"
cp "$SRC/MappAzzone" "$APP/Contents/MacOS/MappAzzone"
cp "$ROOT/index.html" "$APP/Contents/Resources/www/index.html"
cp "$ROOT/fonts/"*.woff2 "$APP/Contents/Resources/www/fonts/"
touch "$APP"
echo "MappAzzone.app aggiornata"
