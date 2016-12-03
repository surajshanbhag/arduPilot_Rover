#!/bin/bash  -x
echo $#
if [ $# == 1 ] 
then
    ip link set  $1 up
    iw dev wlxc46e1f23f5fe connect $2
    connection=`iw dev wlxc46e1f23f5fe link`
    echo $connection
    while [ "$connection" == "Not connected." ]
    do
        sleep 1
        connection=`iw dev wlxc46e1f23f5fe link`
        echo $connection
    done

    dhcpcd $1
    ifconfig $1
else
    echo "usage : wifiConnection.sh <wifiInterface> <hotspotName>"
fi
