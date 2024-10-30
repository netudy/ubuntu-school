########################################################
# Install and configure OpenVPN
########################################################

# Create a directory for OpenVPN Docker setup
mkdir ~/docker/openvpn && cd ~/docker/openvpn

# Create the Docker Compose file for OpenVPN
cat <<"EOF" > ~/docker/openvpn/docker-compose.yml
services:
  openvpn:
    cap_add:
     - NET_ADMIN
    image: kylemanna/openvpn
    container_name: openvpn
    ports:
     - "1194:1194/udp"
    restart: always
    volumes:
     - ./openvpn-data/conf:/etc/openvpn
EOF

# Initialize the OpenVPN configuration
docker-compose run --rm openvpn ovpn_genconfig -u udp://netudy.com

# Initialize the Public Key Infrastructure (PKI) for OpenVPN
docker-compose run --rm openvpn ovpn_initpki

# init-pki complete; you may now create a CA or requests.
# Your newly created PKI dir is: /etc/openvpn/pki


# Using SSL: openssl OpenSSL 1.1.1g  21 Apr 2020

Enter New CA Key Passphrase: "peih1ohva0ooQuae#P6aejoo7ioch&ae3ho3ooS<"
Re-Enter New CA Key Passphrase: "peih1ohva0ooQuae#P6aejoo7ioch&ae3ho3ooS<"
# Generating RSA private key, 2048 bit long modulus (2 primes)
# ............................+++++
# ............+++++
# e is 65537 (0x010001)
# You are about to be asked to enter information that will be incorporated
# into your certificate request.
# What you are about to enter is what is called a Distinguished Name or a DN.
# There are quite a few fields but you can leave some blank
# For some fields there will be a default value,
# If you enter '.', the field will be left blank.
# -----
Common Name (eg: your user, host, or server name) [Easy-RSA CA]:"netudy"

# CA creation complete and you may now import and sign cert requests.
# Your new CA certificate file for publishing is at:
# /etc/openvpn/pki/ca.crt


# Using SSL: openssl OpenSSL 1.1.1g  21 Apr 2020
# Generating DH parameters, 2048 bit long safe prime, generator 2
# This is going to take a long time
# .................................................................+....+........................+..........................+.....................+.............+....................................................................................................................................+.....................+.+.................................................................................................+.............................................++*++*++*++*

# DH parameters of size 2048 created at /etc/openvpn/pki/dh.pem


# Using SSL: openssl OpenSSL 1.1.1g  21 Apr 2020
# Generating a RSA private key
# .+++++
# .......................................................+++++
# writing new private key to '/etc/openvpn/pki/easy-rsa-73.aMDHok/tmp.PnLgip'
# -----
# Using configuration from /etc/openvpn/pki/easy-rsa-73.aMDHok/tmp.ihCmle
Enter pass phrase for /etc/openvpn/pki/private/ca.key: "peih1ohva0ooQuae#P6aejoo7ioch&ae3ho3ooS<"
# Check that the request matches the signature
# Signature ok
# The Subject's Distinguished Name is as follows
# commonName            :ASN.1 12:'netudy.com'
# Certificate is to be certified until Dec  9 14:39:14 2026 GMT (825 days)

# Write out database with 1 new entries
# Data Base Updated

# Using SSL: openssl OpenSSL 1.1.1g  21 Apr 2020
# Using configuration from /etc/openvpn/pki/easy-rsa-148.gAfpKJ/tmp.cMBBcf
Enter pass phrase for /etc/openvpn/pki/private/ca.key: "peih1ohva0ooQuae#P6aejoo7ioch&ae3ho3ooS<"

# An updated CRL has been created.
# CRL file: /etc/openvpn/pki/crl.pem

# Adjust the ownership of the openvpn-data directory (if necessary)
sudo chown -R $(whoami): ./openvpn-data

# Start the OpenVPN server
docker-compose up -d openvpn

# View logs of the running OpenVPN container
docker-compose logs -f
# openvpn  | Checking IPv6 Forwarding
# openvpn  | Sysctl error for default forwarding, please run docker with '--sysctl net.ipv6.conf.default.forwarding=1'
# openvpn  | Sysctl error for all forwarding, please run docker with '--sysctl net.ipv6.conf.all.forwarding=1'
# openvpn  | Running 'openvpn --config /etc/openvpn/openvpn.conf --client-config-dir /etc/openvpn/ccd --crl-verify /etc/openvpn/crl.pem '
# openvpn  | Thu Sep  5 14:40:48 2024 OpenVPN 2.4.9 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built on Apr 20 2020
# openvpn  | Thu Sep  5 14:40:48 2024 library versions: OpenSSL 1.1.1g  21 Apr 2020, LZO 2.10
# openvpn  | Thu Sep  5 14:40:48 2024 Diffie-Hellman initialized with 2048 bit key
# openvpn  | Thu Sep  5 14:40:48 2024 CRL: loaded 1 CRLs from file /etc/openvpn/crl.pem
# openvpn  | Thu Sep  5 14:40:48 2024 Outgoing Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
# openvpn  | Thu Sep  5 14:40:48 2024 Incoming Control Channel Authentication: Using 160 bit message hash 'SHA1' for HMAC authentication
# openvpn  | Thu Sep  5 14:40:48 2024 ROUTE_GATEWAY 172.19.0.1/255.255.0.0 IFACE=eth0 HWADDR=02:42:ac:13:00:02
# openvpn  | Thu Sep  5 14:40:48 2024 TUN/TAP device tun0 opened
# openvpn  | Thu Sep  5 14:40:48 2024 TUN/TAP TX queue length set to 100
# openvpn  | Thu Sep  5 14:40:48 2024 /sbin/ip link set dev tun0 up mtu 1500
# openvpn  | Thu Sep  5 14:40:48 2024 /sbin/ip addr add dev tun0 local 192.168.255.1 peer 192.168.255.2
# openvpn  | Thu Sep  5 14:40:48 2024 /sbin/ip route add 192.168.254.0/24 via 192.168.255.2
# openvpn  | Thu Sep  5 14:40:48 2024 /sbin/ip route add 192.168.255.0/24 via 192.168.255.2
# openvpn  | Thu Sep  5 14:40:48 2024 Could not determine IPv4/IPv6 protocol. Using AF_INET
# openvpn  | Thu Sep  5 14:40:48 2024 Socket Buffers: R=[212992->212992] S=[212992->212992]
# openvpn  | Thu Sep  5 14:40:48 2024 UDPv4 link local (bound): [AF_INET][undef]:1194
# openvpn  | Thu Sep  5 14:40:48 2024 UDPv4 link remote: [AF_UNSPEC]
# openvpn  | Thu Sep  5 14:40:48 2024 GID set to nogroup
# openvpn  | Thu Sep  5 14:40:48 2024 UID set to nobody
# openvpn  | Thu Sep  5 14:40:48 2024 MULTI: multi_init called, r=256 v=256
# openvpn  | Thu Sep  5 14:40:48 2024 IFCONFIG POOL: base=192.168.255.4 size=62, ipv6=0
# openvpn  | Thu Sep  5 14:40:48 2024 Initialization Sequence Completed

# Generate a client certificate for VPN access
export CLIENTNAME=fa1c0n
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# Using SSL: openssl OpenSSL 1.1.1g  21 Apr 2020
# Generating a RSA private key
# ............................+++++
# ...+++++
# writing new private key to '/etc/openvpn/pki/easy-rsa-1.caOfai/tmp.eCBhIG'
Enter PEM pass phrase: "goo0Ug;u@xoa"
Verifying - Enter PEM pass phrase: "goo0Ug;u@xoa"
# -----
# Using configuration from /etc/openvpn/pki/easy-rsa-1.caOfai/tmp.EfIbFh
Enter pass phrase for /etc/openvpn/pki/private/ca.key: "peih1ohva0ooQuae#P6aejoo7ioch&ae3ho3ooS<"
# Check that the request matches the signature
# Signature ok
# The Subject's Distinguished Name is as follows
# commonName            :ASN.1 12:'fa1c0n'
# Certificate is to be certified until Dec  9 14:42:12 2026 GMT (825 days)

# Write out database with 1 new entries
# Data Base Updated

# Retrieve the client configuration file with embedded certificates
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

# Add routes in OpenVPN config
docker exec -it openvpn /bin/bash
echo 'push "route 192.168.255.0 255.255.255.0"' >> /etc/openvpn/openvpn.conf
echo 'push "route 172.22.1.0 255.255.255.0"' >> /etc/openvpn/openvpn.conf
echo 'push "route 172.19.0.0 255.255.255.0"' >> /etc/openvpn/openvpn.conf
exit

# Restart OpenVPN to apply changes
docker restart openvpn

####################
# Useful info:
####################

# Revoke a client certificate but keep the crt, key, and req files
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME

# Revoke a client certificate and remove the crt, key, and req files
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove

# Enable debugging with the DEBUG environment variable set to 1
docker-compose run -e DEBUG=1 -p 1194:1194/udp openvpn
