#!/bin/sh
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
wslip=$(hostname -I | awk '{print $1}')

set_proxy(){

    PROXY_HTTP="http://${hostip}:${port}"
    PROXY_HTTPS="http://${hostip}:${port}"
    
    export http_proxy="${PROXY_HTTP}"
    export HTTP_PROXY="${PROXY_HTTP}"

    export https_proxy="${PROXY_HTTPS}"
    export HTTPS_proxy="${PROXY_HTTPS}"

    echo "Host ip:" ${hostip}
    echo "WSL ip:" ${wslip}
    echo "Current http  proxy: ${PROXY_HTTP}"
    echo "Current https proxy: ${PROXY_HTTPS}"
    echo "Note: You need to invoke this command with source, like: source proxy.sh set ${port}"
}

unset_proxy(){
    unset http_proxy
    unset HTTP_PROXY
    unset https_proxy
    unset HTTPS_PROXY
    echo "Unset done: http_proxy HTTP_PROXY https_proxy HTTPS_PROXY"
    echo "Note: You need to invoke this command with source: source proxy.sh unset"
}

proxy_info(){
    echo "Host ip:" ${hostip}
    echo "WSL ip:" ${wslip}
    echo "Current http  proxy: $http_proxy"
    echo "Current https proxy: $https_proxy"
}

if [ "$1" = "set" ]
then
    if [ "$2" = "" ]
    then
	port="10809"
	echo "Use default port: ${port}"
    else
	port="$2"
    fi
    set_proxy

elif [ "$1" = "unset" ]
then
    unset_proxy

elif [ "$1" = "info" ]
then
    proxy_info
else
    echo "Unsupported arguments: $1.
Available aguments:
set [port]
unset
info"
fi