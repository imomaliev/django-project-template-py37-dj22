# {{ project_name }}

## Development
```sh
cp .env.template .env
docker-compose build
docker-compose up -d
```
### Install pre-commit hooks
```sh
pre-commit install
pre-commit install -t pre-push
```
