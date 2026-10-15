
#!/bin/bash

set -e

PROJECT="$HOME/Projects/n8n-debian-lab"
LOG="$HOME/ngrok-n8n.log"

echo "Starting n8n..."

if [ ! -d "$PROJECT" ]; then
    echo "Project folder not found: $PROJECT"
    exit 1
fi

cd "$PROJECT"
docker compose up -d

echo "Starting ngrok..."

if ! curl -fsS http://127.0.0.1:4040/api/tunnels >/dev/null 2>&1; then
    nohup ngrok http 5678 > "$LOG" 2>&1 </dev/null &
fi

echo "Waiting for ngrok..."

for i in $(seq 1 20); do
    if curl -fsS http://127.0.0.1:4040/api/tunnels >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

echo
echo "ngrok public address:"

curl -fsS http://127.0.0.1:4040/api/tunnels |
python3 -c '
import json, sys
data = json.load(sys.stdin)
for tunnel in data.get("tunnels", []):
    if tunnel.get("proto") == "https":
        print(tunnel["public_url"])
'

echo
echo "Opening n8n..."

xdg-open http://localhost:5678 >/dev/null 2>&1 || true

echo "Done. ngrok inspection: http://localhost:4040"
