#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
# Update:
# 	pandatea
# Description:
#   OpenRAVE Installation Script: Dependencies

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '22.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 22.04"
    exit 1
fi

# Install dependencies
echo ""
echo "Installing OpenRAVE dependencies..."
echo ""
echo "Requires root privileges:"

# Update
sudo apt-get update

# Programs
sudo apt-get install -y g++ cmake git wget python3-dev python-setuptools python3-pip python-is-python3 python3-numpy
sudo apt-get install -y --no-install-recommends build-essential doxygen octave mlocate

# Libraries
sudo apt-get install -y --no-install-recommends ann-tools libann-dev            \
libassimp-dev libavcodec-dev libavformat-dev libeigen3-dev libfaac-dev          \
libflann-dev libfreetype6-dev liblapack-dev libglew-dev libgsm1-dev             \
libmpfi-dev  libmpfr-dev liboctave-dev libode-dev libogg-dev libpcre3-dev       \
libqhull-dev libswscale-dev libtinyxml-dev libvorbis-dev libx264-dev            \
libxml2-dev libxvidcore-dev libbz2-dev

# Install boost
sudo apt-get install -y --no-install-recommends libboost-all-dev libboost-python-dev 

# Install opengl
pip install pyopengl

# Install RapidJSON
mkdir -p ~/git 
cd ~/git && git clone https://github.com/Tencent/rapidjson.git
cd rapidjson && mkdir build && cd build
cmake .. && make -j `nproc` && sudo make install

# Install Pybind
cd ~/git && git clone https://github.com/pybind/pybind11.git 
cd pybind11
# Set Git credentials to allow git cherry-pick
git config --local user.name tea
git config --local user.email tea@example.com
echo "Random Git credentials"
mkdir build && cd build 
git remote add woody https://github.com/woodychow/pybind11.git \
&& git remote add cielavenir https://github.com/cielavenir/pybind11.git \
&& git fetch woody && git fetch cielavenir && git checkout v2.2.4 \
&& git cherry-pick 94824d68a037d99253b92a5b260bb04907c42355 \
&& git cherry-pick 98c9f77e5481af4cbc7eb092e1866151461e3508 \
&& git cherry-pick dae2d434bd806eac67e38f3c49cfc91f46e4fd88 \
&& git cherry-pick 2e08ce9ba75f5a2d87a6f12e6ab657ac78444e8e \
&& cmake .. -DPYBIND11_TEST=OFF -DPythonLibsNew_FIND_VERSION=3 -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") -DPYTHON_LIBRARY=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
&& sudo make install

# updatedb for debugging purposes
sudo updatedb
