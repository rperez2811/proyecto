# Usar la imagen oficial de Eclipse Temurin con JDK 21
FROM maven:3.9-eclipse-temurin-21 AS build
LABEL authors="rocio"
# Establecer el directorio de trabajo
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
# Copiar el archivo JAR de la aplicación
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
