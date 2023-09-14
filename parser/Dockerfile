FROM eclipse-temurin:20-jdk-alpine
VOLUME /tmp
COPY target/parser-1.0-SNAPSHOT-jar-with-dependencies.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
