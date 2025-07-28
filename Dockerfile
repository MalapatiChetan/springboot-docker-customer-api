# Start from a lightweight Java 17 image
FROM eclipse-temurin:17-jre-alpine

# Install postgresql-client to get pg_isready command
RUN apk add --no-cache postgresql-client

# Set working directory
WORKDIR /app

# Copy the built JAR file and wait script into the image
COPY backend/target/customer-api-0.0.1-SNAPSHOT.jar app.jar
COPY wait-for.sh wait-for.sh

# Make the wait script executable
RUN chmod +x wait-for.sh

# Expose port used by Spring Boot app
EXPOSE 8080

# Use wait-for.sh to wait for the DB before starting the app
ENTRYPOINT ["./wait-for.sh", "db", "java", "-jar", "app.jar"]

