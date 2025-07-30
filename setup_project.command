#!/bin/bash

cd "$(dirname "$0")"
echo "🚀 Starting project setup..."

# Python virtual environment setup
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip

# Install dependencies if requirements.txt exists
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
fi

# Install python-dotenv for .env support
pip install python-dotenv

# Load environment variables from .env if it exists
if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
    echo "✅ Loaded environment variables from .env"
fi

# Git setup
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit"
    echo "✅ Git repository initialized"
fi

# GitHub repo creation and push
read -p "Enter your GitHub repo name (e.g., username/repo): " REPO_NAME
read -p "Enter your GitHub personal access token: " TOKEN

curl -H "Authorization: token $TOKEN" https://api.github.com/user/repos -d '{"name":"'"${REPO_NAME##*/}"'"}'
git remote add origin https://github.com/$REPO_NAME.git
git branch -M main
git push -u origin main
echo "✅ Code pushed to GitHub"

# Firebase CLI setup
if ! command -v firebase &> /dev/null; then
    echo "⚙️ Installing Firebase CLI..."
    npm install -g firebase-tools
fi

# Firebase login and initialization
firebase login
firebase init

# Firebase deploy
firebase deploy
echo "✅ Firebase deployment complete"

echo "🎉 Project setup and deployment complete."
