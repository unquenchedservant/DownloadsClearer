#!/bin/bash

while getopts y:m:d:h:M flag
do
    case "${flag}" in
        y) 
            if [[ ${OPTARG} ]]
            then
               years=${OPTARG};
            else
               years=0;
            fi
            ;;
        m)
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
        d)
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
        h)
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
        M)
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
    esac
done

ORIGINAL_FILE=$HOME/.dlClear/crontab.original
if test -f "$ORIGINAL_FILE"; then
    yes | cp $ORIGINAL_FILE $HOME/.dlClear/mycron
else
    crontab -l > $ORIGINAL_FILE
    yes | cp $ORIGINAL_FILE $HOME/.dlClear/mycron
fi
crontab -l > $HOME/.dlClear/mycron

if [[ "$years" -eq 0 ]]
then
    cyears="" 
else
    cyears="? 2019/$years"
fi

if [[ "$months" -eq 0 ]]
then
    cmonths="0"
elif [[ "$months" -eq 1 ]]
then
    cmonths="1"
else
    cmonths="*/$months"
fi

if [[ "$days" -eq 0 ]]
then
    cdays="0"
elif [[ "$days" -eq 1 ]]
then
    cdays="*"
else
    cdays="*/$days"
fi

if [[ "$hours" -eq 0 ]]
then
    chours="0"
elif [[ "$hours" -eq 1 ]]
then
    chours="*"
else
    chours="*/$hours"
fi

if [[ "$minutes" -eq 0 ]]
then
    cminutes="0"
elif [[ "$minutes" -eq 1 ]]
then
    cminutes="*"
else
    cminutes="*/$minutes"
fi

echo "$cminutes $chours $cdays $cmonths $cyears rm -rf -R $HOME/Downloads/* > $HOME/.dlClear/logs/\`date +%Y%m%d\%H%M\%s\`-cron.log 2>&1" >> $HOME/.dlClear/mycron;
crontab $HOME/.dlClear/mycron
rm $HOME/.dlClear/mycron


