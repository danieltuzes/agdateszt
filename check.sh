#!/usr/bin/env bash
set -e

echo "==> Agda típusellenőrzés és tételbizonyítások ellenőrzése (src/Main.agda)..."
agda src/Main.agda
echo "✅ Minden típus és tételbizonyítás sikeresen ellenőrizve!"
