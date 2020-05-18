FROM circleci/ruby:2.7.1-buster-node-browsers

ENV DOCKERIZE_VERSION 0.6.1

USER root

RUN apt-get update && \
    apt install -y default-mysql-client && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L -o bin/tusd_linux_amd64.zip https://github.com/tus/tusd/releases/download/v1.1.0/tusd_linux_amd64.tar.gz && \
    tar -xvzf bin/tusd_linux_amd64.zip -C bin/ && \
    rm /bin/tusd_linux_amd64.zip /bin/LICENSE.txt /bin/README.md && \
    wget -q https://github.com/jwilder/dockerize/releases/download/v$DOCKERIZE_VERSION/dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz && rm dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz

USER circleci

RUN git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv \
    && PYTHON_CONFIGURE_OPTS='--enable-shared' ~/.pyenv/bin/pyenv install 3.7.2
