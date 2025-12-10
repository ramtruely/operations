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
