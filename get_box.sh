#!/bin/bash
set -e

# Конфигурация
BOX_NAME="ubuntu/focal64"
TF_FILE="main.tf"

# Шаг 1. Инициализация и скачивание box
echo "[INFO] Загружаем Vagrant box: $BOX_NAME"
vagrant box add $BOX_NAME --provider virtualbox --force || true

# Шаг 2. Определяем путь к box в кеше
BOX_PATH=$(vagrant box list | grep "$BOX_NAME" | awk '{print $1}')
BOX_DIR="$HOME/.vagrant.d/boxes/${BOX_PATH//\//-}"

# Берём последнюю версию
LATEST_DIR=$(ls -1 "$BOX_DIR" | sort -V | tail -n1)
VMDK_PATH=$(find "$BOX_DIR/$LATEST_DIR/virtualbox" -name "*.vmdk" | head -n1)

if [[ -z "$VMDK_PATH" ]]; then
  echo "[ERROR] Не найден .vmdk в $BOX_DIR"
  exit 1
fi

echo "[INFO] Найден диск: $VMDK_PATH"

# Шаг 3. Обновляем main.tf
if [[ -f "$TF_FILE" ]]; then
  echo "[INFO] Обновляем $TF_FILE"
  sed -i "s|image *=.*|image  = \"$VMDK_PATH\"|g" "$TF_FILE"
else
  echo "[INFO] Создаём новый $TF_FILE"
  cat > "$TF_FILE" <<EOF
terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2"
    }
  }
}

provider "virtualbox" {}

resource "virtualbox_vm" "test" {
  name   = "ubuntu-focal"
  image  = "$VMDK_PATH"
  cpus   = 2
  memory = "1024 mib"
}
EOF
fi

echo "[INFO] Готово! Теперь можно запускать:"
echo "  tofu init && tofu apply"
