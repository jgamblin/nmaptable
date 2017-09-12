#!/bin/bash  

TARGETS="127.0.0.1"
OPTIONS='-sV -R'

cd  ~/nmaptable
LAST_RUN_FILE='lastrun'

while true; do
START_TIME=$(date +%s)
echo ''    
echo '=================='
echo '' 

DATE=`date +%Y-%m-%d_%H-%M-%S`

echo ''        
echo $(date) "- Starting Nmap Scan"
# Remove Old Gnmap
rm scan.gnmap
#Start Nmap:
nmap ${OPTIONS} ${TARGETS} -oG scan.gnmap > /dev/null
#Remove Old Data
rm data.csv
#Update Data:
./nmapcsv.sh scan.gnmap > data.csv


#2 Hour Count Down Between Scans
m=${1}-1 
Floor () {
DIVIDEND=${1}
DIVISOR=${2}
RESULT=$(( ( ${DIVIDEND} - ( ${DIVIDEND} % ${DIVISOR}) )/${DIVISOR} ))
echo ${RESULT}
}

Timecount(){
s=7200
HOUR=$( Floor ${s} 60/60 )
s=$((${s}-(60*60*${HOUR})))
MIN=$( Floor ${s} 60 )
SEC=$((${s}-60*${MIN}))
while [ $HOUR -ge 0 ]; do
while [ $MIN -ge 0 ]; do
while [ $SEC -ge 0 ]; do
printf "Rescanning in %02d:%02d:%02d\033[0K\r" $HOUR $MIN $SEC
SEC=$((SEC-1))
sleep 1
done
SEC=59
MIN=$((MIN-1))
done
MIN=59
HOUR=$((HOUR-1))
done
}

Timecount $m

done
