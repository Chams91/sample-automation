#!/bin/bash

echo "Starting smoke tests..."

# Test if application is responding
echo "1. Testing if application is up..."
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/home)

if [ "$response" -eq 200 ]; then
    echo "✓ Application is responding (HTTP $response)"
else
    echo "✗ Application not responding properly (HTTP $response)"
    exit 1
fi

# Test the /home endpoint content
echo "2. Testing /home endpoint content..."
content=$(curl -s http://localhost:8080/home)

if [ "$content" = "Hello World!" ]; then
    echo "✓ /home endpoint returns correct content: '$content'"
else
    echo "✗ /home endpoint returned wrong content: '$content'"
    exit 1
fi

# Test health endpoint
echo "3. Testing health endpoint..."
health_response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health)

if [ "$health_response" -eq 200 ]; then
    echo "✓ Health endpoint is working (HTTP $health_response)"
else
    echo "✗ Health endpoint not working (HTTP $health_response)"
    exit 1
fi

echo "✓✓✓ All smoke tests passed! ✓✓✓"