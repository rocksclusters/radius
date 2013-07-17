#!/bin/bash
#
# @Copyright@
# @Copyright@
#
#

. $ROLLSROOT/etc/bootstrap-functions.sh



YumCache=/var/cache/yum/
YumCacheBase=$YumCache/base/packages/

BasePakg="freeradius freeradius-utils"

mkdir -p RPMS/x86_64

yum --enablerepo=base install $BasePakg
for i in $BasePakg; do 
	cp $YumCacheBase/$i*rpm  RPMS/x86_64;
done


