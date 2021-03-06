#!/bin/bash
permanent=0
while getopts y:m:d:h:i:p flag
do
    case "${flag}" in
        y) #years
            if [[ ${OPTARG} ]]
            then
               years=${OPTARG};
            else
               years=0;
            fi
            ;;
        m) #months
            if [[ ${OPTARG} ]]
            then
                if [[ ${OPTARG} -gt 11 ]]
                then
                    echo "Months must be less than 12";
                    exit 0;
                else
                    months=${OPTARG};
                fi 
            else
                months=0;
            fi
            ;;
        d) #days
            if [[ ${OPTARG} ]]
            then
                if [[ ${OPTARG} -gt 6 ]]
                then
                    echo "Days must be less than 7";
                    exit 0;
                else
                    days=${OPTARG};
                fi
            else
                days=0;
            fi
            ;;
        h) #hours
            if [[ ${OPTARG} ]]
            then
                if [[ ${OPTARG} -gt 23 ]]
                then
                    echo "Hours must be less than 24";
                    exit 0;
                else
                    hours=${OPTARG};
                fi
            else
                hours=0;
            fi
            ;;
        i) #minutes
            if [[ ${OPTARG} ]]
            then
                if [[ ${OPTARG} -gt 59 ]]
                then
                    echo "Minutes must be less than 60";
                    exit 0;
                else
                    minutes=${OPTARG};
                fi
            else
                minutes=0;
            fi
            ;;
        p) permanent=1;;
    esac
done

# the following chunk checks to see if a backup of the original crontab exists
# if it doesnt, it creates it
ORIGINAL_FILE=/usr/lib/dlClear/crontab.original
if test -f "$ORIGINAL_FILE"; then
    yes | cp $ORIGINAL_FILE /usr/lib/dlClear/mycron
else
    crontab -l > $ORIGINAL_FILE
    yes | cp $ORIGINAL_FILE /usr/lib/dlClear/mycron
fi
#crontab -l > $HOME/.dlClear/mycron

# Minutes
if [[ "$minutes" -eq 0 ]]
then
    cminutes="*"
elif [[ "$minutes" -eq 1 ]]
then
    cminutes="*"
else
    cminutes="*/$minutes"
fi

# Hours
if [[ "$hours" -eq 0 ]]
then
    chours="*"
elif [[ "$hours" -eq 1 ]]
then
    chours="*"
    cminutes="0"
else
    chours="*/$hours"
    cminutes="0"
fi

# Days
if [[ "$days" -eq 0 ]]
then
    cdays="*"
elif [[ "$days" -eq 1 ]]
then
    cdays="*"
    chours="0"
    cminutes="0"
else
    cdays="*/$days"
    chours="0"
    cminutes="0"
fi

# Months
if [[ "$months" -eq 0 ]]
then
    cmonths="*"
else
    cmonths="*/$months"
    cdays="1"
    chours="0"
    cminutes="0"
fi


# Years
if [[ "$years" -eq 0 ]]
then
    cyears="" #if years isn't specified, there's no reason to include it in the crontab 
else
    cyears="? 2019/$years " #otherwise, specify it with this special string
    cmonths="1"
    cdays="1"
    chours="0"
    cminutes="0"
fi


# if a permanent deletion, rm -rf
# else move to trash
if [[ "$permanent" -eq 1 ]]
then
    echo "$cminutes $chours $cdays $cmonths * $cyears rm -rf -R $HOME/Downloads/* > /dev/null" >> /usr/lib/dlClear/mycron;
else
    echo "$cminutes $chours $cdays $cmonths * $cyears mv $HOME/Downloads/* $HOME/.local/share/Trash/files/ > /dev/null" >> /usr/lib/dlClear/mycron;
fi
crontab /usr/lib/dlClear/mycron
rm /usr/lib/dlClear/mycron


