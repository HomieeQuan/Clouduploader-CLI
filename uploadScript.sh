#!/bin/bash

# Load environment variables from the .env file
export $(grep -v '^#' .env | xargs)

# Ensure required environment variables are set
if [ -z "$AZURE_CLIENT_ID" ] || [ -z "$AZURE_CLIENT_SECRET" ] || [ -z "$AZURE_TENANT_ID" ]; then
  echo "Please set AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, and AZURE_TENANT_ID in the .env file."
  exit 1
fi

# Authenticate using service principal
az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID

# Check if the login was successful
if [ $? -ne 0 ]; then
  echo "Azure login failed"
  exit 1
fi

# Perform a test operation, such as listing storage accounts
echo "Azure login successful. Listing storage accounts..."
az storage account list --output table