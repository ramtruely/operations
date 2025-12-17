docker run --rm us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest cat /etc/os-release

docker run --rm \
  --entrypoint /bin/bash \
  us-central1-docker.pkg.dev/devops-446301/my-docker-repo/groovy-builder-image \
  -c "cat /etc/os-release"


...
# Use your internal Ubuntu image from GAR
FROM us-central1-docker.pkg.dev/<PROJECT>/<REPO>/ubuntu:latest

RUN apt-get update && \
    apt-get install -y \
      openjdk-11-jdk \
      groovy \
      curl \
      unzip \
      wget \
      git \
      zip \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV GROOVY_HOME=/usr/share/groovy
ENV PATH=$GROOVY_HOME/bin:$PATH

WORKDIR /workspace

ENTRYPOINT ["groovy"]
