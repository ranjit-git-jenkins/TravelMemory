#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../frontend"
npm ci
npm run build
sudo mkdir -p /var/www/travelmemory
sudo cp -r build/. /var/www/travelmemory/
echo "Frontend build and deployment completed"
