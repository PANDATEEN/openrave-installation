#!/bin/bash
#
# Authors:
#   Francisco Suarez <fsuarez6.github.io>
#
# Description:
#   OpenRAVE Installation Script: OpenSceneGraph

# Check ubuntu version
UBUNTU_VER=$(lsb_release -sr)
if [ ${UBUNTU_VER} != '22.04' ]; then
    echo "ERROR: Unsupported Ubuntu version: ${UBUNTU_VER}"
    echo "  Supported versions are: 22.04"
    exit 1
fi

# OpenSceneGraph
OSG_COMMIT=1f89e6eb1087add6cd9c743ab07a5bce53b2f480
echo ""
echo "Installing OpenSceneGraph 3.4 from source (Commit ${OSG_COMMIT})..."
echo ""

mkdir -p ~/git; cd ~/git
git clone https://github.com/openscenegraph/OpenSceneGraph.git
cd OpenSceneGraph; git reset --hard ${OSG_COMMIT}
mkdir build; cd build

cmake -DDESIRED_QT_VERSION=4 ..

make -j `nproc`
sudo make install
sudo make install_ld_conf
