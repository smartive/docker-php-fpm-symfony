#!/usr/bin/env bash

if [ -d "/ssh" ] && [ ! -f "/root/.ssh/id_rsa" ]; then
    mkdir -p /root/.ssh
    cp /ssh/id_rsa.pub /root/.ssh/id_rsa.pub
    cp /ssh/id_rsa /root/.ssh/id_rsa
    chown root:root /root/.ssh/id_rsa
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/id_rsa
    chmod 644 /root/.ssh/id_rsa.pub
fi

source /root/ssh-agent.sh
ssh-agent-bashrc
ssh-agent-start

if ! ssh-agent-key-exists; then
  echo -e "------------------------------------------------------------------------------------"
  echo -e "WARNING: /root/.ssh/id_rsa was not added to ssh-agent." \
          "This might leads to problems when installing private repositories.\n"
  echo -e "Run the following command to fix this:"
  echo -e "$ docker exec -it {{YOUR_APP}} bash -l -c 'ssh-add'"
  echo -e "------------------------------------------------------------------------------------"
fi

if [ -d "/app/app/logs" ] && [ ! -f "/app/app/logs/prod.log" ]; then
    touch /app/app/logs/prod.log
    chmod -R 0777 /app/app/logs
fi

if [ -d "/app/var/logs" ] && [ ! -f "/app/var/logs/prod.log" ]; then
    touch /app/var/logs/prod.log
    chmod -R 0777 /app/var/logs
fi

if [ ! -f "/app/app/config/parameters.yml" ]; then
    cp /app/app/config/parameters.yml.dist /app/app/config/parameters.yml
fi

if [ ! -d "/app/vendor" ]; then
    echo "Dependencies missing, running composer install.."
    composer install
fi

php --version
echo "System is ready, starting PHP-FPM.."
php-fpm7 -RF
