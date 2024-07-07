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



# Usage function
usage() {
    echo "Usage: $0 <storage_account> <container_name> <file_path> <blob_name> <file_name>"
    echo "Example: $0 cloudstoragepractice fileupload-cli <file_path> images <file_name>"
    exit 1
}


# Check if the number of arguments is exactly 5
if [ $# -ne 5 ]; then
    usage
fi

# Parse arguments
STORAGE_ACCOUNT="$1"
CONTAINER_NAME="$2"
FILE_PATH="$3"
BLOB_NAME="$4"
FILE_NAME="$5"
BLOB_PATH="$BLOB_NAME/$FILE_NAME"

# Validate file path
if [ ! -f "$FILE_PATH/$FILE_NAME" ]; then
    echo "Error: File '$FILE_PATH/$FILE_NAME' not found or is not a regular file."
    exit 1
fi

# Upload file to blob storage using Azure CLI as an example
az storage blob upload --account-name "$STORAGE_ACCOUNT" --container-name "$CONTAINER_NAME" --file "$FILE_PATH/$FILE_NAME" --name "$BLOB_PATH"

# Check upload status
if [ $? -eq 0 ]; then
    echo "File '$FILE_NAME' uploaded successfully to blob '$BLOB_PATH'."
else
    echo "Failed to upload file '$FILE_NAME' to blob '$BLOB_PATH'."
fi