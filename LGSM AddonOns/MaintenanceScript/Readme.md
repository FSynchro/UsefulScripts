# Factorio Server Update Automation with Discord Notifications

This repository contains a set of scripts to automate the update process for a Factorio server that runs on LGSM (which can be any other LGSM server, just replace ./fctrserver with ./gameserver)  and send live update notifications to a specified Discord channel. The automation includes checking for updates, stopping the server, updating it, and notifying users of progress and completion through Discord.

## Prerequisites

Before using these scripts, ensure you have the following installed:

- **Python 3.x**: Make sure Python is installed on your machine.
- **pip**: Python package installer.
- **curl**: Command-line tool for transferring data with URLs.
- **jq**: Lightweight and flexible command-line JSON processor.
- **mcrcon**: RCON client for Minecraft (can be used with other servers supporting RCON).

## Installation

1. **Install Required Packages**:
   sudo apt-get update
   sudo apt-get install python3 python3-pip curl jq mcrcon

2. **Install Python Requests Library**:
  pip3 install requests


