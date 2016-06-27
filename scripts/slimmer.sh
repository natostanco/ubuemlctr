#!/bin/bash

set -ev

SAVE=$1
cnt=$2
slim=$3
pkg=$4

docker pull tvial/docker-mailserver

docker tag tvial/docker-mailserver ${cnt}

docker run -it --rm -v $SAVE:/host --entrypoint "/bin/bash" $cnt "/host/scripts/lister.sh" "$pkg"

./docker-slim build \
--remove-file-artifacts \
--entrypoint "/bin/bash" \
--cmd "/host/scripts/toucher.sh" \
--mount ${SAVE}/config:/tmp/docker-mailserver \
--mount ${SAVE}:/host \
--include-path /var/spool/postfix  \
--include-path /etc/init.d  \
--include-path /usr/lib/amavis  \
--include-path /usr/lib/dovecot  \
--include-path /var/log  \
--include-path /usr/bin/doveadm  \
--include-path /usr/bin/doveconf  \
--include-path /usr/bin/maildirmake.dovecot  \
--include-path /usr/share/dovecot  \
--include-path /usr/lib/perl5/Net/DNS/RR/TXT.pm  \
--include-path /usr/share/perl/5.18.2/Text/ParseWords.pm  \
--include-path /usr/lib/perl5/auto/Crypt/OpenSSL/RSA/new_public_key.al  \
--include-path /usr/bin/tail  \
--include-path /usr/local/bin  \
--include-path /usr/bin/cut  \
--include-path /bin/mv  \
--include-path /bin/ls  \
--include-path /bin/cp  \
--include-path /bin/chmod  \
--include-path /usr/bin/sort  \
--include-path /usr/bin/uniq  \
--include-path /lib/x86_64-linux-gnu/libacl.so.1  \
--include-path /lib/x86_64-linux-gnu/libattr.so.1  \
--include-path /etc/mtab  \
--include-path /etc/ssl \
--continue-after 30 \
--http-probe \
--tag ${cnt}${slim} \
$cnt
