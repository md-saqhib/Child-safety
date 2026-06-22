# Use the official Tomcat image
FROM tomcat:10.1-jdk17

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Create ROOT directory for our app
RUN mkdir -p /usr/local/tomcat/webapps/ROOT

# Copy the webapp folder contents (JSP, WEB-INF, lib) to ROOT
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Copy the compiled Java classes to WEB-INF/classes
COPY build/classes/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
