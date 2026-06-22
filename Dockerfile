# ── Stage 1: Compile Java source files inside Docker ──────────────────────────
FROM tomcat:10.1-jdk21 AS compiler

WORKDIR /build

# Copy Java source files
COPY src/main/java/ /build/src/

# Copy any extra JARs (e.g. mysql-connector)
COPY src/main/webapp/WEB-INF/lib/ /build/lib/

# Find all .java files and compile them
# We use Tomcat's own servlet-api JARs so imports resolve correctly
RUN find /build/src -name "*.java" > /build/sources.txt && \
    mkdir -p /build/classes && \
    javac -cp "/build/lib/*:/usr/local/tomcat/lib/*" \
          -d /build/classes \
          @/build/sources.txt

# ── Stage 2: Run with Tomcat ───────────────────────────────────────────────────
FROM tomcat:10.1-jdk21

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Create ROOT webapp directory
RUN mkdir -p /usr/local/tomcat/webapps/ROOT

# Copy the webapp (JSPs, WEB-INF, lib)
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Copy freshly compiled classes from Stage 1
COPY --from=compiler /build/classes/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
