# n8n Debian Lab

A personal Linux automation lab built on Debian 13 using Docker Compose and n8n.

## Project Overview

This project demonstrates how to run n8n locally on a Debian Linux system and prepare it for webhook-based workflows using ngrok.

## Technologies

- Debian GNU/Linux 13
- Docker and Docker Compose
- n8n workflow automation
- ngrok for webhook connectivity
- Bash scripting
- Git and GitHub

## Features

- Run n8n using Docker Compose
- Keep n8n accessible locally on port 5678
- Configure webhook connectivity through ngrok
- Start the environment with a helper script
- Store n8n data in a persistent Docker volume

## Project Structure

- `compose.yaml` — Docker Compose configuration
- `INSTALLATION.md` — installation notes
- `scripts/` — helper scripts
- `.gitignore` — excludes local environment and secret files

## Security

Environment-specific settings should be stored locally in `.env`. Do not commit API keys, credentials, or private configuration files.

## Status

Personal learning project. Features and documentation will be improved as the lab develops.
