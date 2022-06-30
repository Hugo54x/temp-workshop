# Docker Compose commands

start whole file:

- `docker compose up`

start single service:

- `docker compose up jupyterlab`

start file in background:

- `docker compose up -d`

build images:

- `docker compose --build up`

start certain profile:

- `docker-compose --profile dev up`

build images without cache:

- `docker-compose --profile dev up --build --force-recreate`
