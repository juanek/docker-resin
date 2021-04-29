# Caucho Resin Docker image build.

## Based on [ubuntu:18.04](https://hub.docker.com/_/ubuntu):

- Ubuntu 18:04
- Open JDK 8
- Caucho Resin 4

## Build the image.

```sh
docker build -t docker-resin:1 .
```

## Run the container.

```sh
docker run --name dockerResin -itd -p 8080:8080 docker-resin:1
```

## Testing.

```sh
docker exec -it dockerResin /bin/bash resinctl status
```

## Logs.

```sh
docker logs dockerResin
```
