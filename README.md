# Dockerfiles

### Docker images
The Docker image currently available is:

* noble_jazzy

And makes available:
* Ubuntu 24.04.2 LTS Noble Numbat
* ROS2 Jazzy Jalisco
* Gazebo Harmonic

From within the `Dockerfiles` folder, you can launch different scripts from the terminal to **build** a Dockerfile, **run** a Docker container or **attach** a new terminal to a running container.

### Build Docker image

```
./build_image.sh $DOCKER_IMAGE_NAME $NO_CACHE
```
Pass the Docker image name [ `noble_jazzy` ] and two optional parameters. A first one for the Docker image tag (you can choose every name, otherwise `release` will be used as default) and a second one [ `--no-cache` ] if you want to build avoiding the usage of the cache.

### Run Docker image

```
./run_image.sh $DOCKER_IMAGE_NAME -v $WORKING_DIRECTORY_PATH
```
Pass the Docker image name [ `noble_jazzy` ] and two optional parameters. A first one for the tag of the Docker image you want to run (otherwise, `release` will be used as default) and a second one [ `-v` ] followed by the path of the folder that you want to mount from the host to the `ros2_ws/src` folder inside the container. 

### Attach Docker image

```
./attach_image.sh $DOCKER_IMAGE_NAME
```
Pass the Docker image name [ `noble_jazzy` ] and the tag of the Docker container you want to attach your terminal to (otherwise, `release` will be used as default).