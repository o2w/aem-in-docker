# Use the previously created aem-base-image
FROM aem-base-image

# Expose AEM Publisher in port 4502
EXPOSE 4503

RUN export JAVA_HOME="/usr/lib/jvm/jdk-11" && \
    echo $JAVA_HOME && \
    java --version

# Make the container start always in Publisher mode with Port 4502
ENTRYPOINT ["java", "-jar", "cq-quickstart.jar", "-Dsling.run.modes=publisher", "-p", "4503"]
