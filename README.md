# openrave-installation
## wsl2 ubuntu 22.04 专用

Bash scripts to install OpenRAVE from source. 

## Installation
### prepare
1. change the apt source if necessary
2. change the pip source if necessary

### useful wsl commands
```bash
#show all system
wsl --list --verbose
#set to wsl2
wsl --set-default-version 2
#reinstall,clear all data
wsl --unregister Ubuntu-22.04
wsl --install Ubuntu-22.04
#make a mirror image
wsl --export Ubuntu-22.04 f:\wsl-ubuntu22.04.tar
#recovery from the image
wsl --unregister Ubuntu-22.04
wsl --import Ubuntu-22.04 f:\wsl f:\wsl-ubuntu22.04.tar --version 2
#set default user as root
ubuntu2204 config --default-user root
```

### just for source changes
```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bkp
cp ./openrave-installation/sources.list /etc/apt/sources.list
apt update
mkdir ~/.pip && cp ./openrave-installation/pip.config ~/.pip/pip.config
source ./openrave-installation/proxy.sh set 10811 
```

### install openrave
Run the scripts in the following order:
```bash
./openrave-installation/install-dependencies.sh
./openrave-installation/install-osg.sh
./openrave-installation/install-fcl.sh
./openrave-installation/install-openrave.sh
```
