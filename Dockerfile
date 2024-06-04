# Use a base image with Postfix
FROM debian:latest

# Install Postfix
RUN apt-get update && apt-get install -y postfix dnsutils telnet wget vim

# Copy the configuration file into the container
COPY main.cf /etc/postfix/main.cf

# Copy resolv.conf into the Postfix chroot directory
RUN mkdir -p /var/spool/postfix/etc \
    && cp /etc/resolv.conf /var/spool/postfix/etc/

# Expose the port Postfix listens on
EXPOSE 25

# Start Postfix
CMD ["postfix", "start-fg"]

