#!/bin/bash
cd
pkg=$1

apt update
apt install apt-rdepends -y -q

pkgdeps=`apt-rdepends $pkg 2>/dev/null | grep -v -i depends | awk '{print $1}'`
pkgRdeps=`apt-rdepends $pkg 2>/dev/null | grep -i depends | awk '{print $2}' | sort -u`

pkgfiles=`dpkg -L $pkg 2>/dev/null | grep -v -e "\/usr\/share" | grep -v -e "^\/[^\/]*$"`

depsfiles=''
for i in $pkgdeps;
do
  depsfiles+="\n"`dpkg -L $i 2>/dev/null | grep -v -e "\/usr\/share" | grep -v -e "^\/[^\/]*$"`
done

Rdepsfiles=''
for i in $pkgRdeps;
do
  Rdepsfiles+="\n"`dpkg -L $i 2>/dev/null | grep -v -e "\/usr\/share" | grep -v -e "^\/[^\/]*$"`
done

all=`echo "$pkgfiles$depsfiles$Rdepsfiles" | sort -u`
printf "$all" > /host/list.txt
