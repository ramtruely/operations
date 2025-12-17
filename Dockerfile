docker run --rm us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest cat /etc/os-release

...
# Use your internal Ubuntu image from GAR
FROM us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest

# Force bash login shell (THIS IS THE KEY FIX)
SHELL ["/bin/bash", "-lc"]

# Install Java + tools
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

# Install SDKMAN (now it WILL create /root/.sdkman)
RUN curl -s "https://get.sdkman.io" | bash

# Install Groovy using SDKMAN
RUN sdk install groovy 5.0.2

# Environment variables
ENV SDKMAN_DIR=/root/.sdkman
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$SDKMAN_DIR/candidates/groovy/current/bin:$PATH

WORKDIR /workspace

ENTRYPOINT ["groovy"]
