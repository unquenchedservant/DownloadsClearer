#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
else
    mkdir $HOME/.dlClear
    mkdir $HOME/.dlClear/logs
    wget https://raw.githubusercontent.com/unquenchedservant/DownloadsClearer/master/downloadclearer.sh
    mv downloadclearer.sh /usr/bin/dlClear
    chmod +x /usr/bin/dlClear
fi


# General install psuedocode
# create ~/.dlClear folder
# create ~/.dlClear/logs folder
# use wget to install DownloadClearer to /usr/bin/ (possible aliases: dc, dlClear)
# first I need to get DownloadClearer on github 
# then chmod +x DownloadClearer
# this actually probably needs sudo priviledges. (it does)

