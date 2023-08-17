# openrave-installation
## wsl2 ubuntu 22.04 专用

Bash scripts to install OpenRAVE from source. 

## Installation
### original install step
Run the scripts in the following order:
```bash
./install-dependencies.sh
./install-osg.sh
./install-fcl.sh
./install-openrave.sh
```
### latest install step
0. apt update
1. change the apt source if necessary
2. apt install cmake g++ git -y
3. apt install python3 python3-pip
4. alias python=python3
5. chnage the pip source if necessary
6. run the original install step
