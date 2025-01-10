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
## Executar teste
```bash
docker exec -it challenge bundle exec rspec
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
Caso ocorra erro de importação, será indicada a posição da linhas com erro no campo `results`. Demais linhas serão importadas.

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

## Demais informações

### Modelagem

* Versões: Ruby 3.3.6 - Rails 7.2.2
* Uso de Docker para criar o ambiente com as configurações e versões controladas.
* Banco de dados PostgreSQL para armazenar dados processados.
* Redis + Sidekiq para execução do processamento de dados em Job.
* Como os IDs informados via importação podem ser diferentes do utilizado na plataforma, optei por salvar esses IDs na coluna `legacy_id`.
* Como cada `Order` tem apontamento para os `Products`, optei por renomear para `OrderProducts`
* Uso do model `Client` com `DeviseJWT` para gestão de autenticação da API.
* Todo ambiente desenvolvido a partir do _rails new_, adicionando apenas as configurações e _Gems_ necessárias.

### Padrões

* Como o arquivo enviado pode ser grande, o processamento é executado via **Service** chamado no **Job**, permitindo resposta rápida ao enviar o arquivo, que será posteriormente processado. O arquivo é apagado após o processamento.
* Adicionei consulta ao resultado do processamento, informando quantidade de linhas importadas e erros, indicando cada linha que teve erro caso ocorra.
* Uso de **Serializers** para gerar resposta em JSON com bom tempo de resposta, retornando **8500** _OrderProducts_ com tempo de reposta em média de **300ms** no padrão solicitado.

### Testes

* Uso do **RSpec** para execução dos testes.
