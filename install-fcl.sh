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

# fcl 0.7
# sudo apt-get install -y libfcl-dev

# fcl 0.6
# cd
# wget http://ftp.de.debian.org/debian/pool/main/f/fcl/libfcl0.6_0.6.1-5_amd64.deb
# dpkg -i libfcl0.6_0.6.1-5_amd64.deb

# FCL - The Flexible Collision Library
echo ""
echo "Installing FCL 0.5.0 from source..."
echo ""
mkdir -p ~/git; cd ~/git
git clone https://github.com/flexible-collision-library/fcl
cd fcl; git reset --hard 0.5.0
mkdir build; cd build
cmake .. -DFCL_BUILD_TESTS=OFF
make -j `nproc`
sudo make install
