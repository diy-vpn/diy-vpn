#!/bin/bash

# Paste this into the launch script box on Lightsail to automatically install
# and deploy VPN and config files. See README.md for step-by-step connection
# and configuration file download instructions.

ID_LIKE=`cat /etc/os-release |grep ID_LIKE|cut -f 2 -d '='|sed 's/\"//g'`

echo "ID is $ID_LIKE"
if [[ ${ID_LIKE} == *"rhel"* ]]; then
 echo Detected RHELish OS, using yum to install
 sudo yum -y install git;
elif [[ ${ID_LIKE} == *"debian"* ]]; then
 echo Detected Debianesque OS, using apt to install
 sudo apt-get -y install git;
else
 echo "Don't detect RHEL or Debian. Skipping."
fi

git clone https://github.com/diy-vpn/diy-vpn.git /tmp/diy-vpn
chmod 755 /tmp/diy-vpn/*.sh

if [ "${ID_LIKE}" = "debian" ]; then
  cd /tmp/diy-vpn && sudo ./ubuntu-vpn.sh
else
  cd /tmp/diy-vpn && sudo ./build-vpn.sh
fi
