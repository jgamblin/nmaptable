#!/bin/bash -u

 
TARGETS="jerrygamblin.com"
INTERVAL="3600"
OPTIONS='-sV'
 
 
cd  ~/nmaptable
LAST_RUN_FILE='.lastrun'
 
while true; do
 
    # If the last run file exists, we should only sleep for the time
    # specified minus the time that's already elapsed.
    if [ -e "${LAST_RUN_FILE}" ]; then
        LAST_RUN_TS=$(date -r ${LAST_RUN_FILE} +%s)
        NOW_TS=$(date +%s)
        LAST_RUN_SECS=$(expr ${NOW_TS} - ${LAST_RUN_TS})
        SLEEP=$(expr ${INTERVAL} - ${LAST_RUN_SECS})
        if [ ${SLEEP} -gt 0 ]; then
            UNTIL_SECS=$(expr ${NOW_TS} + ${SLEEP})
            echo $(date) "- sleeping until" $(date --date="@${UNTIL_SECS}") "(${SLEEP}) seconds"
            sleep ${SLEEP}
        fi
    fi
 
    START_TIME=$(date +%s)
    echo ''
    echo '=================='
    echo ''

                echo ''
                echo $(date) "- starting nmap scan"

        # Remove Old Gnmap
        rm scan.gnmap
        # Scan Carfax:
        nmap ${OPTIONS} ${TARGETS} -oG scan.gnmap > /dev/null
        #Remove Old Data
        rm data.csv
        # Update Data:
        ./nmapcsv.sh scan.gnmapp > data.csv

    done
done