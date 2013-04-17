#!/bin/bash
# ZULETZT GEÄNDERT: 20090616
# Aufruf: bailly.sh [Datei.sfd] [Fontformat:otf/ttf/pfb]
#hole aus einem dateinamen die versionsnummer (dateiendung sfd)
if [[ $1 =~ ^.*-([0-9]+(\.[0-9]+)+)\RO.sfd$ ]];
then echo version: ${BASH_REMATCH[1]} ; fi
echo $1 $2 ${BASH_REMATCH[1]}
#echo "./sfd2otf-2.pe $1 "${BASH_REMATCH[1]}""

echo "./sfd2"$2".pe" $1 ${BASH_REMATCH[1]}
../scripts/sfd2$2.pe $1 ${BASH_REMATCH[1]}