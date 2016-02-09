FROM java:openjdk-8-jdk
MAINTAINER Sam Hamilton <sam@sh81.com>

# Upgrade
RUN apt-get update && apt-get upgrade -y

# Moqui Framework and Moqui Runtime
COPY moqui-framework /opt/moqui
COPY moqui-runtime /opt/moqui/runtime

# We build Moqui at this point to cache most of jar dependencies
WORKDIR /opt/moqui
RUN ./gradlew build

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
