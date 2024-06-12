# Use a base image with Postfix
FROM debian:latest

# Install Postfix
RUN apt-get update && apt-get install -y postfix opendkim opendkim-tools dnsutils telnet wget vim

# Copy the configuration files into the container
COPY main.cf /etc/postfix/main.cf
COPY opendkim.conf /etc/opendkim.conf
COPY signing.table /etc/opendkim/signing.table
COPY key.table /etc/opendkim/key.table
COPY trusted.hosts /etc/opendkim/trusted.hosts

# Create necessary directories and copy resolv.conf
RUN mkdir -p /etc/opendkim/keys \
    && mkdir -p /var/spool/postfix/etc \
    && cp /etc/resolv.conf /var/spool/postfix/etc/

# Expose the port Postfix listens on
EXPOSE 25

# Start services
CMD service opendkim start && postfix start-fg
