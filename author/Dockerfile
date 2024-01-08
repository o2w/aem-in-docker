# Use the previously created aem6.X.0
# If you want aem6.4.0, run
# docker-compose build --build-arg AEM=aem6.4.0
ARG AEM=''
FROM ${AEM}

# Expose AEM author in port 4502
EXPOSE 4502

ENV TESTVAR=testvar
ENV COMMERCE_ENDPOINT=

RUN export JAVA_HOME="/usr/lib/jvm/jdk-11-oracle-x64" && \
    echo $JAVA_HOME && \
    java -version

RUN test -f "./cq-quickstart.jar" && mv ./cq-quickstart.jar ./aem-author-p4502.jar

#Java HotSpot(TM) 64-Bit Server VM warning: Ignoring option MaxPermSize; support was removed in 8.0
#https://stackoverflow.com/questions/22634644/java-hotspottm-64-bit-server-vm-warning-ignoring-option-maxpermsize

# Make the container start always in Author mode with Port 4502
ENTRYPOINT ["java", "-Xmx4048m", "-server",  "-Djava.awt.headless=true", "-jar", "aem-author-p4502.jar", "-forkargs", "--", "-Xmx4048m" ]
