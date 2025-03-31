#!/bin/bash

      # Обновление пакетов
      sudo apt update

      # Установка зависимостей
      sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

      # Добавление официального GPG-ключа Docker
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

      # Добавление репозитория Docker
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

      # Установка Docker
      sudo apt update
      sudo apt install -y docker-ce docker-ce-cli containerd.io

      # Добавление пользователя vagrant в группу docker (чтобы не использовать sudo)
      sudo usermod -aG docker vagrant

      # Включение и запуск Docker
      sudo systemctl enable --now docker