#!/bin/bash

# Variables
PROJECT_ID="aenzbi-ecommerce"
REGION="us-central1"
SERVICE_NAME="aenzbi-ecommerce-service"
APP_NAME="aenzbi-ecommerce"

# Create Google Cloud project
echo "Creating Google Cloud project..."
gcloud projects create $PROJECT_ID --set-as-default

# Link billing account (replace BILLING_ACCOUNT_ID with your billing account ID)
# Uncomment the line below and replace <BILLING_ACCOUNT_ID>
# gcloud beta billing projects link $PROJECT_ID --billing-account <BILLING_ACCOUNT_ID>

# Enable necessary APIs
echo "Enabling necessary APIs..."
gcloud services enable \
    appengine.googleapis.com \
    cloudbuild.googleapis.com \
    storage-component.googleapis.com \
    bigquery.googleapis.com \
    firestore.googleapis.com

# Initialize App Engine
echo "Initializing App Engine..."
gcloud app create --region=$REGION

# Create a directory for the project
mkdir $APP_NAME
cd $APP_NAME

# Initialize a Node.js project
echo "Initializing Node.js project..."
cat <<EOF > package.json
{
  "name": "$APP_NAME",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
EOF

# Install Express.js
npm install

# Create the main application file
echo "Creating main application file..."
cat <<EOF > index.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Welcome to Aenzbi Ecommerce!');
});

app.listen(PORT, () => {
  console.log(\`Server is running on port \${PORT}\`);
});
EOF

# Create the App Engine configuration file
echo "Creating App Engine configuration file..."
cat <<EOF > app.yaml
runtime: nodejs14
env: standard
EOF

# Deploy to Google Cloud App Engine
echo "Deploying to Google Cloud App Engine..."
gcloud app deploy

# Done
echo "Setup complete! Your e-commerce application is deployed."
