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

```Docker
docker run -it -p 9000:9000 kenadaraujo/teste:1.0
```

## docker-compose

Esse é um docker-compose básico