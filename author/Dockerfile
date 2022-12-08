# Use the previously created aem6.5.0
FROM aem6.5.0

# Expose AEM author in port 4502
EXPOSE 4502

RUN export JAVA_HOME="/usr/lib/jvm/jdk-11" && \
    echo $JAVA_HOME && \
    java --version

RUN test -f "./cq-quickstart.jar" && mv ./cq-quickstart.jar ./aem-author-p4502.jar

# Make the container start always in Author mode with Port 4502
ENTRYPOINT ["java", "-jar", "aem-author-p4502.jar", "-forkargs", "--", "-Xmx2048m" ]
