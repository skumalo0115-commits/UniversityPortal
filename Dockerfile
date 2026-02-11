FROM tomcat:9.0.89-jdk17-temurin

RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml

COPY dist/UniversityPortal.war /usr/local/tomcat/webapps/ROOT.war

