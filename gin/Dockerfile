# Use official Golang image as base
FROM golang:1.25.1-alpine

# Set working directory
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN go build -o server main.go

# Expose port (default 8080, can be overridden at runtime)
EXPOSE 8000

# Start the server
CMD ["sh", "-c", "./server -port 8000"]