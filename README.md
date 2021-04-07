# Docker image for Symfony development

This image is based on Alpine Linux and contains of the following software:
- PHP 8.0 with FPM
- NodeJS 14
- MySQL client
- Bash
- OpenSSH client (useful if using Composer registries that are only available as a private Git repository)

## Usage

```
docker run -it smartive/php-fpm-symfony:8.0 /bin/bash
```

## Folders

| Folder        | Description                                                                                |
| ------------- | ------------------------------------------------------------------------------------------ |
| /app          | Application directory available as mount volume, containing your Symfony application files |
| /var/log/php8 | PHP-FPM logs                                                                               |
| /etc/php8     | PHP configuration files                                                                    |
