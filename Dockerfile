# Use official Tomcat image with Java 17
FROM tomcat:10.1.12-jdk17

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to Tomcat and name it ROOT.war
COPY dist/YourApp.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
