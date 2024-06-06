#!/bin/bash

# Wait for the extract.war file to be extracted
while [ ! -d "/usr/local/tomcat/webapps/extract/META-INF" ]
do
  sleep 1
done

# Copy the context.xml file
cp /tmp/application/context.xml /usr/local/tomcat/webapps/extract/META-INF/context.xml
cp /tmp/application/application.properties webapps/extract/WEB-INF/classes/project.properties

# Start Tomcat in the foreground
exec /usr/local/tomcat/bin/catalina.sh run