#!/bin/bash

while getopts y:m:w:d:h:M:s flag
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
        w)
            if [[ ${OPTARG} ]]
            then
                if [[ ${OPTARG} -gt 3 ]] #going with the standard of 4 weeks to a month, i know it isn't pretty
                then
                    echo "Weeks must be less than 4";
                    exit 0;
                else
                    weeks=${OPTARG};
                fi
            else
                weeks = 0;
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
        s)
            if [[ ${OPTARG} ]]
            then
                if [[ ${OPTARG} -gt 59 ]]
                then
                    echo "Seconds must be less than 60";
                    exit 0;
                else
                    seconds=${OPTARG};
                fi
            else
                seconds=0;
            fi
            ;;
    esac
done
echo "Years: $years";
echo "Months: $months";
echo "Weeks: $weeks";
echo "Days: $days";
echo "Hours: $hours";
echo "Minutes: $minutes";
echo "Seconds: $seconds";