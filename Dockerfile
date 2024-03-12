FROM jupyter/datascience-notebook:latest
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

USER root
# Install ipaexfont
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
     'r-kableExtra'\
     'r-lme4'\
     'r-ltm'\
     'r-loo'\
     'r-psycho'\
     'r-psych'\
     'r-rjags'\
     'r-Rsolnp'\
     'r-rtdists'\
     'r-DstarM'\
     'r-hBayesDM'\
     'r-gemtc'\
     'r-netmeta'\
     'r-ggnetwork'\
     'r-qgraph'\
     'r-IsingFit'\
     'r-IsingSampler'\
     'r-mlVAR'\
     'r-graphicalVAR'\
     'r-bootnet'\
     'r-mgm'\
     'r-NetworkComparisonTest'\
     'r-networktools'\
     'r-gimme'\
     'r-NetworkToolbox'\
     'r-EGAnet'\
     'r-JuliaCall'\
     'r-psychonetrics'\
     'r-BGGM'\
     'r-JuliaConnectoR'

# install CMDSTAN_HOME
RUN Rscript -e 'remotes::install_github("stan-dev/posterior")'
RUN Rscript -e 'install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))'
# install R packages from GitHub
RUN Rscript -e 'remotes::install_github(c("MathiasHarrer/dmetar","ykunisato/jpaRmd","ykunisato/psyinfr"), dependencies = TRUE)'

# install python packaegs
RUN apt install -y wget \
    git \
    python3 \
    python3-pip \
    python3-dev

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
    pyswarms

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

