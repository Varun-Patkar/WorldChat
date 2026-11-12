#!/usr/bin/env bash
# WorldChat - Dev Server Starter Script
# Usage: ./start.sh [project-folder]
#   If project folder is provided, it sets up the dev server for that project.
#   Otherwise, starts the editor app.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_FOLDER="${1:-}"

echo "🎮 WorldChat Editor v0.1.0"
echo "==========================="

if [ -n "$PROJECT_FOLDER" ]; then
  echo "Opening project: $PROJECT_FOLDER"
  # In v1, this would cd into the project folder and launch its dev server
  # For now, we just run the main editor
  cd "$SCRIPT_DIR"
else
  echo "Starting WorldChat Editor..."
fi

# Install dependencies if node_modules is missing
if [ ! -d "node_modules" ]; then
  echo "Installing dependencies (npm install)..."
  npm install
fi

# Start dev server
echo ""
echo "👉 Opening http://localhost:5173 in your browser..."
echo "   Press Ctrl+C to stop the server."
echo ""

npx vite --host 0.0.0.0
