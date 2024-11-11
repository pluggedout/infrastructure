# Use a Debian-based slim image
FROM debian:bullseye-slim

# Install dependencies: bash, curl, jq, tzdata
RUN apt-get update && apt-get install -y --no-install-recommends \
      bash \
      curl \
      jq \
      ca-certificates \
      tzdata \
    && rm -rf /var/lib/apt/lists/*

# Set timezone to UTC to ensure consistent date calculations
ENV TZ=UTC

# Create a directory for the script
WORKDIR /app

# Copy the shell script into the container
COPY cwe-lookup.sh /app/cwe-lookup.sh

# Make the script executable
RUN chmod +x /app/cwe-lookup.sh

# Set the entrypoint to the shell script
ENTRYPOINT ["/app/cwe-lookup.sh"]