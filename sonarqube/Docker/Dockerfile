# Use the official SonarQube image as the base image
FROM sonarqube:latest

# Install Java 17 (OpenJDK)
USER root
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Switch back to the SonarQube user
USER sonarqube
