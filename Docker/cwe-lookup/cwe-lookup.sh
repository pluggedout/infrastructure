#!/bin/bash

# Function to output JSON error and exit
error_exit() {
  local message="$1"
  printf '{"error": "%s"}\n' "$message"
  exit 1
}

# Function to output JSON message and exit
message_exit() {
  local message="$1"
  printf '{"message": "%s"}\n' "$message"
  exit 0
}

# Check if at least one argument (CWE ID) is provided
if [ $# -lt 1 ]; then
  error_exit "Missing CWE ID. Usage: $0 \"CWE_ID\""
fi

# Specify the CWE ID
CWE_ID="$1"

# Validate that CWE_ID is a positive integer
if ! [[ "$CWE_ID" =~ ^[0-9]+$ ]]; then
  error_exit "CWE_ID must be a positive integer. Usage: $0 \"CWE_ID\""
fi

# Define the API URL
MITRE_API_URL="https://cwe-api.mitre.org/api/v1/cwe/weakness/$CWE_ID"

# RESPONSE=$(curl -s -H "Accept: application/json" "$MITRE_API_URL")
RESPONSE=$(curl  -s -w "\n%{http_code}" -G "$MITRE_API_URL")

# Split RESPONSE into body and status code
HTTP_BODY=$(echo "$RESPONSE" | sed '$d')
HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)

# Check if curl was successful
if [ "$HTTP_STATUS" -ne 200 ]; then
  # Escape double quotes and backslashes in HTTP_BODY for valid JSON
  ESCAPED_BODY=$(printf '%s' "$HTTP_BODY" | sed 's/\\/\\\\/g; s/"/\\"/g')
  error_exit "Received HTTP status code $HTTP_STATUS from NVD API. Response Body: $ESCAPED_BODY"
fi

echo "$HTTP_BODY" | jq
