# Desafio técnico - Vertical Logística
# -
Desenvolver um projeto para atender uma demanda para integrar dois sistemas. O sistema legado que possui um arquivo de pedidos desnormalizado, precisando transformá-lo em um arquivo JSON normalizado.

## Rodando a aplicação via Docker

### Rodar o Docker para construção do Contêiner
```bash
docker compose build
```
### Rodar em paralelo
```bash
docker compose up -d
```
### Atualizar Contêiner e rodar em paralelo
```bash
docker compose up --build -d
```
### Parar o Contêiner
```bash
docker compose stop
```
### Entrando no Contêiner
```bash
docker exec -it challenge bash
```
### Criar e atualizar o banco de dados
```bash
docker exec -it challenge rails db:create db:migrate db:seed
```
### Iniciar a aplicação no endereço http://localhost:3000
```bash
docker exec -it challenge rails s -b 0.0.0.0
```
## Resetar o banco de dados
```bash
docker exec -it challenge rails db:reset
```

## Documentação de acesso à API
-WIP
