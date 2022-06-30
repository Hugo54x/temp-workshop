# Docker Commands

## **Dockerfile**

### FROM

- `FROM scratch`
- `FROM image-name:version`
- Multistage environments:
- `FROM python:3 AS builder`

### RUN

- run a command
- `RUN apt update && apt upgrade`

### USER

- switches the user to the
- could be defined as build-argument or environment variable
- `USER root`
- `USER $MAMBA_USER`

### ENTRYPOINT

- defines the initial entrypoint, when the container is launched
- `ENTRYPOINT ["/bin/bash", "-c", "echo 'hello world'"]`
- prefer over `ENTRYPOINT`

### COPY

- copies files and folders inside the container
- `COPY requirements.txt /tmp/`
- `COPY src/ /home/myuser/`
- copy files from another build stage
- `COPY --from=builder /go/src/ ./`
- prefer `COPY` over `ADD`

### WORKDIR

- sets the current folder
- `WORKDIR /opt`

### EXPOSE

- opens a port in the firewall
- `EXPOSE 9999 3213 44123`

### ENV

- specify environment variables with default value
- `ENV PORT=9999`

### ARG

- defines arguments that are used while building the image

-------

## **Useful commands**

### **docker**

list currently running containers:

- `docker ps`
- `docker container ls`

list all containers:

- `docker ps -a`
- `docker container ls -a`

`container` command offers options to start and stop containers.

get list of all images:

- `docker images`

### **docker build**

- `docker build .`

Without Cache:

- `docker build –no-cache .`

Tagging the built image:

- `docker build –t git.example.com/my-image .`

Build only certain parts:

- `docker build –target build-stage .`
- `docker build -f Dockerfile.debug .`

Using build arguments:

- `docker build –build-arg USE_NODE=true`

### **docker run**

with interactive shell and cleanup:

- `docker run --rm –it python:3.7 /bin/bash`
- `docker run --rm -it --entrypoint bash python:3.7`

expose ports:

- `docker run –p 8888:9999 41231b2`

set environment variables:

- `docker run –e ENV_VAR=yes 26b2`

attach volumes / bind mounts:

- `docker run -v ${pwd}/src/:/tmp/container/ 26b2`
