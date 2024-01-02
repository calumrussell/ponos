FROM maven AS build  
WORKDIR /app
COPY . /app
RUN mvn -f /app/pom.xml clean install

FROM eclipse-temurin:20-jdk
COPY --from=build /app/target/parser-1.0-SNAPSHOT-jar-with-dependencies.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
