FROM rocker/verse:latest
LABEL maintainer="Yoshihiko Kunisato <kunisato@psy.senshu-u.ac.jp>"

# Install ipaexfont　notofont
RUN apt-get update
RUN apt-get install -y fonts-ipaexfont fonts-noto-cjk fonts-noto-cjk-extra

# install libjpeg & V8 for "psycho"
RUN apt-get install -y libjpeg-dev libv8-dev

# install R packages
COPY install_r.r install_r.r
RUN ["r", "install_r.r"]

# install python packaegs
RUN apt-get install -y python3-pip
RUN pip3 install notebook 

# Install Julia
ARG JULIA_VERSION="1.8.3"
RUN JULIA_MAJOR=`echo $JULIA_VERSION | sed -E  "s/\.[0-9]+$//g"` && \
    wget https://julialang-s3.julialang.org/bin/linux/x64/$JULIA_MAJOR/julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    tar -xvzf julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    cp -r julia-$JULIA_VERSION /opt/ && \
    ln -s /opt/julia-$JULIA_VERSION/bin/julia /usr/local/bin/julia && \
    rm -r julia-$JULIA_VERSION-linux-x86_64.tar.gz

RUN chown -hR rstudio:staff /opt/julia-$JULIA_VERSION

USER rstudio
RUN julia -e 'ENV["PYTHON"] = raw"/usr/bin/python3";using Pkg;Pkg.update();Pkg.add(["IJulia","PyCall"]);Pkg.build(["IJulia","PyCall"]);'
RUN julia -e 'using Pkg;Pkg.add(["DataFrames","PyPlot","Distributions","Statistics","CPUTime","GLM","Optim","Plots","RDatasets","StatsBase","StatsFuns","StatsPlots","Turing","LinearAlgebra","ForneyLab"]);Pkg.precompile()'
USER root