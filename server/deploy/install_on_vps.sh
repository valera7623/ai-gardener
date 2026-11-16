#!/usr/bin/env bash
# Запускать на VPS под пользователем valera из консоли хостинга.
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/valera7623/ai-gardener.git}"
APP_DIR="${APP_DIR:-$HOME/ai-gardener}"

echo "==> Dart SDK"
if ! command -v dart >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y apt-transport-https wget gnupg
  wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | sudo gpg --dearmor -o /usr/share/keyrings/dart.gpg
  echo 'deb [signed-by=/usr/share/keyrings/dart.gpg] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
    | sudo tee /etc/apt/sources.list.d/dart_stable.list
  sudo apt-get update
  sudo apt-get install -y dart
fi
dart --version

echo "==> Код"
if [[ -d "$APP_DIR/.git" ]]; then
  git -C "$APP_DIR" pull --ff-only
else
  git clone "$REPO_URL" "$APP_DIR"
fi

cd "$APP_DIR/server"
dart pub get

mkdir -p deploy
if [[ ! -f deploy/recognize.env ]]; then
  cp deploy/recognize.env.example deploy/recognize.env
  chmod 600 deploy/recognize.env
  echo
  echo "Заполните ключи в $APP_DIR/server/deploy/recognize.env"
  echo "Затем снова запустите этот скрипт или только systemd-часть ниже."
  exit 0
fi

chmod 600 deploy/recognize.env
chmod +x deploy/run.sh

# systemd берёт dart из PATH; подставим реальный каталог SDK.
DART_BIN="$(command -v dart)"
DART_DIR="$(dirname "$DART_BIN")"
tee deploy/ai-gardener-recognize.service >/dev/null <<EOF
[Unit]
Description=ИИ-садовник recognition server
After=network.target

[Service]
Type=simple
User=$USER
Group=$USER
WorkingDirectory=$APP_DIR/server
EnvironmentFile=$APP_DIR/server/deploy/recognize.env
Environment=PATH=$DART_DIR:/usr/local/bin:/usr/bin
ExecStart=$APP_DIR/server/deploy/run.sh
Restart=on-failure
RestartSec=3
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
EOF

echo "==> systemd"
sudo cp deploy/ai-gardener-recognize.service /etc/systemd/system/ai-gardener-recognize.service
sudo systemctl daemon-reload
sudo systemctl enable --now ai-gardener-recognize.service
sudo systemctl --no-pager --full status ai-gardener-recognize.service || true

echo
echo "Локальная проверка:"
echo "  curl -sS http://127.0.0.1:8090/health"
echo
echo "Дальше reverse proxy: https://aegisai.fun → http://127.0.0.1:8090"
echo "Пример: $APP_DIR/server/deploy/nginx-recognize.conf.example"
echo "Покажите: docker ps --format '{{.Names}}\t{{.Ports}}\t{{.Image}}'"