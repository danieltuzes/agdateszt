#!/usr/bin/env bash
set -e

echo "==> Agda kód fordítása JavaScriptre (src/Hello.agda)..."
mkdir -p dist
agda --js --compile-dir=dist src/Hello.agda

echo "==> Program futtatása Node.js környezetben..."
AGDA_DATA_DIR="$(agda --print-agda-dir)"
NODE_PATH="dist:${AGDA_DATA_DIR}/JS" node -e 'require("./dist/jAgda.Hello.js")'

