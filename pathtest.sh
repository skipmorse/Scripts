#!/bin/bash

find /tmp/testing -iname "*" | while read file
do
    # ... loop body
	echo $file
	sleep 5
done
