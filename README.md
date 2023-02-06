# Projeto teste com Docker

É um projeto teste para Dockerizar uma aplicação SpringBoot.

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
