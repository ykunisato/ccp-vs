# Dockerfiles for R, Julia, and Python on Quarto with VScode

This is a repository for Dockerfiles to use R, Julia, and Python on Quarto via a remote connection from VSCode. To use it, simply start a Docker container and connect to it from your local VSCode.　The GitHub repository for this Docker image is: [ykunisato/ccp-vs](https://github.com/ykunisato/ccp-vs).

Maintainer is Yoshihiko Kunisato (ykunisato@psy.senshu-u.ac.jp)

Keywords: VSCode, Quarto, Python, Julia, R

## Usage

1. Install ["Docker Desktop"](https://www.docker.com/products/docker-desktop)

2. Open "terminal"(Mac) or "PowerShell"(Windows)

3. Type the following code to pull a Docker container.


```
docker run -d -p 8888:8888 -v $(pwd):/home/jovyan/work --name ccpvs ykunisato/ccp-vs:latest
```


The following link is a template repository for dev containers. However, it may not work properly yet.

https://github.com/ykunisato/dev-containers-template