#!/bin/bash
# Build script for Microservicios-Cine

echo "Building all microservices..."
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Build successful!"
    echo ""
    echo "To run the services:"
    echo "1. Start Eureka Server: cd eureka-server && java -jar target/eureka-server-1.0.0.jar"
    echo "2. Start API Gateway: cd api-gateway && java -jar target/api-gateway-1.0.0.jar"
    echo "3. Start Movie Service: cd movie-service && java -jar target/movie-service-1.0.0.jar"
    echo "4. Start Booking Service: cd booking-service && java -jar target/booking-service-1.0.0.jar"
    echo "5. Start User Service: cd user-service && java -jar target/user-service-1.0.0.jar"
    echo ""
    echo "Or use Docker Compose: docker-compose up -d"
else
    echo ""
    echo "✗ Build failed!"
    exit 1
fi
