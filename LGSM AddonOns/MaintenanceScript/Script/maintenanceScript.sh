#!/bin/bash

RCON_HOST="ip address of your server goes here"
RCON_PORT="RCON port"
RCON_PASSWORD="Rcon password goes here"
DISCORD_CHANNEL_ID="CHANNEL ID"
DISCORD_BOT_TOKEN="BOT TOKEN HERE"

# Function to send RCON message
send_rcon_message() {
  local message="$1"
  echo "Sending RCON message: $message"
  mcrcon -H "$RCON_HOST" -P "$RCON_PORT" -p "$RCON_PASSWORD" "broadcast $message"
}

# Function to send Discord message via bot
send_discord_message() {
  local message="$1"
  echo "Sending Discord message: $message"
  response=$(curl -s -H "Content-Type: application/json" -H "Authorization: Bot $DISCORD_BOT_TOKEN" \
    -X POST \
    -d "{\"content\": \"$message\"}" \
    https://discord.com/api/v9/channels/$DISCORD_CHANNEL_ID/messages)
  echo $response
}

# Function to display status in the SSH session
display_status() {
  local status_message="$1"
  echo "$(date) - $status_message"
}

# Check for Factorio update
display_status "Script started. Checking for Factorio update."
update_status=$(./fctrserver cu | grep "Update available")

if [[ "$update_status" == *"Update available"* ]]; then
  display_status "Update available detected."
  send_rcon_message "Factorio update detected, scheduled update in 10 minutes. Server will be unavailable for a couple of minutes. Check the Discord chat for updates on server status."
  send_discord_message "Update found: Factorio update detected, scheduled update in 10 minutes. Server will be unavailable for a couple of minutes. Check the Discord chat for updates on server status."
  sleep 600  # Wait for 10 minutes
  
  send_discord_message "Factorio update started"
  display_status "Factorio update started."

  # Stop the server
  ./fctrserver stop
  sleep 10  # Ensure the server has stopped

  # Update the server and capture output, then pass it to Python script
  ./fctrserver update | python3 send_to_discord.py

  # Start the server
  ./fctrserver start
  send_discord_message "Server starting"
  display_status "Server started."
else
  display_status "No update available."
fi
