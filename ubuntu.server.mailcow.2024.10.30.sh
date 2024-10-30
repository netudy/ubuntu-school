########################################################
# Enable and configure UFW firewall
########################################################

# Open necessary ports for Mailcow services and mail protocols
sudo ufw allow 8080/tcp   # Mailcow admin and webmail (HTTP)
sudo ufw allow 8443/tcp   # Mailcow admin and webmail (HTTPS)
sudo ufw allow 25/tcp     # SMTP for sending mail
sudo ufw allow 465/tcp    # Secure SMTP (SMTPS)
sudo ufw allow 587/tcp    # Mail submission port
sudo ufw allow 143/tcp    # IMAP for mail retrieval
sudo ufw allow 993/tcp    # Secure IMAP (IMAPS)
sudo ufw allow 110/tcp    # POP3 for mail retrieval
sudo ufw allow 995/tcp    # Secure POP3 (POP3S)

# Allow LDAP services and database access
sudo ufw allow 389/tcp    # LDAP
sudo ufw allow 636/tcp    # Secure LDAP (LDAPS)
sudo ufw allow 3306/tcp   # MySQL for Mailcow

# Allow additional services required by Mailcow
sudo ufw allow 7654/tcp   # Redis cache service
sudo ufw allow 19991/tcp  # Dovecot internal Mailcow service
sudo ufw allow 18983/tcp  # Solr for email search indexing

sudo ufw enable
sudo ufw status

########################################################
# Install and configure Mailcow
########################################################

# Navigate to the docker directory in your home folder
cd ~/docker

# Clone the Mailcow repository from GitHub
git clone https://github.com/mailcow/mailcow-dockerized mailcow

# Navigate to the newly created 'mailcow' directory
cd ~/docker/mailcow

# Run the configuration script to generate Mailcow configuration files
./generate_config.sh

# Found Docker Compose Plugin (native).
# Setting the DOCKER_COMPOSE_VERSION Variable to native
# Notice: You'll have to update this Compose Version via your Package Manager manually!
# Press enter to confirm the detected value '[value]' where applicable or enter a custom value.
Mail server hostname (FQDN) - this is not your mail domain, but your mail servers hostname: "mail.localdomain.test"
Timezone [Europe/Stockholm]:
# Which branch of mailcow do you want to use?

# Available Branches:
# - master branch (stable updates) | default, recommended [1]
# - nightly branch (unstable updates, testing) | not-production ready [2]
Choose the Branch with its number [1/2] "1"

# Fetching origin
# Already on 'master'
# Your branch is up to date with 'origin/master'.
# Generating snake-oil certificate...
# Generating a RSA private key
# ............................................++++
# ...............................................................................................................................................................++++
# writing new private key to 'data/assets/ssl-example/key.pem'
# -----
# Copying snake-oil certificate...
# Detecting if your IP is listed on Spamhaus Bad ASN List...
# Check completed! Your IP is clean

# Backup original docker-compose.yml
cp docker-compose.yml docker-compose.yml.bak

# Update HTTP and HTTPS ports in docker-compose.yml and mailcow.conf
sed -i 's/8080/${HTTP_PORT:-80}/g' docker-compose.yml
sed -i 's/8443/${HTTPS_PORT:-443}/g' docker-compose.yml
sed -i 's/HTTP_PORT=.*/HTTP_PORT=8080/g' mailcow.conf
sed -i 's/HTTPS_PORT=.*/HTTPS_PORT=8443/g' mailcow.conf

# Configure Nginx for Mailcow (mail.localdomain.test)
cat <<"EOF" > /etc/nginx/sites-available/mail.localdomain.test
server {
    listen 80;
    server_name mail.localdomain.test;

    location / {
        proxy_pass http://127.0.0.1:8443;  # Mailcow port
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    access_log /var/log/nginx/mail.localdomain.test.access.log;
    error_log /var/log/nginx/mail.localdomain.test.error.log;
}
EOF

# Enable the Nginx configuration for Mailcow
sudo ln -s /etc/nginx/sites-available/mail.localdomain.test /etc/nginx/sites-enabled/

# Test and reload Nginx configuration
sudo nginx -t
sudo systemctl reload nginx

# Start Mailcow services using Docker Compose
docker-compose up -d
