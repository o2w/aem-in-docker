# Use the previously created aem-base-image
FROM aem-base-image

# Expose AEM author in port 4502
EXPOSE 4502

RUN export JAVA_HOME="/usr/lib/jvm/jdk-11" && \
    echo $JAVA_HOME && \
    java --version

# Make the container start always in Author mode with Port 4502
ENTRYPOINT ["java", "-jar", "cq-quickstart.jar", "-Dsling.run.modes=author", "-p", "4502"]
