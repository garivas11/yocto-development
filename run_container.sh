VERSION=$1

docker stop ubuntu-$VERSION
docker rm ubuntu-$VERSION

DISPLAY=':1'

docker run -it --net=bridge --cpus=4 -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/$USER:/home/$USER -v /opt/downloads:/opt/downloads --name ubuntu-$VERSION -h ubuntu-$VERSION ubuntu:$VERSION.04 bash -c "/bin/bash"
