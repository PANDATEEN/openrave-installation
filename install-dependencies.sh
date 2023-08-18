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

sudo apt-get install -y --no-install-recommends build-essential cmake doxygen g++ git octave\
    python3-dev python-setuptools python-is-python3 python3

sudo apt-get install -y --no-install-recommends python2-dev python-setuptools python2
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
python get-pip.py
pip install ipython h5py numpy scipy wheel pyopengl

echo "in wsl,the mlocate will scan the windows file system,it takes very long time,here is the solution:"
echo "https://blog.csdn.net/qq_15969343/article/details/129189584"
echo "after you`ve done all above,you should run this script again"
echo "but also you can keep waiting,if you`re a very patient person"
sudo apt-get install -y --no-install-recommends mlocate

# Libraries
sudo apt-get install -y --no-install-recommends ann-tools libann-dev            \
libassimp-dev libavcodec-dev libavformat-dev libeigen3-dev libfaac-dev          \
libflann-dev libfreetype6-dev liblapack-dev libglew-dev libgsm1-dev             \
libmpfi-dev  libmpfr-dev liboctave-dev libode-dev libogg-dev libpcre3-dev       \
libqhull-dev libswscale-dev libtinyxml-dev libvorbis-dev libx264-dev            \
libxml2-dev libxvidcore-dev libbz2-dev

sudo apt-get install -y --no-install-recommends libsoqt520-dev
sudo apt-get install -y --no-install-recommends libccd-dev                  \
libcollada-dom2.4-dp-dev liblog4cxx-dev libminizip-dev octomap-tools

# Install boost
sudo apt-get install -y --no-install-recommends libboost-all-dev libboost-python-dev 

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
&& cmake .. -DPYBIND11_TEST=OFF -DPythonLibsNew_FIND_VERSION=2 \
&& sudo make install

# updatedb for debugging purposes
sudo updatedb
