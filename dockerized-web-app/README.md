# Dockerized Web Application

A simple static website containerized with Docker, using nginx as the web server. This project demonstrates core containerization concepts: writing a Dockerfile, building an image, and running a container with port mapping.

## Structure

- `app/index.html` — the static site content
- `Dockerfile` — instructions to build the container image

## How it works

The `Dockerfile` uses the official lightweight `nginx:alpine` image as a base, then copies the static site into nginx's default web root (`/usr/share/nginx/html/`). No custom nginx configuration is needed since we're using nginx's own defaults.

## Build and Run

Build the image:
```bash
docker build -t sylvia-devops-site .
```

Run a container from the image, mapping port 8080 on the host to port 80 in the container:
```bash
docker run -d -p 8080:80 --name devops-site sylvia-devops-site
```

Verify it's running:
```bash
docker ps
curl localhost:8080
```

## Key Learnings

- **Images vs. containers**: An image is a static template; a container is a running instance of that image (similar conceptually to an AWS AMI vs. an EC2 instance).
- **Port mapping**: The `-p host_port:container_port` flag connects a port on the host machine to a port inside the isolated container network namespace.
- **Base images matter**: Using `nginx:alpine` instead of a full OS image keeps the resulting image small and reduces the attack surface.
