#!/bin/bash

# Dependancies install jq
# dpkg -i jq_1.6-2.1_amd64.deb libjq1_1.6-2.1_amd64.deb libonig5_6.9.6-1.1_amd64.deb

VERSION="0.1"
NAME="mmcli_reconnector"
INSTALLPATH="."

#set -x
#trap 'echo "Trap cought ERR signal $NAME stopped";' ERR

#Source config variables
#. $INSTALLPATH/$NAME.conf
imodem=""
WWAN_IFACE="wwan0"
MTU="1500"
TMPLOG="/tmp/${NAME}_log_$$.txt"

#Source functions
. $INSTALLPATH/mmcli_reconnector_functions

findModem
initModem
connectBearer
configureWwan

echo "time;imodem;tmodem;statecon;mmc;mnc;tac;cellid;rssi;rsrq;rsrp;sinr;iinitbearer;ibearer;conbearer;address;prefix;gateway;pingmin;pingavg;pingmax;pingmdev;pingloss;pingduration"
while true
do
    i=0
    until [[ $i -eq 5 ]]
        do
        imodem=$(mmcli -L |grep -m 1 "Modem" |cut -d/ -f6 | awk '{print $1}')
        if [[ -z $imodem ]]; then
             warning "Existing modem not found please reinsert modem"
             findModem
             initModem
        fi

        iinitbearer=$(mmcli -m $imodem | grep -m 1 "initial bearer dbus path" |cut -d/ -f6 | awk '{print $1}')
        ibearer=$(mmcli -m $imodem | grep -m 1 "Bearer   |                dbus path" |cut -d/ -f6 | awk '{print $1}')
        statecon=$(mmcli -J -m $imodem | jq -r '.modem.generic.state')
        if [[ -z $ibearer ]]; then
             info "In main bearer not found for modem ID $imodem and modem is in state \"${statecon}\""
             connectBearer
             configureWwan
        else
            barerget=$(mmcli -b $ibearer)
            conbearer=$(echo $barerget | cut -d ':' -f4 | awk '{print $1}')
            statecon=$(mmcli -J -m $imodem | jq -r '.modem.generic.state')
            if [[ "$conbearer" == "no" ]]; then
                info "In main 1: bearer ID $ibearer status connected: $conbearer and modem in state  \"${statecon}\""
                connectBearer
                configureWwan
            fi
        fi

        i=$((i+1))
        debug "In main done itteration $i going to sleep for 1 second"
        sleep 0.91
    done

    statecon=$(mmcli -J -m $imodem | jq -r '.modem.generic.state')
    iinitbearer=$(mmcli -m $imodem | grep -m 1 "initial bearer dbus path" |cut -d/ -f6 | awk '{print $1}')
    ibearer=$(mmcli -m $imodem | grep -m 1 "Bearer   |                dbus path" |cut -d/ -f6 | awk '{print $1}')
    if [[ -n $ibearer ]]; then
        barerget=$(mmcli -b $ibearer)
        conbearer=$(echo $barerget | cut -d ':' -f4 | awk '{print $1}')
        if [[ "$conbearer" == "no" ]]; then
            info "In main 2: bearer ID $ibearer status connected: $conbearer and modem in state  \"${statecon}\""
            connectBearer
            configureWwan
        else
            info "In main 3: bearer ID $ibearer status connected: $conbearer and modem in state  \"${statecon}\""
            time=$(datetime)
            conbearer=$(echo $barerget | cut -d ':' -f4 | awk '{print $1}')
            address=$(echo $barerget | cut -d ':' -f12 | awk '{print $1}')
            prefix=$(echo $barerget | cut -d ':' -f13 | awk '{print $1}')
            gateway=$(echo $barerget | cut -d ':' -f14 | awk '{print $1}')

            locationget=$(mmcli  -m $imodem --location-get)
            mmc=$(echo $locationget | cut -d ':' -f2 | awk '{print $1}')
            mnc=$(echo $locationget | cut -d ':' -f3 | awk '{print $1}')
            tac=$(echo $locationget | cut -d ':' -f5 | awk '{print $1}')
            cellid=$(echo $locationget | cut -d ':' -f6 | awk '{print $1}')

            signalinput=$(mmcli -m $imodem --signal-get)
            rssi=$(echo $signalinput | cut -d ':' -f3 | awk '{print $1}')
            rssi=${rssi//[\.]/,}
            rsrq=$(echo $signalinput | cut -d ':' -f4 | awk '{print $1}')
            rsrq=${rsrq//[\.]/,}
            rsrp=$(echo $signalinput | cut -d ':' -f5 | awk '{print $1}')
            rsrp=${rsrp//[\.]/,}
            sinr=$(echo $signalinput | cut -d ':' -f6 | awk '{print $1}')
            sinr=${sinr//[\.]/,}

            pingerout=$(/usr/bin/ping -M dont -s 1472 -q -i 0.1 -c 5 72.14.196.142)
            pinger=($(echo $pingerout | awk '{print $26}' | sed 's/\// /g'))
            pingmin=${pinger[0]//[\.]/,}
            pingavg=${pinger[1]//[\.]/,}
            pingmax=${pinger[2]//[\.]/,}
            pingmdev=${pinger[3]//[\.]/,}
            pingloss=$(echo $pingerout | awk '{print $18}')
            pingduration=$(echo $pingerout | awk '{print $22}')

            echo "$time;$imodem;$tmodem;$statecon;$mmc;$mnc;$tac;$cellid;$rssi;$rsrq;$rsrp;$sinr;$iinitbearer;$ibearer;$conbearer;$address;$prefix;$gateway;$pingmin;$pingavg;$pingmax;$pingmdev;$pingloss;$pingduration"
        fi
    fi
done
