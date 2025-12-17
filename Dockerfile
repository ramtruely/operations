docker run --rm us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest cat /etc/os-release

...
# Use your internal Ubuntu image from GAR
FROM us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest

# Install OpenJDK 11 and required tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openjdk-11-jdk \
        curl \
        unzip \
        git \
        wget \
        zip \
        bash \
        && rm -rf /var/lib/apt/lists/*

# Install SDKMAN!
RUN curl -s "https://get.sdkman.io" | bash

# Set SDKMAN environment variables for Docker
ENV SDKMAN_DIR=/root/.sdkman
ENV PATH=$SDKMAN_DIR/candidates/groovy/current/bin:$PATH

# Install Groovy using SDKMAN in one bash command
RUN bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && sdk install groovy 5.0.2"

# Set JAVA_HOME for OpenJDK 11
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Set working directory
WORKDIR /workspace

# Optional: default entrypoint
ENTRYPOINT ["groovy"]
