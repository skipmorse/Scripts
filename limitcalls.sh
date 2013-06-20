#!/bin/bash
function payload(){
set -x
FROMPATH="/var/spool/asterisk/tmp/"
TOPATH="/var/spool/asterisk/outgoing/"

while [ true ];
checkforterm
        do
                if [ "$(ls $TOPATH | wc -l)" -lt 3 ]
                        then
                        if [ "$(ls -A $FROMPATH 2> /dev/null)" != "" ]
                                then
                                NEXTUP=`ls -lar $FROMPATH* | grep ^- | sort -r | awk '{print $9}' | head -1`
                                echo $NEXTUP
                                mv $NEXTUP $TOPATH
                                #ls -la /callfiles/* | sort -r
                        fi

                fi
        sleep 1
        done

set +x
}
source /scripts/daemon-functions.sh
#function payload() {
#while [ true ]; do
#checkforterm
#date
#sleep 1
#done
#}
#source path/to/daemon-functions.sh

