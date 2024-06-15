# Use the official Jenkins base image
FROM jenkins/jenkins:lts

# Switch to root user to install dependencies
USER root

# Install Java 17 (OpenJDK)
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    rm -rf /var/lib/apt/lists/*

# Install Sonar Scanner
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip -O /tmp/sonar-scanner.zip && \
    unzip /tmp/sonar-scanner.zip -d /opt && \
    mv /opt/sonar-scanner-4.8.0.2856-linux /opt/sonar-scanner && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/bin/sonar-scanner && \
    rm /tmp/sonar-scanner.zip

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:/opt/sonar-scanner/bin:$PATH
ENV SONAR_RUNNER_HOME=/opt/sonar-scanner

# Switch back to the Jenkins user
USER jenkins
