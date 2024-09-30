#!/bin/sh

# Wait for Portainer to be ready
sleep 50

# Load environment variables from .env file
set -a
. /usr/src/app/.env
set +a

# Define variables from environment variables
PORTAINER_ADMIN_USER=${PORTAINER_ADMIN:-admin}
PORTAINER_ADMIN_PASSWORD=${PORTAINER_ADMIN_PASSWORD:-password}

# Authenticate with Portainer API
PORTAINER_URL="http://localhost:9000/api"
TOKEN=$(curl -s -X POST "$PORTAINER_URL/auth" -H "Content-Type: application/json" -d "{\"Username\":\"$PORTAINER_ADMIN_USER\",\"Password\":\"$PORTAINER_ADMIN_PASSWORD\"}" | jq -r .jwt)

# Check if the admin user exists
USER_EXISTS=$(curl -s -X GET "$PORTAINER_URL/users" -H "Authorization: Bearer $TOKEN" | jq -r '.[] | select(.username=="'$PORTAINER_ADMIN_USER'") | .id')

if [ -z "$USER_EXISTS" ]; then
  # Create an admin user
  curl -s -X POST "$PORTAINER_URL/users" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "{\"Username\":\"$PORTAINER_ADMIN_USER\",\"Password\":\"$PORTAINER_ADMIN_PASSWORD\",\"Role\":1}"
fi

# Set Portainer to use the admin credentials
curl -s -X PUT "$PORTAINER_URL/settings" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d "{\"Authentication\":\"db\",\"JWT\":\"$TOKEN\"}"

# Run Portainer
exec portainer --no-ssl

