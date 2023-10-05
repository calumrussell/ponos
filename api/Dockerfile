FROM eclipse-temurin:20-jdk-alpine
VOLUME /tmp
COPY target/api-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]