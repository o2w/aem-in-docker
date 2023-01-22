# Use the previously created aem6.X.0
# If you want aem6.4.0, run
# docker-compose build --build-arg AEM_IMAGE=aem6.4.0
ARG AEM_IMAGE=aem6.5.0
FROM ${AEM_IMAGE}

# Expose AEM author in port 4502
EXPOSE 4502

RUN export JAVA_HOME="/usr/lib/jvm/jdk-11" && \
    echo $JAVA_HOME && \
    java -version

RUN test -f "./cq-quickstart.jar" && mv ./cq-quickstart.jar ./aem-author-p4502.jar

# Make the container start always in Author mode with Port 4502
ENTRYPOINT ["java", "-jar", "aem-author-p4502.jar", "-forkargs", "--", "-Xmx2048m" ]
