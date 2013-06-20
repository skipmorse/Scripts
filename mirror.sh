#!/bin/bash
killall -q lftp
sleep 10
lftp -f /scripts/lftp.script
