FROM ubuntu:22.04

# Install prerequisites
RUN apt-get update && apt-get install -y build-essential libgmp-dev libmpfr-dev libmpc-dev libisl-dev flex bison wget g++


WORKDIR /workspace

COPY . /workspace

RUN chmod +x /workspace/build.sh

RUN /workspace/build.sh 

RUN cat /workspace/hash

