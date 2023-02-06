# Using 'ubuntu' as the base image here
FROM ubuntu

# setting the working directory
WORKDIR /opt/aem

# Copy the license file
COPY license.properties .

# Copy Quickstart jar file
COPY cq-quickstart-6.5.0.jar cq-quickstart.jar

RUN mkdir -p /usr/lib/jvm
COPY jdk-11.0.17_linux-aarch64_bin.tar.gz /usr/lib/jvm/jdk-11.0.17_linux-aarch64_bin.tar.gz

# Install Java
# https://stackoverflow.com/a/54925400
RUN apt-get update && \
    apt-get install -y libasound2
RUN cd /usr/lib/jvm && tar xzvf jdk-11.0.17_linux-aarch64_bin.tar.gz
#RUN ls /tmp/jdk-11.0.17
#RUN /tmp/jdk-11.0.17/bin/java -version
#RUN cp -r /tmp/jdk-11.0.17 /usr/lib/jvm/
#RUN ls /usr/lib/jvm/jdk17
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.17/bin/java 1

# https://stackoverflow.com/questions/43655291/dynamically-set-java-home-of-docker-container
RUN export JAVA_HOME="/usr/lib/jvm/jdk-11.0.17" && \
    echo $JAVA_HOME && \
    java --version && \
    java -jar cq-quickstart.jar -unpack

# docker run --rm -ti --memory=24g aem6.5.0java
#COPY *.java /src/
#RUN mkdir /app \
#    && ls /src \
#    && /usr/lib/jvm/jdk-11/bin/javac /src/PrintXmxXms.java -d /app
#CMD ["sh", "-c", \
#     "java -version \
#      && java -cp /app PrintXmxXms"]
