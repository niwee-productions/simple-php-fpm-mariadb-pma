# Simple PHP, MARIADB, NGINX and PhpMyAdmin Docker infrastructure

Use this to run a simple php project with a mariadb database & phpmyadmin

## Getting started
**Make sure Docker and Docker Compose are installed on your machine.**

1. Clone the project
```bash
git clone https://github.com/boyer-nicolas/simple-php-fpm-mariadb-pma.git my-project
```

2. Go in the cloned directory
```bash
cd my-project
mkdir app
touch app/index.php
```
> :warning: **It is strongly advised to init a git repository with the app folder.**

3. Start the project
```bash
docker-compose up
```

4. That's it ! 

All of your code should be placed in the `public directory`.

## Saving your database
Your database only exists in a virtual volume, so you need to dump it to reuse it.

`make dump`
Exports the database.

`make import`
Imports the database.

## Modifying the server config
All of the config is located in nginx.conf. Change the mount point to something more radical if you need to edit further.
