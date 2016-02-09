FROM java:openjdk-8-jdk
MAINTAINER Sam Hamilton <sam@sh81.com>

# Upgrade
RUN apt-get update && apt-get upgrade -y

# Moqui, Mantle and SimpleScreens
WORKDIR /opt
COPY moqui-framework /opt/moqui
COPY moqui-runtime /opt/moqui/runtime
COPY mantle-udm /opt/moqui/runtime/component/mantle-udm
COPY mantle-usl /opt/moqui/runtime/component/mantle-usl
COPY SimpleScreens /opt/moqui/runtime/component/SimpleScreens

WORKDIR /opt/moqui
RUN ./gradlew cleanAll
RUN ./gradlew build

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
