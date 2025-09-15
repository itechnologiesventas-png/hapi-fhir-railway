FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
RUN git clone https://github.com/hapifhir/hapi-fhir-jpaserver-starter.git .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
