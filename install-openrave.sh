#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if[ ${UBUNTU_VER} != '22.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 14.04, 16.04, 18.04, 20.04, and 22.04"
    exit 1
fi

# Install Sympy
# OpenRAVE
pip install sympy

# OpenRAVE
RAVE_COMMIT=a982f0ac0b757787ab4c9a9af94f69795e8281cb
echo ""
echo "Installing OpenRAVE main (10th Feb 2023) from source (Commit ${RAVE_COMMIT})..."
echo ""
mkdir -p ~/git; cd ~/git
git clone -b production https://github.com/rdiankov/openrave.git

cd openrave; git reset --hard ${RAVE_COMMIT}
mkdir build; cd build
if [ ${UBUNTU_VER} = '14.04' ] || [ ${UBUNTU_VER} = '16.04' ]; then
  	cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ ..
elif [ ${UBUNTU_VER} = '18.04' ] || [ ${UBUNTU_VER} = '20.04' ]; then
  	cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ \
  		-DUSE_PYBIND11_PYTHON_BINDINGS:BOOL=TRUE 			   \
  		-DBoost_NO_BOOST_CMAKE=1 ..
elif [ ${UBUNTU_VER} = '22.04' ]; then
  	cmake -DODE_USE_MULTITHREAD=ON -DOSG_DIR=/usr/local/lib64/ \
  		-DUSE_PYBIND11_PYTHON_BINDINGS:BOOL=TRUE 			   \
  		-DBoost_NO_BOOST_CMAKE=1 -DCMAKE_CXX_STANDARD=17 ..
fi
make -j `nproc`
sudo make install
