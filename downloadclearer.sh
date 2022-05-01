#!/bin/bash

while getopts y:m:d:h:M flag
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
        M) #minutes
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

# the following chunk checks to see if a backup of the original crontab exists
# if it doesnt, it creates it
ORIGINAL_FILE=$HOME/.dlClear/crontab.original
if test -f "$ORIGINAL_FILE"; then
    yes | cp $ORIGINAL_FILE $HOME/.dlClear/mycron
else
    crontab -l > $ORIGINAL_FILE
    yes | cp $ORIGINAL_FILE $HOME/.dlClear/mycron
fi
crontab -l > $HOME/.dlClear/mycron

# Years
if [[ "$years" -eq 0 ]]
then
    cyears="" #if years isn't specified, there's no reason to include it in the crontab 
else
    cyears="? 2019/$years" #otherwise, specify it with this special string
fi

# Months
if [[ "$months" -eq 0 ]]
then
    cmonths="0" 
elif [[ "$months" -eq 1 ]]
then
    cmonths="1"
else
    cmonths="*/$months"
fi

# Days
if [[ "$days" -eq 0 ]]
then
    cdays="0"
elif [[ "$days" -eq 1 ]]
then
    cdays="*"
else
    cdays="*/$days"
fi

# Hours
if [[ "$hours" -eq 0 ]]
then
    chours="0"
elif [[ "$hours" -eq 1 ]]
then
    chours="*"
else
    chours="*/$hours"
fi

# Minutes
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


