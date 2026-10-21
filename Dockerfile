FROM tomcat:10.1-jdk21-temurin AS build
WORKDIR /app
COPY app/index.jsp .
RUN jar -cf java-application.war index.jsp
FROM tomcat:10.1-jre21-temurin-noble
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/java-application.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh","run"]
