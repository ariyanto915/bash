#!/bin/bash

FORMAT=tgz
ZHOME=/opt/zimbra
ZBACKUP=/srv/backup/bulanan
ZCONFD=$ZHOME/conf
BULAN=`date +"%B"`
ZDUMPDIR=$ZBACKUP/$BULAN
ZMBOX=/opt/zimbra/bin/zmmailbox
OLD=`date --date="30 days ago" +"%B"`

echo "==============="
echo "Backup Monthly `date`"
echo "==============="


if [ ! -d $ZDUMPDIR ]; then
        mkdir -p $ZDUMPDIR
fi

for mbox in `sudo su - zimbra -c 'zmprov -l gaa'`
do
echo "Backup User $mbox ..."
        $ZMBOX -z -m $mbox getRestURL "//?fmt=${FORMAT}" > $ZDUMPDIR/$mbox.${FORMAT}
done

#echo "=============="
#echo "Compress Old Directory"
#echo "=============="
#find /srv/backup/bulanan/ -type d -mtime 30 -exec tar -czvf $OLD.tar.gz --remove-files {} \;

echo "==============="
echo "Zimbra Monthly backup selesai."
echo "==============="
