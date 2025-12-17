docker run --rm us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest cat /etc/os-release

...
FROM maven:3.9.9-eclipse-temurin-8 AS builder

# Set environment variable for Nexus password (CI should override this)
ARG NEXUS3_CREDS
ENV NEXUS3_CREDS=${NEXUS3_CREDS}

# Maven settings
RUN mkdir -p /root/.m2
COPY settings.xml /root/.m2/settings.xml

# Project sources
WORKDIR /workspace
COPY pom.xml assembly.xml ./
COPY vars ./vars
COPY src ./src
COPY resources ./resources

# Build + deploy to Nexus
RUN mvn -B clean package deploy

---

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
        && rm -rf /var/lib/apt/lists/*

# Install SDKMAN! to manage Groovy versions
RUN curl -s "https://get.sdkman.io" | bash

# Initialize SDKMAN! and install Groovy
RUN bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install groovy"

# Ensure Groovy and Java are on the PATH
ENV PATH="/root/.sdkman/candidates/groovy/current/bin:${PATH}"
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# Set working directory
WORKDIR /workspace

# Default entrypoint (optional)
ENTRYPOINT ["groovy"]

