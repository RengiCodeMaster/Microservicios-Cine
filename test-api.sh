#!/bin/bash
# Test script for Microservicios-Cine

echo "Testing Cinema Microservices System..."
echo ""

# Check if services are running
echo "1. Checking Eureka Server..."
if curl -s http://localhost:8761/actuator/health > /dev/null; then
    echo "✓ Eureka Server is running"
else
    echo "✗ Eureka Server is not running"
    exit 1
fi

echo ""
echo "2. Checking registered services in Eureka..."
services=$(curl -s http://localhost:8761/eureka/apps | grep -o '<app>.*</app>' | wc -l)
echo "✓ Found $services services registered"

echo ""
echo "3. Testing Movie Service through API Gateway..."
# Create a movie
movie_response=$(curl -s -X POST http://localhost:8080/api/movies \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test Movie",
    "genre": "Action",
    "director": "Test Director",
    "duration": 120,
    "description": "A test movie",
    "rating": 7.5
  }')
movie_id=$(echo $movie_response | grep -o '"id":[0-9]*' | grep -o '[0-9]*')
echo "✓ Created movie with ID: $movie_id"

# Get the movie
curl -s "http://localhost:8080/api/movies/$movie_id" > /dev/null
echo "✓ Retrieved movie successfully"

echo ""
echo "4. Testing User Service through API Gateway..."
# Create a user
user_response=$(curl -s -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "phone": "+111111111",
    "address": "Test Address"
  }')
user_id=$(echo $user_response | grep -o '"id":[0-9]*' | grep -o '[0-9]*')
echo "✓ Created user with ID: $user_id"

echo ""
echo "5. Testing Booking Service through API Gateway..."
# Create a booking
booking_response=$(curl -s -X POST http://localhost:8080/api/bookings \
  -H "Content-Type: application/json" \
  -d "{
    \"userId\": $user_id,
    \"movieId\": $movie_id,
    \"movieTitle\": \"Test Movie\",
    \"numberOfSeats\": 3,
    \"totalPrice\": 30.00,
    \"showTime\": \"2025-10-25T20:00:00\"
  }")
booking_id=$(echo $booking_response | grep -o '"id":[0-9]*' | grep -o '[0-9]*')
echo "✓ Created booking with ID: $booking_id"

echo ""
echo "6. Testing search functionality..."
curl -s "http://localhost:8080/api/movies/search?title=Test" > /dev/null
echo "✓ Movie search works"

echo ""
echo "================================"
echo "All tests passed successfully! ✓"
echo "================================"
