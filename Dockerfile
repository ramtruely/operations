docker run --rm us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest cat /etc/os-release

...
# Use your internal Ubuntu image from GAR
FROM us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest

SHELL ["/bin/bash", "-lc"]

RUN apt-get update && \
    apt-get install -y \
      openjdk-11-jdk \
      curl \
      unzip \
      wget \
      git \
      zip \
      bash \
    && rm -rf /var/lib/apt/lists/*

# Install SDKMAN
RUN curl -s "https://get.sdkman.io" | bash

# Install Groovy (THIS IS THE FIX)
RUN source /root/.sdkman/bin/sdkman-init.sh && \
    sdk install groovy 5.0.2

ENV SDKMAN_DIR=/root/.sdkman
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$SDKMAN_DIR/candidates/groovy/current/bin:$PATH

WORKDIR /workspace

ENTRYPOINT ["groovy"]
