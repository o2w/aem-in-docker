# Using 'ubuntu' as the base image here
FROM ubuntu

# setting the working directory
WORKDIR /opt/aem

# Copy the license file
COPY license.properties .

# Copy Quickstart jar file
COPY cq-quickstart-6.5.0.jar cq-quickstart.jar


COPY ${JAVADEB} /tmp/jdk-11.x.xx_linux-x64_bin.deb

# Install Java
# https://stackoverflow.com/a/54925400
RUN apt-get update && \
    apt-get install -y libasound2 && \
    dpkg -i /tmp/jdk-11.x.xx_linux-x64_bin.deb && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11/bin/java 1

RUN echo hoge

# https://stackoverflow.com/questions/43655291/dynamically-set-java-home-of-docker-container
RUN export JAVA_HOME="/usr/lib/jvm/jdk-11" && \
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
