#!/bin/sh
echo This is a vodka-bottle-documentation, sorry, no automation at this time, :-/
exit 1

##########################################################
# Windows Subsystem for Linux Installation
##########################################################

# - Open Windows PowerShell or cmd
wsl --install -d ubuntu

# - reboot computer
# - after reboot Ubuntu cmd will pop up:

# Ubuntu is already installed.
# Launching Ubuntu...
# Installing, this may take a few minutes...
# Please create a default UNIX user account. The username does not need to match your Windows username.
# For more information visit: https://aka.ms/wslusers
Enter new UNIX username: "netudy"
New password: "********"
Retype new password: "********"
# passwd: password updated successfully
# Installation successful!
# To run a command as administrator (user "root"), use "sudo <command>".
# See "man sudo_root" for details.

# Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.153.1-microsoft-standard-WSL2 x86_64)

#  * Documentation:  https://help.ubuntu.com
#  * Management:     https://landscape.canonical.com
#  * Support:        https://ubuntu.com/advantage


# This message is shown once a day. To disable it please create the
# /home/netudy/.hushlogin file.


# - Open WSL
sudo apt update
[sudo] password for netudy: "********"
# Hit:1 http://archive.ubuntu.com/ubuntu jammy InRelease
# Get:2 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [128 kB]
# Get:3 http://security.ubuntu.com/ubuntu jammy-security InRelease [129 kB]
# Hit:4 http://archive.ubuntu.com/ubuntu jammy-backports InRelease
# Get:5 http://archive.ubuntu.com/ubuntu jammy-updates/main amd64 Packages [1943 kB]
# [...]

# - install python
sudo apt install python3-pip

##########################################################
# install password generator and ssh
##########################################################

# - install password generator
sudo apt install pwgen

# - create a password 40 chars, numbers and symbols
pwgen -y -n 40
# ie?be:n5zohpaiKoc0quathohmaeNgaep6fi1shi
# fethai1ainei9Kae8Eish|oe8oquei%Yaep/ee7j
# quietu4or3aeghei0mung7oB{ah}g8ieh1aeJoop
# ioS0aibae^roh9Dei0ahlo_h7oocix6ohsh4If4r
# quaep5ilat3Shae|th9ahthof7aewu6PieNuerue
# aijah2iethaeChai8ZujahHuN'ugh7wie1Oophee
# ho.im;e+t0oonuhosoo3ohNg}e1Eth7au8wo3iku
# poh~phugeeghei4baequ0aelef7iepudee4RaiDa
# chie_lodah"R5eenooL`aita2iezaiW2joegah"X
# waep6fa8laec4eo+h0eibuu]Mie8ideat!oohie3
# ohf7nuuquahp@ah7aeD^ae2tai7eiVaeL3naepha
# ooPieth7voo7Tiesuwi6Uf8peeV,aiVi5gah\qu7
# eilei0oht2aed8gaewae7oo5sieg@aiCuoSh6ahp
# boub1ruP0ing1zee=ghooth4ahqu8zooqu2Eepai
# aeyi3eitu8thahd}ooghoo"PaePhaewee5zah1ph
# li5uph8aeShu2AeVui1aa4uung[ovohTahJ(utah
# ozee%ghoo4oL7Och`iisa-a2ohTe^Chei3ahbeip
# keiQu8IewieC6befu9phahbiwae7xohZai3ja<Qu
# ohchoh7Aengoe~r9bie7chae1yoor1ohngaic7be
# aepho0enof'aebi9quaizoog5Fep?oong5thaiz8

# - check if ssh service is running
sudo service ssh status

# - install openssh
sudo apt install openssh-server

# - create keypair
cd
mkdir .ssh
chmod 740 .ssh/
ssh-keygen -t rsa -b 4096 -f ~/.ssh/netudy
# Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): "eilei0oht2aed8gaewae7oo5sieg@aiCuoSh6ahp"
Enter same passphrase again: "eilei0oht2aed8gaewae7oo5sieg@aiCuoSh6ahp"
# Your identification has been saved in /home/netudy/.ssh/netudy
# Your public key has been saved in /home/netudy/.ssh/netudy.pub
# The key fingerprint is:
# SHA256:ciWPCVw/ZDOCjyJ2rBHBgnCEPe2SModZJvTS8c+EgHk netudy@netudy
# The key's randomart image is:
# +---[RSA 4096]----+
# |=**=   .o =      |
# |=+XE=.o. = o     |
# | O.O oo+. +      |
# |= O = =..* .     |
# | = * ..oS .      |
# |  .    o         |
# |                 |
# |                 |
# |                 |
# +----[SHA256]-----+

# - start ssh service
sudo service ssh start

# - allow ssh in firewall
sudo ufw allow ssh

##########################################################
# upload public keypair to github
##########################################################

# - install git
sudo apt install git

# - fetch pubkey
cat .ssh/netudy.pub
# ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9k0l4ph3nYHvHUz6CPsrH/NgnUBS6IylccF5GeEH2vHLjkZ9lFIqOLs8MKcwS2+vlULDuYsTugQEJCKmp81N1xJ2QlWXktma5jNJwfqesJ/kppQ2r8hL5UEp6fw/B81/Z+zExrQnFQyizJHKWS46+OtTJ0eLXU1V7dYmdmbY37hlDzNY8zAsduEl4+qFa8jOCmRwc8pnkKfA+DPxdhBAFSDs1bzpfJsKxN6ECvZ9tgZ0xZQWTe5QITgwHSRSDqtM88qnTAb5bEunA2INqUMZUS4P0gbgNSZkKbEIOAxJHkdqcYZXPiNeIRFc34U7MTGn34nS99omeL5nr4wldagFEKyyHSP9ePb54RFXF/c/ZgYlN36S315flHqlN4+gULopjpH/z9ktqmsbWazlWPNKoUYCt+UiWsq3HzOOP0sOEB7PAGpgZy+2FzabkCsb3AIRsxlZhGx9cJRlL2vZeC6lKS/hTKvLSVzM8+15n8e74Ar4bwkiGu0vsM9a+gaVSIVpq21rRak/jDlptgKz6vMn/cCwXMqHfpcevuLTe8aQc7LSkySPqvzPiCxq4tbuOcpmv5ZiRi1cMBpDLsYe/I5++YStWyBNF8EWYj81UMiOika/HQwD224lxY3lNW8FoYTuV18Jn/gUpQ/iEnbRklyRRdlKUs1M9rZJyjJcAaJhy2Q== netudy@netudy

# - upload to github through web browser
"https://github.com/settings/ssh/new"

# Add new SSH Key
# Title
"netudy"

# Key type
"[Authentication Key↕]"

# Key
"****************"

"Add SSH key"

# - create ssh config file
cat <<"EOF" > ~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/netudy
EOF

# - Verify file
cat ~/.ssh/config
# Host github.com
#   HostName github.com
#   User git
#   IdentityFile ~/.ssh/netudy

# - Create source directory
cd
mkdir src
cd src

# - Clone repo
git clone https://github.com/netudy/ubuntu-school.git
# Cloning into 'src'...
# The authenticity of host 'github.com (140.82.121.3)' can't be established.
# ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
# This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? "yes"
# Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
Enter passphrase for key '/home/netudy/.ssh/netudy': "********"
# remote: Enumerating objects: 21, done.
# remote: Counting objects: 100% (21/21), done.
# remote: Compressing objects: 100% (15/15), done.
# remote: Total 21 (delta 8), reused 16 (delta 4), pack-reused 0 (from 0)
# Receiving objects: 100% (21/21), 14.31 KiB | 16.00 KiB/s, done.
# Resolving deltas: 100% (8/8), done.

# - Push changes to remote repository
cd ubuntu-school
git status
# On branch main
# Your branch is up to date with 'origin/main'.

# nothing to commit, working tree clean

##########################################################
# push to remote
##########################################################

git checkout -b "netudy-first-commit"

cat <<"EOF" > ~/src/ubuntu-school/netudy.2024.08.23.sh
#!/bin/sh
echo This is a vodka-bottle-documentation, sorry, no automation at this time, :-/
exit 1

# my first commit
EOF

git status
# On branch netudy-first-commit
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#   netudy.2024.08.23.sh

# nothing added to commit but untracked files present (use "git add" to track)

git add netudy.2024.08.23.sh
git status
# On branch netudy-first-commit
# Changes to be committed:
#   (use "git restore --staged <file>..." to unstage)
#   new file:   netudy.2024.08.23.sh

git config --global user.name "netudy"
git config --global user.email fa1c0n@netudy.com
git commit -am "my first commit"
git push --set-upstream origin netudy-first-commit
# [netudy-first-commit bb4cd6f] my first commit
#  1 file changed, 5 insertions(+)
#  create mode 100644 netudy.2024.08.23.sh
# Enumerating objects: 4, done.
# Counting objects: 100% (4/4), done.
# Delta compression using up to 4 threads
# Compressing objects: 100% (3/3), done.
# Writing objects: 100% (3/3), 435 bytes | 435.00 KiB/s, done.
# Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
# remote: This repository moved. Please use the new location:
# remote:   git@github.com:netudy/ubuntu-school.git
# remote:
# remote: Create a pull request for 'netudy-first-commit' on GitHub by visiting:
# remote:      https://github.com/netudy/ubuntu-school/pull/new/netudy-first-commit
# remote:
# To github.com:netudy/ubuntu-school.git
#  * [new branch]      netudy-first-commit -> netudy-first-commit
# branch 'netudy-first-commit' set up to track 'origin/netudy-first-commit'.
