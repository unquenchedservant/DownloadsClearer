#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root" # This may not be necessary, but I was testing something
fi


# General install psuedocode
# use wget to install DownloadClearer to /usr/bin/ (possible aliases: dc)
# first I need to get DownloadClearer on github 
