FROM openjdk:17
WORKDIR /app
COPY . /app
ARG PORT=9000
ENV PORT=$PORT
EXPOSE $PORT
RUN chmod +x ./mvnw
RUN ./mvnw clean package
CMD java -jar target/*.jar