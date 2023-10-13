FROM maven AS build  
WORKDIR /app
COPY . /app
RUN mvn -f /app/pom.xml clean install

FROM eclipse-temurin:20-jdk-alpine
COPY --from=build /app/target/api-1.0-SNAPSHOT.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
