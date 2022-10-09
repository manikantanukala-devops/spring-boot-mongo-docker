FROM  maven:3-eclipse-temurin-8-alpine   as maven
COPY . .
RUN mvn clean package

# Required for starting application up.
RUN apk update && apk add /bin/sh

RUN mkdir -p /opt/app
ENV PROJECT_HOME /opt/app

COPY --from=maven target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar

WORKDIR $PROJECT_HOME
EXPOSE 8080
CMD ["java" ,"-jar","$PROJECT_HOME/spring-boot-mongo.jar"]
