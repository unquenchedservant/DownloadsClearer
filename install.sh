#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
else
    mkdir /usr/lib/dlClear;
    wget https://raw.githubusercontent.com/unquenchedservant/DownloadsClearer/master/downloadclearer.sh;
    mv downloadclearer.sh /usr/bin/dlClear;
    chmod -R 777 /usr/lib/dlClear;
    chmod +x /usr/bin/dlClear;
fi
