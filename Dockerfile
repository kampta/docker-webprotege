FROM tomcat:9.0-jre8
MAINTAINER Kamal Gupta <kamalgupta308@gmail.com>

# Remove unnecessary packages
WORKDIR /usr/local/tomcat/webapps
RUN rm -rf *
RUN mkdir -p /data/webprotege

# Download latest webprotege
RUN wget -q --no-check-certificate -O webprotege.war https://github.com/protegeproject/webprotege/releases/download/v2.6.0/webprotege-2.6.0.war
RUN unzip -q webprotege.war -d ROOT && rm webprotege.war

# Add properties file to webprotege webapps folder
RUN touch ROOT/webprotege.properties
RUN echo \
  webprotege.data.directory=/data/webprotege"\n" \
  webprotege.application.host=localhost"\n" \
  > ROOT/webprotege.properties
RUN echo "\n"mongodb.host=mongo"\n" >> ROOT/WEB-INF/classes/webprotege.properties

EXPOSE 8080

CMD catalina.sh run