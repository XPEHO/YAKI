FROM ubuntu:latest

# Create app working directory
RUN mkdir /app/
WORKDIR /app/

EXPOSE 443

# Deploy webserver
FROM nginx:1.21.5

COPY build/web /usr/share/nginx/html