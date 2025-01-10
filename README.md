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
### Iniciar o sidekiq para executar processos emm segundo plano
```bash
docker exec -it challenge bundle exec sidekiq
```
## Resetar o banco de dados
```bash
docker exec -it challenge rails db:reset
```

## Documentação de acesso à API

### Criando novo client de acesso
```bash
curl \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{ "client": {"email":"teste@teste.com", "password": "123456", "name": "Sr. Teste"} }' \
  http://localhost:3000/api/v1/signup
```
#### Resposta esperada
```json
{
  "status":
  {
    "code":200,
    "message":"Signed up successfully."
  },
  "data":{
    "id":2,
    "email":"teste@teste.com",
    "name":"Sr. Teste"
  }
}
```

### Realizando login
```bash
curl \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{ "client": {"email":"teste@teste.com", "password": "123456"} }' \
  http://localhost:3000/api/v1/login
```
#### Resposta esperada
```json
{
  "status":{
    "code":200,
    "message":"Logged in successfully.",
    "token": "eyJhbGciOiJIUzI...",
    "data":{
      "client":{
        "id":2,
        "email":"teste@teste.com",
        "name":"Sr. Teste"
      }
    }
  }
}
```

### Realizando logout
```bash
curl \
  -X DELETE \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {token}" \
  http://localhost:3000/api/v1/logout
```
#### Resposta esperada
```json
{
  "status":{
    "code":200,
    "message":"Logged in successfully.",
    "data":{
      "client":{
        "id":2,
        "email":"teste@teste.com",
        "name":"Sr. Teste"
      }
    }
  }
}
```

### Enviar arquivo data legacy
```bash
curl \
  -X POST \
  -H "Content-Type: multipart/form-data" \
  -H "Authorization: Bearer {token}" \
  -F "file=@path/to/file/filename.txt" \
  http://localhost:3000/api/v1/legacy_order_imports
```
#### Resposta esperada
```json
{
  "id":5,
  "client_id":1,
  "results":null,
  "created_at":"2025-01-10T13:26:56.554Z",
  "updated_at":"2025-01-10T13:26:56.598Z"
}
```

### Consutar resultado da importação
```bash
curl \
  -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {token}" \
  http://localhost:3000/api/v1/legacy_order_imports/{id}
```
#### Resposta esperada
```json
{
  "id":4,
  "client_id":1,
  "results":"Total lines: 3870\nTotal errors: 0\n",
  "created_at":"2025-01-10T03:46:45.790Z",
  "updated_at":"2025-01-10T03:47:28.693Z"
}
```
Caso ocorra importação em alguma linha, será indicada a posição da linha. Demais linhas serão importadas.

### Listar Orders
```bash
curl \
  -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer {token}" \
  http://localhost:3000
```
#### Resposta esperada
```json
[{
  "user_id":70,
  "name":"Palmer Prosacco",
  "orders":[{
    "order_id":753,
    "total":"4252.53",
    "date":"2021-03-08",
    "products":[{
      "product_id":3,
      "value":"1836.74"
    },{
      "product_id":3,
      "value":"1009.54"
    },{
      "product_id":4,
      "value":"618.79"
    },{
      "product_id":3,
      "value":"787.46"
    }]
  }]
}]
```
