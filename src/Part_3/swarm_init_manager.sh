#!/bin/bash
set -e
# Инициализируем Docker Swarm

JOIN_COMMAND=$(docker swarm init --advertise-addr 192.168.56.10 | sed -n '5p')
FIRST_WORD=$(echo "$JOIN_COMMAND" | awk '{print $1}')
if [ "$FIRST_WORD" != "docker" ]; then
  echo "Ошибка при инициализации Docker Swarm"
  exit 1
fi

echo $JOIN_COMMAND > ../../vagrant/join-command.txt

echo "Docker Swarm успешно инициализирован. Команда для присоединения сохранена в join-command.txt."