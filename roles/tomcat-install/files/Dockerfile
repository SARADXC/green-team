FROM centos

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN wget http://apachemirror.wuchna.com/tomcat/tomcat-9/v9.0.31/bin/apache-tomcat-9.0.31.tar.gz
RUN tar xvfz apache-tomcat-9.0.31.tar.gz
RUN mv apache-tomcat-9.0.31/* /opt/tomcat/.
RUN yum -y install java
RUN java -version

WORKDIR /opt/tomcat/webapps

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
