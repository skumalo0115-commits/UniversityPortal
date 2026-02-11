# Use Tomcat 9 (javax.servlet namespace) with Java 17.
# The app currently uses javax.servlet APIs, which are not compatible with Tomcat 10+ (jakarta.servlet).
FROM tomcat:9.0-jdk17-temurin tomcat:10.1.12-jdk17

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Disable Tomcat shutdown port to avoid noisy health-check warnings on some hosts
RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml

# Copy your WAR file to Tomcat and name it ROOT.war
COPY dist/UniversityPortal.war /usr/local/tomcat/webapps/ROOT.war 

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
