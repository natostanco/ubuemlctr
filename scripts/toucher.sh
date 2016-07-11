#!/bin/bash

echo "touching lists"
touch `cat /host/list.txt`
sleep 3
touch `cat /host/manuallist.txt`
sleep 3
touch `cat /host/lddlist.txt`
echo "done touching lists"

/host/scripts/entry.sh
