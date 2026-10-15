#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../../backend"
npm ci
npm install -g pm2
pm run 2>/dev/null || true
pm2 start index.js --name travelmemory-backend
pm2 save
