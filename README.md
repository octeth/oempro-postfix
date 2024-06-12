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
docker run -d --name octeth-postfix --network oempro-network --dns 1.1.1.1 --dns 8.8.8.8 --dns 8.8.4.4 -p 2526:25 -v $(pwd)/dkim-keys:/etc/opendkim/keys octeth-postfix
```

## Setting Up DKIM

### Generating DKIM Keys

Generate a default DKIM key:

```sh
docker exec -ti octeth-postfix bash -c "opendkim-genkey -b 2048 -s key1 -D /etc/opendkim/keys/ -v"
```

or use [Octeth DKIM Generator](https://www2.octeth.com/dkim-generator/).

### DNS Configuration

For each domain, set the DKIM DNS record:

- Record Name: `key1._domainkey.test.com`
- Record Type: `TXT`
- Record Value: `v=DKIM1; k=rsa; p=...` (the full content of `default.txt`)

### Build and Restart Postfix Container

As explained in Installation Instructions section, build the container and start it:

```bash
docker kill octeth-postfix
docker container rm octeth-postfix
# Build
# Run
```

### Verifying the Setup

1. **Check Postfix logs for DKIM signing:**

   ```sh
   docker exec -it postfix-dkim tail -f /var/log/mail.log
   ```

2. **Send a test email and check the headers to ensure DKIM signing is applied:**

   Look for the `DKIM-Signature` header in the received email.

## Setting Up As Octeth Delivery Server

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

