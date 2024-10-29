import sys
import requests

DISCORD_CHANNEL_ID = 'YOURCHANNELID'
DISCORD_BOT_TOKEN = 'BOT TOKEN GOES HERE'

def send_message(message):
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f
