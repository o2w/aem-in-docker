# Using 'ubuntu' as the base image here
FROM ubuntu

# setting the working directory
WORKDIR /opt/aem

# Copy the license file
#COPY license.properties .

# Copy Quickstart jar file
COPY aem-sdk-quickstart.jar cq-quickstart.jar

COPY jdk-11.0.19_linux-x64_bin.deb /tmp/jdk-11.0.19_linux-x64_bin.deb

# Install Java
# https://stackoverflow.com/a/54925400
RUN apt-get update
RUN apt-get install -y nodejs maven
RUN apt-get install -y libasound2
RUN dpkg -i /tmp/jdk-11.0.19_linux-x64_bin.deb
RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11/bin/java 11111

RUN node -v
RUN mvn -v

# https://stackoverflow.com/questions/43655291/dynamically-set-java-home-of-docker-container
RUN export JAVA_HOME="/usr/lib/jvm/jdk-11" && \
    echo $JAVA_HOME && \
    java --version && \
    java -jar cq-quickstart.jar -unpack

RUN mkdir crx-quickstart/install

COPY install crx-quickstart/install

#RUN export COMMERCE_ENDPOINT=https

# docker run --rm -ti --memory=24g aem6.5.0java
#COPY *.java /src/
#RUN mkdir /app \
#    && ls /src \
#    && /usr/lib/jvm/jdk-11/bin/javac /src/PrintXmxXms.java -d /app
#CMD ["sh", "-c", \
#     "java -version \
#      && java -cp /app PrintXmxXms"]
