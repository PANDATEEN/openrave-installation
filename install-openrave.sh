#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '22.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 22.04"
    exit 1
fi

# Sympy version 0.7.1
echo ""
echo "Downgrading sympy to version 0.7.1..."
echo ""
pip install --upgrade --user sympy==0.7.1

# OpenRAVE
RAVE_COMMIT=2024b03554c8dd0e82ec1c48ae1eb6ed37d0aa6e
echo ""
echo "Installing OpenRAVE main (10th Feb 2023) from source (Commit ${RAVE_COMMIT})..."
echo ""
mkdir -p ~/git; cd ~/git
git clone -b production https://github.com/rdiankov/openrave.git

cd openrave; git reset --hard ${RAVE_COMMIT}
mkdir build; cd build
cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ \
	-DUSE_PYBIND11_PYTHON_BINDINGS:BOOL=TRUE 			   \
	-DBoost_NO_BOOST_CMAKE=1 ..
make -j `nproc`
sudo make install
