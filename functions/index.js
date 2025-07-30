#!/bin/bash

# Navigate to your functions directory
cd ~/Downloads/glowandgrace/functions || exit

# Step 1: Overwrite index.js with a clean HTTP function
cat <<EOF > index.js
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// ✅ Sample HTTP function
exports.helloWorld = functions.https.onRequest((req, res) => {
  res.send("Hello from Glow & Grace Firebase!");
});
EOF

echo "✅ index.js updated."

# Step 2: Run ESLint with auto-fix
npm run lint -- --fix

# Step 3: Deploy only functions
firebase deploy --only functions

