#!/bin/bash

# Целевая директория
TARGET_DIR="."

# Проверяем, существует ли директория
if [ ! -d "$TARGET_DIR" ]; then
    echo "Директория $TARGET_DIR не найдена!"
    exit 1
fi

echo "Начинаю очистку в директории $TARGET_DIR..."
echo

# Собираем все файлы terraform-provider-proxmox_* в массив
mapfile -t prov_files < <(ls "$TARGET_DIR"/terraform-provider-proxmox_* 2>/dev/null || true)

# Остальные файлы
other_files=(
    "terraform.tfstate.backup"
    ".terraform.lock.hcl"
    "terraform.tfstate"
)

# Удаляем провайдеры
for file in "${prov_files[@]}"; do
    rm -f "$file"
    echo "Удалено: $file"
done

# Удаляем остальные файлы
for file in "${other_files[@]}"; do
    file_path="$TARGET_DIR/$file"
    if [ -f "$file_path" ]; then
        rm -f "$file_path"
        echo "Удалено: $file_path"
    else
        echo "Не найдено: $file_path"
    fi
done

# Удаляем директорию .terraform
if [ -d "$TARGET_DIR/.terraform" ]; then
    rm -rf "$TARGET_DIR/.terraform"
    echo "Удалена директория: $TARGET_DIR/.terraform"
else
    echo "Не найдена директория: $TARGET_DIR/.terraform"
fi

# Если провайдеров не было — скажем об этом
if [ ${#prov_files[@]} -eq 0 ]; then
    echo "Не найдено: terraform-provider-proxmox_* в $TARGET_DIR"
fi

echo
echo "Очистка завершена!"
