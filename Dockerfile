# ── Stage 1: Compile Java source files inside Docker ──────────────────────────
FROM tomcat:10.1-jdk21 AS compiler

WORKDIR /build

# Download PostgreSQL JDBC driver
RUN apt-get update && apt-get install -y wget && \
    wget -q https://jdbc.postgresql.org/download/postgresql-42.7.3.jar -O /postgresql.jar

# Copy Java source files
COPY src/main/java/ /build/src/

# Copy webapp lib directory
COPY src/main/webapp/WEB-INF/lib/ /build/lib/

# Compile all Java files using Tomcat servlet API + PostgreSQL driver
RUN find /build/src -name "*.java" > /build/sources.txt && \
    mkdir -p /build/classes && \
    javac -cp "/build/lib/*:/usr/local/tomcat/lib/*:/postgresql.jar" \
          -d /build/classes \
          @/build/sources.txt

# ── Stage 2: Run with Tomcat ───────────────────────────────────────────────────
FROM tomcat:10.1-jdk21

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*
RUN mkdir -p /usr/local/tomcat/webapps/ROOT

# Copy webapp (JSPs, WEB-INF, lib)
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Remove MySQL connector and add PostgreSQL driver instead
RUN rm -f /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/mysql-connector-j-9.7.0.jar
RUN apt-get update && apt-get install -y wget && \
    wget -q https://jdbc.postgresql.org/download/postgresql-42.7.3.jar \
         -O /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/postgresql-42.7.3.jar

# Copy freshly compiled classes from Stage 1
COPY --from=compiler /build/classes/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Copy schema init script
COPY init_schema.sql /init_schema.sql

# Copy and set entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
