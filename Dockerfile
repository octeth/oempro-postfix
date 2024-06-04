# Use a base image with Postfix
FROM debian:latest

# Install Postfix
RUN apt-get update && apt-get install -y postfix dnsutils telnet wget

# Copy the configuration file into the container
COPY main.cf /etc/postfix/main.cf

# Expose the port Postfix listens on
EXPOSE 25

# Start Postfix
CMD ["postfix", "start-fg"]

