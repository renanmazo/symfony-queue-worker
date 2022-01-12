# Docker Nginx, PHP-FPM, Supervisor container with Symfony

An alternative approach to https://github.com/formapro/docker-nginx-php-fpm which uses Supervisor to run and monitor Nginx and PHP-FPM processes.

## Copy .env.example file
Create a .env file based on .env.example

## Create a local network to comunicate
```bash
$ docker network create service_mesh
```

# Run dev env with docker-compose
```bash
$ docker-compose -f docker-compose.dev.yaml up -d
```

## Build
```bash
$ docker build -t local/nginx-php-fpm-supervisor . 
```

## Run

```bash
$ docker run --rm -it local/nginx-php-fpm-supervisor
```
