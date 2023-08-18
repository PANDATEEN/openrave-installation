#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: FCL

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '22.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 22.04"
    exit 1
fi

# FCL - The Flexible Collision Library
echo ""
echo "Installing FCL 0.6.0 from binaray..."
echo ""

mkdir -p ~/git; cd ~/git
wget http://ftp.de.debian.org/debian/pool/main/f/fcl/libfcl0.6_0.6.1-5_amd64.deb
dpkg -i libfcl0.6_0.6.1-5_amd64.deb
