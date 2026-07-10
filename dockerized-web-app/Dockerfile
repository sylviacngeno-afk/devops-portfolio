# Use the official lightweight nginx image as our base
FROM nginx:alpine

# Copy our static site into nginx's default web root
COPY app/index.html /usr/share/nginx/html/index.html

# Document that the container listens on port 80
EXPOSE 80

# nginx's default image already runs nginx in the foreground, so no CMD override needed
