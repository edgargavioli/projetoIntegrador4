FROM maven:3.8.4-openjdk-17-slim AS build
COPY src /home/app/src/
COPY pom.xml /home/app/
RUN mvn -f /home/app/pom.xml clean package -DskipTests

FROM openjdk:17-slim
COPY --from=build /home/app/target/*.jar /usr/local/lib/app.jar
COPY opentelemetry /usr/local/lib/opentelemetry
EXPOSE 8080
# ENTRYPOINT ["java", "-jar", "/usr/local/lib/app.jar"]
ENTRYPOINT ["java", "-javaagent:/usr/local/lib/opentelemetry/opentelemetry-javaagent.jar", "-Dotel.service.name=grupo5", "-Dotel.traces.exporter=otlp", "-Dotel.metrics.exporter=otlp", "-Dotel.exporter.otlp.endpoint=http://collector-api:4318", "-Dotel.exporter.otlp.protocol=http/protobuf", "-jar","/usr/local/lib/app.jar"]
