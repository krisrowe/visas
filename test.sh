#!/bin/bash

ENDPOINT_ID="9139793759981010944"
PROJECT_ID="753056482659"
INPUT_DATA_FILE="INPUT-JSON"
AUTH_METHOD=""
JSON_KEY_FILE="my-sa.json"  # Set the JSON key file name here

# Default URL
URL="https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_ID}/locations/us-central1/endpoints/${ENDPOINT_ID}:predict"

# Process command line arguments
for arg in "$@"; do
    case $arg in
        --use-gateway)
            LB_EXTERNAL_IP="34.36.167.23"
            URL="https://${LB_EXTERNAL_IP}.nip.io/visas"
            INPUT_DATA_FILE="MIN-INPUT-JSON"
            ;;
        --auth=*)
            AUTH_METHOD="${arg#*=}" 
            ;;
        *)
            echo "Invalid argument: $arg" >&2 
            exit 1
            ;;
    esac
done

# Check if auth method is specified
if [ -z "$AUTH_METHOD" ]; then
    echo "Error: --auth argument is required. Valid options: none, self, json" >&2
    exit 1
fi

# Echo auth status
if [ "$AUTH_METHOD" == "none" ]; then
    echo "Invoking API without authentication: [$URL]"
else
    echo "Invoking API with authentication method '$AUTH_METHOD': [$URL]"
fi

set -x
# Construct the curl command
case $AUTH_METHOD in
    none)
        curl -i -X POST -H "Content-Type: application/json" "$URL" -d "@${INPUT_DATA_FILE}"
        ;;
    self)
        AUTH_HEADER="Authorization: Bearer $(gcloud auth print-access-token)"
        echo "Using access token from 'gcloud auth print-access-token'"
        curl -i -X POST -H "Content-Type: application/json" -H "$AUTH_HEADER" "$URL" -d "@${INPUT_DATA_FILE}"
        ;;
    json)
        # Use GOOGLE_APPLICATION_CREDENTIALS environment variable to point to the service account key file
        export GOOGLE_APPLICATION_CREDENTIALS="$JSON_KEY_FILE"
        
        # Obtain the access token using the service account key file
        ACCESS_TOKEN=$(gcloud auth application-default print-access-token)
        
        # Check if token was successfully retrieved
        if [ -z "$ACCESS_TOKEN" ]; then
            echo "Error: Failed to obtain access token." >&2
            exit 1
        fi
        
        # Optionally, you can print the service account email used for debugging
        echo "Using service account: $(gcloud auth list --filter=status:ACTIVE --format='value(account)')"
        echo "Access Token: $ACCESS_TOKEN"  # Note: Be cautious about printing tokens in a production environment
        
        AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"
        curl -i -X POST -H "Content-Type: application/json" -H "$AUTH_HEADER" "$URL" -d "@${INPUT_DATA_FILE}"
        
        # Unset the GOOGLE_APPLICATION_CREDENTIALS variable after use
        unset GOOGLE_APPLICATION_CREDENTIALS
        ;;
    *)
        echo "Invalid auth method: $AUTH_METHOD" >&2
        exit 1
        ;;
esac
