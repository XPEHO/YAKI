FROM openjdk:21-slim-buster
WORKDIR /app
ADD ./build/libs/yaki_admin_backend-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java","-jar","app.jar"]