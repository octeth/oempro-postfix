# Octeth Postfix Add-On

This add-on adds a Postfix container to the server so that Octeth can send emails through this Postfix add-on.

## Installation Instructions

Build the Docker container:

```bash
docker build -t octeth-postfix .
```

Run the container:

```bash
# If this container is going to be running on Octeth's server, run this command:
docker run -d --name octeth-postfix --network oempro-network --dns 1.1.1.1 --dns 8.8.8.8 --dns 8.8.4.4 -p 2526:25 octeth-postfix
```

In Octeth's delivery server settings;

- Name: octeth-postfix
- Host: octeth-postfix
- Port: 25
- Security: No secured connection
- Connectin Time Out: 10
- Authentication: Authentication not required
- Link Tracking: {octeth_domain}
- Open Tracking: {octeth_domain}
- MFROM domain: {octeth_domain}

