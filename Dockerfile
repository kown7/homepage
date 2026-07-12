FROM ubuntu:bionic

RUN apt update && apt install -y ghc haskell-stack build-essential zlib1g-dev locales
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
RUN locale-gen en_US.UTF-8
ADD . /app
WORKDIR /app
RUN stack build --system-ghc
RUN stack exec site build --system-ghc
