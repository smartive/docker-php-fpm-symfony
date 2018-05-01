# Docker image for Symfony development

This image is based on Alpine Linux and contains of the following software:
- PHP 7.1 with FPM
- NodeJS 10
- MySQL client
- Bash
- OpenSSH client (useful if using Composer registries that are only available as a private Git repository)

## Usage

```
docker run -it smartive/php-fpm-symfony:7.1 /bin/bash
```

## Folders

| Folder        | Description                                                                                |
| ------------- | ------------------------------------------------------------------------------------------ |
| /app          | Application directory available as mount volume, containing your Symfony application files |
| /var/log/php7 | PHP-FPM logs                                                                               |
| /etc/php7     | PHP configuration files                                                                    |
