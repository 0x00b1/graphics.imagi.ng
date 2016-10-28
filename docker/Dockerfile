FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Nick Pawlowski <npawlow@broadinstitute.org>

ENV CFLAGS "-O2"

ENV CUDA_HOME "/usr/local/cuda"

ENV CUDA_PATH "/usr/local/cuda"

ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/nvidia/lib64/:/usr/lib/x86_64-linux-gnu/:/usr/local/cuda/targets/x86_64-linux/lib/stubs/"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/nvidia/bin:$PATH

ENV PYTHON_CONFIGURE_OPTS "--enable-shared"

ENV TERM linux

ENV DEBIAN_FRONTEND noninteractive

RUN ln -s /usr/local/nvidia/lib64/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so

RUN echo 'CUDA_HOME=/usr/local/cuda' >> /etc/environment

RUN echo 'CUDA_PATH=/usr/local/cuda' >> /etc/environment

RUN apt-get update                                && \
    apt-get install --no-install-recommends --yes    \
      build-essential                                \
      ca-certificates                                \
      cmake                                          \
      curl                                           \
      debconf-utils                                  \
      gcc                                            \
      g++                                            \
      gfortran                                       \
      gnuplot                                        \
      git                                            \
      hdf5-tools                                     \
      libatlas-base-dev                              \
      libboost-all-dev                               \
      libbz2-dev                                     \
      libfftw3-dev                                   \
      libfreetype6-dev                               \
      libgflags-dev                                  \
      libgoogle-glog-dev                             \
      libgraphicsmagick1-dev                         \
      libhdf5-serial-dev                             \
      libjpeg8-dev                                   \
      libleveldb-dev                                 \
      liblmdb-dev                                    \
      libmysqlclient-dev                             \
      libncurses5-dev                                \
      libncursesw5-dev                               \
      libopencv-dev                                  \
      libpng12-dev                                   \
      libprotobuf-dev                                \
      libreadline-dev                                \
      libsdl2-dev                                    \
      libsnappy-dev                                  \
      libsox-dev                                     \
      libsox-fmt-all                                 \
      libsqlite3-dev                                 \
      libssl-dev                                     \
      libsuitesparse-dev                             \
      libtiff5-dev                                   \
      libxml2-dev                                    \
      libxslt1-dev                                   \
      libzmq3-dev                                    \
      llvm                                           \
      make                                           \
      nano                                           \
      nodejs-legacy                                  \
      npm                                            \
      openssh-server                                 \
      pkg-config                                     \
      protobuf-compiler                              \
      python-dev                                     \
      python-pip                                     \
      python-software-properties                     \
      python-vigra                                   \
      python-wxgtk2.8                                \
      rsync                                          \
      software-properties-common                     \
      sox                                            \
      supervisor                                     \
      swig                                           \
      tk-dev                                         \
      tmux                                           \
      unzip                                          \
      vim                                            \
      wget                                           \
      xz-utils                                       \
      zlib1g-dev

RUN apt-get update                                                                                                              && \
    add-apt-repository ppa:webupd8team/java                                                                                     && \
    apt-get update                                                                                                              && \
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections                      && \
    apt-get install --no-install-recommends -y oracle-java8-installer                                                           && \
    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list && \
    curl https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg | sudo apt-key add -                                      && \
    apt-get update                                                                                                              && \
    apt-get install --no-install-recommends -y bazel                                                                            && \
    apt-get clean                                                                                                               && \
    rm -rf /var/lib/apt/lists/*

RUN npm install --global      \
      configurable-http-proxy

RUN git clone https://github.com/xianyi/OpenBLAS.git /srv/OpenBLAS
RUN cd /srv/OpenBLAS && make NO_AFFINITY=1 USE_OPENMP=1 && make install

ENV CMAKE_LIBRARY_PATH /opt/OpenBLAS/include:/opt/OpenBLAS/lib:$CMAKE_LIBRARY_PATH

RUN mkdir -p /srv/src/ && cd /srv/src/            && \
    git clone https://github.com/yyuu/pyenv.git   && \
    cd pyenv/plugins/python-build                 && \
    ./install.sh

RUN git clone https://github.com/tensorflow/tensorflow /srv/src/tensorflow   && \
    cd /srv/src/tensorflow                                                   && \
    sed -i 's/read b || true/#read b || true/g' util/python/python_config.sh

COPY configure_auto /srv/src/tensorflow

#####
# Install python 2
#

RUN python-build 2.7.12 /usr/local/               && \
    pip install --upgrade pip                     && \
    pip install --upgrade wheel                   && \
    pip install --upgrade                            \
      alembic                                        \
      amqp                                           \
      blaze                                          \
      boto                                           \
      celery                                         \
      cffi                                           \
      coverage                                       \
      cython                                         \
      dask                                           \
      flask                                          \
      h5py                                           \
      imageio                                        \
      ipykernel                                      \
      ipyparallel                                    \
      joblib                                         \
      jsonschema                                     \
      jupyter                                        \
      keras                                          \
      line_profiler                                  \
      lxml                                           \
      memory_profiler                                \
      mock                                           \
      networkx                                       \
      nose                                           \
      numpy                                          \
      odo                                            \
      pandas                                         \
      psutil                                         \
      pyamg                                          \
      pyflakes                                       \
      pytest                                         \
      python-dateutil                                \
      pytz                                           \
      pyzmq                                          \
      redis                                          \
      requests                                       \
      scikit-image                                   \
      scikit-learn                                   \
      scipy                                          \
      seaborn                                        \
      simpleitk                                      \
      simplejson                                     \
      sphinx                                         \
      sqlalchemy                                     \
      statsmodels                                    \
      stevedore                                      \
      sympy                                          \
      theano                                         \
      tqdm

RUN cd /srv/src/                                               && \
    git clone https://github.com/CellProfiler/CellProfiler.git && \
    cd CellProfiler                                            && \
    git checkout stable                                        && \
    pip install -e .

ENV CAFFE_ROOT=/srv/src/caffe

RUN cd /srv/src                                                                 && \
    git clone --depth 1 https://github.com/BVLC/caffe.git caffe                 && \
    cd caffe                                                                    && \
    for req in $(cat python/requirements.txt) pydot; do pip2 install $req; done && \
    mkdir build && cd build                                                     && \
    cmake -DUSE_CUDNN=1 ..                                                      && \
    make -j"$(nproc)"

RUN echo 'PYTHONPATH="$PYTHONPATH:/srv/src/caffe/python"' >> /etc/environment

RUN echo 'PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/nvidia/bin:/srv/src/caffe/build/tools:/srv/src/caffe/python"' > /etc/environment

RUN echo 'LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/nvidia/lib64/:/opt/OpenBLAS/lib:/srv/src/caffe/build/lib' >> /etc/environment

RUN cd /srv/src/tensorflow                                                                                            && \
    export PYTHON_BIN_PATH=$(which python2)                                                                           && \
    export TF_NEED_GCP=0                                                                                              && \
    export TF_NEED_HDFS=0                                                                                             && \
    export TF_NEED_CUDA=1                                                                                             && \
    export GCC_HOST_COMPILER_PATH=$(which gcc)                                                                        && \
    export TF_CUDA_VERSION=8.0                                                                                        && \
    export CUDA_TOOLKIT_PATH=/usr/local/cuda                                                                          && \
    export CUDNN_INSTALL_PATH=/usr/local/cuda                                                                         && \
    export TF_CUDA_COMPUTE_CAPABILITIES=5.2,6.1                                                                       && \
    export TF_CUDNN_VERSION=''                                                                                        && \
    ./configure_auto                                                                                                  && \
    bazel build --ignore_unsupported_sandboxing -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg                                      && \
    pip2 install /tmp/tensorflow_pkg/tensorflow-*.whl                                                                 && \
    rm /tmp/tensorflow_pkg/tensorflow*.whl

#####
# Install python 3
#

RUN python-build 3.5.2 /usr/local/                && \
    pip3 install --upgrade pip                    && \
    pip3 install --upgrade wheel                  && \
    pip3 install --upgrade                           \
      aiohttp                                        \
      alembic                                        \
      amqp                                           \
      blaze                                          \
      boto                                           \
      celery                                         \
      cffi                                           \
      coverage                                       \
      cython                                         \
      dask                                           \
      flask                                          \
      h5py                                           \
      imageio                                        \
      ipykernel                                      \
      ipyparallel                                    \
      joblib                                         \
      jsonschema                                     \
      jupyter                                        \
      jupyterhub                                     \
      keras                                          \
      line_profiler                                  \
      lxml                                           \
      memory_profiler                                \
      mock                                           \
      networkx                                       \
      nose                                           \
      numpy                                          \
      oauthenticator                                 \
      odo                                            \
      pandas                                         \
      psutil                                         \
      pyamg                                          \
      pyflakes                                       \
      pytest                                         \
      python-dateutil                                \
      pytz                                           \
      pyzmq                                          \
      redis                                          \
      requests                                       \
      scikit-image                                   \
      scikit-learn                                   \
      scipy                                          \
      seaborn                                        \
      simpleitk                                      \
      simplejson                                     \
      sphinx                                         \
      sqlalchemy                                     \
      statsmodels                                    \
      stevedore                                      \
      sympy                                          \
      theano                                         \
      tqdm

RUN cd /srv/src/tensorflow                                                                                            && \
    export PYTHON_BIN_PATH=$(which python3)                                                                           && \
    export TF_NEED_GCP=0                                                                                              && \
    export TF_NEED_HDFS=0                                                                                             && \
    export TF_NEED_CUDA=1                                                                                             && \
    export GCC_HOST_COMPILER_PATH=$(which gcc)                                                                        && \
    export TF_CUDA_VERSION=8.0                                                                                        && \
    export CUDA_TOOLKIT_PATH=/usr/local/cuda                                                                          && \
    export CUDNN_INSTALL_PATH=/usr/local/cuda                                                                         && \
    export TF_CUDA_COMPUTE_CAPABILITIES=5.2,6.1                                                                       && \
    export TF_CUDNN_VERSION=''                                                                                        && \
    ./configure_auto                                                                                                  && \
    bazel build --ignore_unsupported_sandboxing -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package && \
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg                                      && \
    pip3 install /tmp/tensorflow_pkg/tensorflow-*.whl

RUN python2 -m ipykernel install


#####
# Install R
#

RUN echo "deb http://cran.cnr.berkeley.edu/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list                                      && \
    gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9                                                                       && \
    gpg -a --export E084DAB9 | apt-key add -                                                                                       && \
    apt-get update                                                                                                                 && \
    apt-get install -y --no-install-recommends r-base r-base-dev libssh-dev libgsl0-dev libcurl4-gnutls-dev                        && \
    echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile                 && \
    R -e "install.packages(c('repr', 'IRdisplay', 'doMC', 'dplyr', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))" && \
    R -e "devtools::install_github('IRkernel/IRkernel')"                                                                           && \
    R -e "devtools::install_github('CellProfiler/cytominr')"                                                                       && \
    R -e "IRkernel::installspec(user = FALSE)"

RUN apt-get install -y --no-install-recommends gdebi-core                && \
    wget https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb && \
    gdebi --n rstudio-server-0.99.903-amd64.deb                          && \
    rstudio-server verify-installation

#####
# Install torch
#

RUN git clone https://github.com/torch/luajit-rocks.git /srv/luajit-rocks
RUN cd /srv/luajit-rocks                                                                     && \
    mkdir build                                                                              && \
    cd build                                                                                 && \
    git checkout master                                                                      && \
    git pull                                                                                 && \
    rm -f CMakeCache.txt                                                                     && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DWITH_LUAJIT21=ON && \
    make                                                                                     && \
    make install                                                                             && \
    luarocks install sundown                                                                 && \
    luarocks install cwrap                                                                   && \
    luarocks install paths                                                                   && \
    luarocks install torch                                                                   && \
    luarocks install nn                                                                      && \
    luarocks install dok                                                                     && \
    luarocks install gnuplot                                                                 && \
    luarocks install luafilesystem                                                           && \
    luarocks install penlight                                                                && \
    luarocks install sys                                                                     && \
    luarocks install image                                                                   && \
    luarocks install optim                                                                   && \
    luarocks install lua-cjson                                                               && \
    luarocks install trepl                                                                   && \
    luarocks install nnx                                                                     && \
    luarocks install threads                                                                 && \
    luarocks install graphicsmagick                                                          && \
    luarocks install argcheck                                                                && \
    luarocks install audio                                                                   && \
    luarocks install signal                                                                  && \
    luarocks install gfx.js                                                                  && \
    luarocks install cutorch                                                                 && \
    luarocks install cunn                                                                    && \
    luarocks install loadcaffe                                                               && \
    luarocks install nninit                                                                  && \
    git clone https://github.com/deepmind/torch-hdf5.git /srv/torch-hdf5                     && \
    cd /srv/torch-hdf5                                                                       && \
    luarocks make hdf5-0-0.rockspec LIBHDF5_LIBDIR="/usr/lib/x86_64-linux-gnu/"              && \
    git clone https://github.com/facebook/iTorch.git /srv/itorch                             && \
    cd /srv/itorch                                                                           && \
    luarocks make

#####
# Configuration
#

RUN mkdir /srv/jupyter

ENV OAUTHENTICATOR_DIR /srv/jupyter

COPY jupyterhub_config.py /srv/jupyter/jupyterhub_config.py

COPY addusers.sh /srv/jupyter/addusers.sh

COPY userlist /srv/jupyter/userlist

RUN chmod 700 /srv/jupyter

RUN ["sh", "/srv/jupyter/addusers.sh"]

RUN mkdir /var/run/sshd

RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config

RUN mkdir /srv/supervisord

RUN mkdir -p /var/log/supervisord

COPY supervisord.conf /srv/supervisord/supervisord.conf

COPY ssh /etc/ssh

ENV PYTHONPATH=$PYTHONPATH:/srv/src/caffe/python

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/nvidia/bin:/srv/src/caffe/build/tools:/srv/src/caffe/python:$PATH

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/nvidia/lib64/:/srv/src/caffe/build/lib:/opt/OpenBLAS/lib

CMD ["supervisord", "-c", "/srv/supervisord/supervisord.conf"]
