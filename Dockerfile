FROM eclipse-temurin:11-jre

WORKDIR /app

# Copy built JAR
COPY target/*.jar app.jar

# Copy SQLite DB
COPY src/main/resources/Database /app/Database

COPY src/main/resources/Database/VAKS.db /app/Database/VAKS.db


# Copy JSP files (required for Tomcat JSP rendering)
COPY src/main/webapp /app/src/main/webapp

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
