#!/bin/sh
echo This is a vodka-bottle-documentation, sorry, no automation at this time, :-/
exit 1

##########################################################
# Windows Subsystem for Linux Installation
##########################################################

# - Open Windows PowerShell as admin
wsl --install -d ubuntu
# Installing: Virtual Machine Platform
# Virtual Machine Platform has been installed.
# Installing: Windows Subsystem for Linux
# Windows Subsystem for Linux has been installed.
# Installing: Ubuntu
# [=========                 16,0%                           ]
# Windows Subsystem for Linux has been installed.
# Installing: Ubuntu
# Ubuntu has been installed.
# Den begärda åtgärden lyckades. Ändringarna kommer inte att träda i kraft förrän datorn startats om.

# - reboot computer
# - enable wsl in windows features 
# - reboot computer
# - open ubuntu
# Installing, this may take a few minutes...
# Please create a default UNIX user account. The username does not need to match your Windows username.
# For more information visit: https://aka.ms/wslusers
Enter new UNIX username: "nahom"
New password: "0000"
Retype new password: "0000"
# passwd: password updated successfully
# Installation successful!
# To run a command as administrator (user "root"), use "sudo <command>".
# See "man sudo_root" for details.

# Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 5.15.167.4-microsoft-standard-WSL2 x86_64)

#  * Documentation:  https://help.ubuntu.com
#  * Management:     https://landscape.canonical.com
#  * Support:        https://ubuntu.com/pro

#  System information as of Mon Mar 17 11:17:56 CET 2025

#   System load:  0.0                 Processes:             43
#   Usage of /:   0.1% of 1006.85GB   Users logged in:       0
#   Memory usage: 10%                 IPv4 address for eth0: 172.25.239.241
#   Swap usage:   0%


# This message is shown once a day. To disable it please create the
# /home/nahom/.hushlogin file.
# nahom@LAPTOP-OGVD8NVU:~$

pwsh
# Command 'pwsh' not found, but can be installed with:
# sudo snap install powershell
sudo snap install powershell
[sudo] password for nahom: "0000"
# error: This revision of snap "powershell" was published using classic confinement and thus may
#        perform arbitrary system changes outside of the security sandbox that snaps are usually
#        confined to, which may put your system at risk.

#        If you understand and want to proceed repeat the command including --classic.
sudo snap install powershell --classic
# 2025-03-17T11:22:18+01:00 INFO Waiting for automatic snapd restart...
# powershell 7.5.0 from Canonical✓ installed
pwsh
# PowerShell 7.5.0
# PS /home/nahom>

# - check powershell version
$PSVersionTable

# Name                           Value
# ----                           -----
# PSVersion                      7.5.0
# PSEdition                      Core
# GitCommitId                    7.5.0
# OS                             Ubuntu 24.04.1 LTS
# Platform                       Unix
# PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
# PSRemotingProtocolVersion      2.3
# SerializationVersion           1.1.0.1
# WSManStackVersion              3.0
