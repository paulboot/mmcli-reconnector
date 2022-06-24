#!/bin/bash

echo "Start"

CKAGES="libc6_2.33-7_amd64.deb libc-bin_2.33-7_amd64.deb libc-l10n_2.33-7_all.deb libmbim-glib4_1.26.4-1_amd64.deb libmm-glib0_1.18.8-1_amd64.deb libqmi-glib5_1.30.6-1_amd64.deb libqrtr-glib0_1.2.2-1_amd64.deb locales_2.33-7_all.deb modemmanager_1.18.8-1_amd64.deb"


wget http://ftp.de.debian.org/debian/pool/main/j/jq/jq_1.6-2.1_amd64.deb
dpkg -i jq_1.6-2.1_amd64.deb

echo "DONE"

