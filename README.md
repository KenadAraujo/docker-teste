# Projeto teste com Docker
<img src="https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white" /> <img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white" />

É um projeto teste para Dockerizar uma aplicação SpringBoot. Nessa aplicação, foi criado uma stack que utiliza 3 componentes de arquitetura: uma aplicação backend, um servidor de messageria([RabbitMQ](https://www.rabbitmq.com/download.html)) e um componente de banco de dados([Postgres](https://www.postgresql.org/download/)). A ideia principal é criar essa stack para produção e para desenvolvimento.

## Dockerfile

Abaixo segue o Dockerfile

```Docker
FROM openjdk:17
WORKDIR /app
COPY . /app
ARG PORT=9000
ENV PORT=$PORT
EXPOSE $PORT
RUN chmod +x ./mvnw
RUN ./mvnw clean package
CMD java -jar target/*.jar
```
Comando para compilar a imagem


```bash
docker run -it -p 9000:9000 kenadaraujo/teste:1.0
```

## docker-compose

Esse é um docker-compose básico, ele é responsável por subir os serviços da aplicação, do rabbitmq e do banco de dados postgres.

```yaml
version: "3.9"

services:
  mensageria:
    image: rabbitmq:3.11-management
    container_name: rabbit-mq
    networks:
      - compose-bridge
    ports:
      - 5672:5672
      - 15672:15672
  bd:
    image: postgres:latest
    container_name: postgres-bd
    networks:
      - compose-bridge
    environment:
      - POSTGRES_PASSWORD=rootroot
  app:
    depends_on:
      - mensageria
      - bd
    image: kenadaraujo/teste:1.0
    container_name: app
    networks:
      - compose-bridge
    ports:
      - 9000:9000
networks:
  compose-bridge:
    driver: bridge
```

Comando para subir a stack

```bash
docker-compose up
```

Comando para destruir a stack
```bash
docker-compose down
```

### docker-compose de desenvolvimento

Esse é um docker-compose de desenvolvimento, onde a imagem é criada em tempo de execução do docker-compose

```yaml
version: "3.9"

services:
  mensageria:
    image: rabbitmq:3.11-management
    container_name: rabbit-mq
    networks:
      - compose-bridge
    ports:
      - 5672:5672
      - 15672:15672
  bd:
    image: postgres:latest
    container_name: postgres-bd
    networks:
      - compose-bridge
    environment:
      - POSTGRES_PASSWORD=rootroot
  app:
    depends_on:
      - mensageria
      - bd
    build: 
      context: .
    container_name: app
    networks:
      - compose-bridge
    ports:
      - 9000:9000
networks:
  compose-bridge:
    driver: bridge
```

Para executar utilize o comando abaixo

```bash
docker compose -f docker-compose.desenv.yml up
```
