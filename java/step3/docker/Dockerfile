#pull base image
FROM openjdk:8-jdk-alpine

#maintainer 
MAINTAINER manawa@adeo.com

RUN apk update 
RUN addgroup -S -g 10101 app \
    && adduser -S -D -u 10101 -s /sbin/nologin -h /app -g "App User" -G app app 

# Change to the app user.
USER 1001

#expose port 8080
EXPOSE 8080

#default command
CMD java -jar /app/hello-world-0.1.0.jar

#copy hello world to docker image
ADD ./target/hello-world-0.1.0.jar /app/hello-world-0.1.0.jar
