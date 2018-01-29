# nginx-rails

A Docker image to run nginx in front of a Rails container.

Features:

- Automatic backend discovery
- Static files served directly by nginx
- Optional HTTP Basic authentication


## Image details

Images are hosted publicly on Docker Hub as `parachute/nginx-rails`.


## Usage

Your Rails app container should:

- be based on the official `ruby` base image, or at least have the Rails app live in `/usr/src/app`
- `VOLUME /usr/src/app/public` to allow nginx to serve static files
- `EXPOSE 3000` and serve requests on this port
- be named `app`
- run on the same non-default Docker network (to support Docker's built-in DNS service discovery)

Then just run this container with the Rails public folder as a read-only mount using `--volumes-from=app:ro`. You'll probably want to bind nginx to a host port, too, using either `-P` or something like `-p 80:80`.

### Example

```bash
# Create a network (skip if you already have one)
docker network create my_network

# Run your Rails container
docker run -d --network=my_network --name=app my_rails_app:latest

# Run this nginx container
docker run -d --network=my_network --volumes-from app:ro -P parachute/nginx-rails
```


## HTTP Basic Authentication

HTTP Basic Authentication credentials can be set using the `HTTP_BASIC_USER` & `HTTP_BASIC_PASSWORD` environment variables. Authentication will be enabled if `HTTP_BASIC_USER` is non-empty.

### Example

```bash
docker run -d -e HTTP_BASIC_USER=admin -e HTTP_BASIC_PASSWORD=password --network=my_network --volumes-from app:ro -P parachute/nginx-rails
```


## Credit

Based on `bfolkens/docker-nginx-rails`.
