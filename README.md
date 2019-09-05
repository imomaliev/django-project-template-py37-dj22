# {{ project_name }}
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

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
