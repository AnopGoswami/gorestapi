# Start from a minimal, lightweight base image
FROM golang:1.16-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files to the working directory
COPY go.mod go.sum ./

# Download and cache Go modules
RUN go mod download

# Copy the application source code to the working directory
COPY . .

# Build the Go application
RUN go build -o myapp

# Start a new, lightweight base image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the previous stage
COPY --from=build /app/myapp .

# Expose the port that your application listens on
EXPOSE 8000

# Define the command to run your application
CMD ["./myapp"]
