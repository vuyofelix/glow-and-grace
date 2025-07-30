#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🔍 Checking for package.json..."
if [ ! -f "package.json" ]; then
    echo "📦 package.json not found. Initializing npm..."
    npm init -y
else
    echo "✅ package.json found."
fi

echo "📥 Installing npm dependencies..."
npm install

echo "🔍 Checking for firebase.json..."
if [ ! -f "firebase.json" ]; then
    echo "⚠️ firebase.json not found. Initializing Firebase..."
    firebase init
else
    echo "✅ firebase.json found."
fi

echo "✅ Firebase setup check complete."
