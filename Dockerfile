FROM tomcat:9.0.89-jdk17-temurin AS builder

WORKDIR /build

COPY src/java ./src/java
COPY web ./web
COPY dist/UniversityPortal.war /tmp/UniversityPortal.war

# Reuse the MySQL connector already bundled in the repository WAR
RUN mkdir -p /build/lib /build/_extract \
    && cd /build/_extract \
    && jar xf /tmp/UniversityPortal.war WEB-INF/lib/mysql-connector-j-9.4.0.jar \
    && cp WEB-INF/lib/mysql-connector-j-9.4.0.jar /build/lib/

# Compile all Java sources without NetBeans/Ant
RUN mkdir -p /build/web/WEB-INF/classes /build/web/WEB-INF/lib \
    && javac -encoding UTF-8 \
      -cp "/usr/local/tomcat/lib/servlet-api.jar:/build/lib/mysql-connector-j-9.4.0.jar" \
      -d /build/web/WEB-INF/classes \
      $(find /build/src/java -name "*.java") \
    && cp /build/lib/mysql-connector-j-9.4.0.jar /build/web/WEB-INF/lib/

# Build WAR directly from current source + web assets
RUN cd /build/web && jar cf /build/ROOT.war .

FROM tomcat:9.0.89-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml
 
COPY --from=builder /build/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
