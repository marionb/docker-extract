# this might not be the best image!! Requirement is tomcat9 due to Spring Boot 2
FROM tomcat:9.0-jdk8-openjdk

# FROM tomcat:9-jdk11-openjdk-slim
LABEL maintainer Camptocamp "info@camptocamp.com"
SHELL ["/bin/bash", "-o", "pipefail", "-cux"]

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install wget unzip -y

ENV EXTRACT_VERSION=2.0.3

# add settings
COPY resources/application /tmp/application
# COPY startup.sh /usr/bin/startup.sh

RUN wget -O /tmp/extract_v${EXTRACT_VERSION}-RELEASE.zip https://github.com/asit-asso/extract/releases/download/v${EXTRACT_VERSION}/extract_v${EXTRACT_VERSION}-RELEASE.zip \
    && unzip /tmp/extract_v${EXTRACT_VERSION}-RELEASE.zip -d /tmp/extract_v${EXTRACT_VERSION}-RELEASE \
    && cp /tmp/extract_v${EXTRACT_VERSION}-RELEASE/application/extract##${EXTRACT_VERSION}-RELEASE.war /usr/local/tomcat/webapps/extract.war \
    && cp /tmp/application/tomcat-logging.properties /usr/local/tomcat/conf/logging.properties \
    && cp /tmp/application/context.xml conf/context.xml \
    && mkdir -p /var/extract/orders
    # && cp /tmp/application/application.properties /usr/local/tomcat/webapps/extract/WEB-INF/classes/application.properties

# RUN catalina.sh start && sleep 2 \
#     && cp /tmp/application/application.properties /usr/local/tomcat/webapps/extract/WEB-INF/classes/application.properties \
#     && rm -rf /usr/local/tomcat/webapps/extract.war

EXPOSE 8080

# ENTRYPOINT ["/usr/bin/startup.sh"]
# CMD ["/usr/bin/start.sh"]
# Copy configuration
# RUN mkdir -p /var/extract/orders