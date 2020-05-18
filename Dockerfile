FROM circleci/ruby:2.7.1-buster-node-browsers

USER root

RUN apt-get update && \
    apt install -y default-mysql-client && \
    rm -rf /var/lib/apt/lists/*

USER circleci
