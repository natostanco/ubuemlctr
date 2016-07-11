#!/bin/bash
include=( "/usr/bin/post*" \
          "/bin/ps" \
          "/usr/sbin/post*" \
          "/usr/lib/libpostfix*" \
          "/usr/bin/cmp" \
          )
 
for n in ${!include[*]}
do
find ${include[n]} | xargs -I {} ldd {} | awk '{print $3}' | grep '/' | sort -u | xargs -I {} echo {} >> /tmp/touch
sleep 2
echo "$n"
done
cat /tmp/touch | sort -u >> /host/manuallist.txt
rm /tmp/touch

while read in;
do
ldd $in 2>/dev/null | awk '{print $3}' | grep '/' | sort -u | xargs -I {} echo {} >> /tmp/touch
done < /host/list.txt
cat /tmp/touch | sort -u >> /host/lddlist.txt
rm /tmp/touch
