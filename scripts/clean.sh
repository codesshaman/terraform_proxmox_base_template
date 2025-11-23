#!/bin/bash

# Собираем все файлы terraform-provider-proxmox_* в массив
mapfile -t prov_files < <(ls terraform-provider-proxmox_* 2>/dev/null || true)

# Остальные файлы
other_files=(
    "terraform.tfstate.backup"
    ".terraform.lock.hcl"
    "terraform.tfstate"
)

echo " Начинаю очистку..."
echo

# Удаляем провайдеры
for file in "${prov_files[@]}"; do
    rm -f "$file"
    echo "Удалено: $file"
done

# Удаляем остальные
for file in "${other_files[@]}"; do
    if [ -f "$file" ]; then
        rm -f "$file"
        echo "Удалено: $file"
    else
        echo "Не найдено: $file"
    fi
done

# Если провайдеров не было — скажем об этом
if [ ${#prov_files[@]} -eq 0 ]; then
    echo "Не найдено: terraform-provider-proxmox_*"
fi

echo
echo "Очистка завершена!"
