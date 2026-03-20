#!/bin/bash

MAIL="$(grep "USER_EMAIL" .env | sed -r 's/.*=//')"

git config user.email "$MAIL"

set -euo pipefail

# Цвета для вывода (опционально, но удобно)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SSH_DIR=".ssh"
DEFAULT_COMMENT="$(date '+%Y-%m-%d')"

echo -e "${GREEN}Генерация SSH-ключа для Yandex Cloud VM${NC}"
echo

# Запрашиваем имя VM
while true; do
    read -r -p "Введите имя виртуальной машины: " VM_NAME

    if [[ -z "$VM_NAME" ]]; then
        echo -e "${RED}Имя не может быть пустым${NC}"
        continue
    fi

    # Убираем опасные символы, оставляем только буквы, цифры, -, _
    SAFE_NAME=$(echo "$VM_NAME" | tr -cd '[:alnum:]-_')

    if [[ "$SAFE_NAME" != "$VM_NAME" ]]; then
        echo -e "${YELLOW}В имени были удалены недопустимые символы → $SAFE_NAME${NC}"
    fi

    if [[ -z "$SAFE_NAME" ]]; then
        echo -e "${RED}После очистки имя стало пустым. Попробуйте другое.${NC}"
        continue
    fi

    PRIV_KEY="$SSH_DIR/$SAFE_NAME"
    PUB_KEY="$SSH_DIR/$SAFE_NAME.pub"

    # Проверяем существование
    if [[ -f "$PRIV_KEY" || -f "$PUB_KEY" ]]; then
        echo -e "${RED}Ошибка: файл(ы) уже существуют:${NC}"
        ls -l "$PRIV_KEY" "$PUB_KEY" 2>/dev/null || true
        echo -e "${YELLOW}Выберите другое имя или удалите существующие файлы.${NC}"
        continue
    fi

    break
done

echo
echo -e "Будет создан ключ:"
echo -e "  Приватный: ${YELLOW}$PRIV_KEY${NC}"
echo -e "  Публичный:  ${YELLOW}$PUB_KEY${NC}"
echo

read -r -p "Продолжить? [Y/n] " answer
answer=${answer:-Y}
if [[ ! "$answer" =~ ^[Yy]$ ]]; then
    echo "Отменено."
    exit 0
fi

# Генерация ключа
echo -e "${GREEN}Генерируем ed25519 ключ...${NC}"
ssh-keygen -t ed25519 \
    -f "$PRIV_KEY" \
    -N "" \
    -C "$SAFE_NAME @ $DEFAULT_COMMENT" \
    >/dev/null 2>&1

# Проверка, что всё прошло успешно
if [[ ! -f "$PRIV_KEY" || ! -f "$PUB_KEY" ]]; then
    echo -e "${RED}Ошибка при генерации ключа${NC}"
    exit 1
fi

chmod 600 "$PRIV_KEY"

echo
echo -e "${GREEN}Готово!${NC}"
echo
echo "Приватный ключ:  $PRIV_KEY"
echo "Публичный ключ:   $PUB_KEY"
echo
echo "Для использования в Terraform:"
echo "  public_key = file(\".ssh/$SAFE_NAME.pub\")"
echo
cat "$PUB_KEY"
echo
echo -e "${YELLOW}Не забудьте добавить этот публичный ключ в metadata VM или в cloud-config.${NC}"
