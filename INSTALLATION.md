# Installation Guide

## 1. Overview

This guide explains how to run the n8n automation platform on Debian Linux using Docker Compose.

The project also includes an optional ngrok tunnel for receiving external webhook requests.

## 2. Requirements

Make sure the following tools are installed:

- Debian Linux 13 or a compatible Linux distribution
- Docker Engine
- Docker Compose plugin
- curl
- Python 3
- ngrok (optional, for public webhook access)

Verify Docker and Docker Compose:

```bash
docker --version
docker compose version
```

## 3. Clone the Repository

```bash
git clone git@github.com:ELPromise/n8n-debian-lab.git
cd n8n-debian-lab
```

Alternatively, download the repository as a ZIP archive from GitHub.

## 4. Configure the Environment

Create a local `.env` file in the project root:

```bash
nano .env
```

Add your current ngrok HTTPS URL:

```dotenv
WEBHOOK_URL=https://YOUR-NGROK-URL
```

Replace the example value with your actual HTTPS URL.

Do not commit `.env` or any credentials to Git.

## 5. Start n8n

Start the service:

```bash
docker compose up -d
```

Open the local interface in your browser:

http://localhost:5678

On first launch, follow the setup instructions displayed by n8n.

## 6. Start the ngrok Tunnel

If you need external webhook access, make sure ngrok is installed and configured.

Start the tunnel:

```bash
ngrok http 5678
```

Copy the HTTPS forwarding address provided by ngrok into `.env` as `WEBHOOK_URL`.

Restart the service after updating the environment:

```bash
docker compose up -d
```

Note: If the ngrok URL changes, update `.env` and restart the service.

## 7. Use the Helper Script

The repository includes a helper script:

```bash
chmod +x scripts/start-n8n.sh
./scripts/start-n8n.sh
```

The script starts Docker Compose, launches ngrok if its local inspection API is not responding, displays the HTTPS tunnel address, and opens the n8n interface.

## 8. Stop the Services

Stop n8n:

```bash
docker compose down
```

Stop ngrok separately if it was started independently.

The named Docker volume `n8n_data` is retained when running `docker compose down`, so n8n data is preserved.

## 9. Security Notes

- Keep `.env` and credentials out of version control.
- The n8n interface is bound to localhost by default.
- A public ngrok tunnel exposes the service to external network access; use authentication and share the URL carefully.
- Never publish API keys, access tokens, passwords, or private SSH keys.

## 10. Troubleshooting

Check service status:

```bash
docker compose ps
```

View logs:

```bash
docker compose logs --tail=100 n8n
```

Check whether the local interface responds:

```bash
curl -I http://localhost:5678
```

If the service fails to start, inspect the logs and verify Docker permissions and environment configuration.


