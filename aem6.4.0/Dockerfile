# Using 'ubuntu' as the base image here
FROM ubuntu

# setting the working directory
WORKDIR /opt/aem

# Copy the license file
COPY license.properties .

# Copy Quickstart jar file
COPY cq-quickstart-6.4.0.jar cq-quickstart.jar

COPY jdk-8u351-linux-x64.tar.gz /tmp/jdk-8u351-linux-x64.tar.gz

# Install Java
# https://stackoverflow.com/a/54925400
#TODO: unabailable repos
#RUN apt-get update
#RUN apt-get install -y libasound2
#https://experienceleague.adobe.com/docs/experience-manager-64/deploying/introduction/technical-requirements.html?lang=en
RUN mkdir -p /usr/lib/jvm
RUN tar -xf /tmp/jdk-8u351-linux-x64.tar.gz -C /usr/lib/jvm/ && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_351/bin/java 1

# https://stackoverflow.com/questions/43655291/dynamically-set-java-home-of-docker-container
RUN export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_351" && \
    echo $JAVA_HOME && \
    java -version && \
    java -jar cq-quickstart.jar -unpack

# docker run --rm -ti --memory=24g aem6.5.0java
#COPY *.java /src/
#RUN mkdir /app \
#    && ls /src \
#    && /usr/lib/jvm/jdk-11/bin/javac /src/PrintXmxXms.java -d /app
#CMD ["sh", "-c", \
#     "java -version \
#      && java -cp /app PrintXmxXms"]
