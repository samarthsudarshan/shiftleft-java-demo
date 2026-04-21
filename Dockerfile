# Build stage
FROM maven:3.9.9-eclipse-temurin-8 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -B -DskipTests clean package

# Runtime stage
FROM eclipse-temurin:8-jre-jammy
WORKDIR /app

COPY --from=build /app/target/hello-shiftleft-0.0.1.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
