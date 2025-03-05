## How to build Yocto development container

```
docker build --build-arg UNAME=$USER --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t ubuntu:20.04 ubuntu20
```

## Running container

./run_container.sh 20
