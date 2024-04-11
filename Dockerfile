FROM jupyter/datascience-notebook:latest
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

USER root
# Install ipaexfont
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y fonts-ipaexfont
# Insatall notofont
RUN apt-get install -y fonts-noto-cjk fonts-noto-cjk-extra
# install libjpeg & V8 for "psycho"
RUN apt-get install -y libjpeg-dev libv8-dev
# install ffmpeg
RUN apt-get -y install ffmpeg
# install ImageMagick++ library for magick
RUN apt-get install -y libmagick++-dev
# install clang for Stan
RUN apt-get install -y clang make
# Install JAGS and other linux packages
RUN apt-get update && apt-get install -y \
    jags \
    libgsl0-dev \
    tcl8.6-dev \
    tk8.6-dev\
    openmpi-bin\
    libglpk-dev \
    libcgal-dev \
    libglu1-mesa-dev \
    libsecret-1-dev \
    libsodium-dev \
    libssl-dev \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# install sqlite3
RUN apt-get update
RUN apt-get install -y sqlite3

RUN mamba install --yes \
     'r-rmarkdown' \
     'r-gert' \
     'r-tinytex'\
     'r-gridExtra'\
     'r-kableExtra'

# install python packaegs
RUN apt install -y wget \
    git \
    python3 \
    python3-pip \
    python3-dev \
    graphviz

RUN pip3 install notebook \
    jupyterlab \
    jupyterlab-git \
    scipy \
    seaborn \
    scikit-learn \
    sympy \
    inferactively-pymdp\
    bokeh \
    pyhgf \
    unidic-lite \
    mecab-python3 \
    pyyaml \
    nbformat \
    nbclient \
    pyswarms \
    pymc

# install Quarto
## AMD64
#wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.551/quarto-1.4.551-linux-amd64.tar.gz
RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.551/quarto-1.4.551-linux-arm64.tar.gz
RUN mkdir ~/opt
# AMD64
#tar -C ~/opt -xvzf quarto-1.4.551-linux-amd64.tar.gz
RUN tar -C ~/opt -xvzf quarto-1.4.551-linux-arm64.tar.gz
RUN mkdir ~/bin
RUN ln -s ~/opt/quarto-1.4.551/bin/quarto ~/bin/quarto
RUN ( echo ""; echo 'export PATH=$PATH:~/bin\n' ; echo "" ) >> ~/.profile
RUN source ~/.profile

