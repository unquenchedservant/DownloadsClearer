#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
fi


# General install psuedocode
# use wget to install DownloadClearer to /usr/bin/ (possible aliases: dc)
# first I need to get DownloadClearer on github 
# then chmod +x DownloadClearer
# this actually probably needs sudo priviledges. (it does)

