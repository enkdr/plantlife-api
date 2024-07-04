# First stage: build the Go application
FROM golang:1.22-bookworm AS builder

# Enable CGO for SQLite support
ENV CGO_ENABLED=1

# Install build dependencies
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends --assume-yes \
      build-essential \
      libsqlite3-dev

# Set the working directory inside the container
WORKDIR /src

# Copy go mod and sum files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the entire application source code including SQLite file
COPY . .

# Build the Go app as a statically linked binary
RUN go build -o ./main main.go

# Second stage: create a minimal runtime image
FROM debian:bookworm

# Install SQLite runtime library
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends --assume-yes \
      libsqlite3-0

# Set the working directory
WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /src/main /app/main

# Copy the SQLite database file from the builder stage
COPY --from=builder /src/plantlife.db /app/plantlife.db

# Expose port if needed
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
