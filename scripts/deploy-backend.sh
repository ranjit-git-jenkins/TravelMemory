#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../backend"
npm ci
if ! command -v pm2 >/dev/null 2>&1; then
    sudo npm install -g pm2
fi

if pm2 describe travelmemory-backend >/dev/null 2>&1; then
    pm2 restart travelmemory-backend --update-env
else
    pm2 start index.js --name travelmemory-backend
fi

pm2 save

echo "Backend deployment completed"
