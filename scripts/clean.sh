#!/bin/bash


# Список файлов для удаления
files=(
    "terraform.tfstate.backup"
    ".terraform.lock.hcl"
    "terraform.tfstate"
)

echo " "

# Цикл по списку файлов
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        rm "$file"
        echo "❌ $file is removed"
    else
        echo "⚠️ $file not found"
    fi
done