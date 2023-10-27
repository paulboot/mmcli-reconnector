#!/bin/bash

echo "Start"

PACKAGES="libc6_2.33-7_amd64.deb libc-bin_2.33-7_amd64.deb libc-l10n_2.33-7_all.deb libmbim-glib4_1.26.4-1_amd64.deb libmm-glib0_1.18.8-1_amd64.deb libqmi-glib5_1.30.6-1_amd64.deb libqrtr-glib0_1.2.2-1_amd64.deb locales_2.33-7_all.deb modemmanager_1.18.8-1_amd64.deb"

# VyOS 1.4-rolling-202306020317 has newer components installed
# wget http://ftp.de.debian.org/debian/pool/main/m/modemmanager/modemmanager_1.18.8-1_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/m/modemmanager/libmm-glib0_1.18.8-1_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/m/modemmanager/libmm-glib0_1.18.6-1~bpo11+1_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/m/modemmanager/modemmanager_1.18.6-1~bpo11+1_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/libq/libqrtr-glib/libqrtr-glib0_1.2.2-1_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/g/glibc/libc6_2.33-7_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/libm/libmbim/libmbim-glib4_1.26.4-1_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/libq/libqmi/libqmi-glib5_1.30.6-1_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/g/glibc/locales_2.33-7_all.deb
# wget http://ftp.de.debian.org/debian/pool/main/g/glibc/libc-bin_2.33-7_amd64.deb
# wget http://ftp.de.debian.org/debian/pool/main/g/glibc/libc-l10n_2.33-7_all.deb

wget http://ftp.de.debian.org/debian/pool/main/j/jq/jq_1.7-1_amd64.deb
wget http://ftp.de.debian.org/debian/pool/main/j/jq/libjq1_1.7-1_amd64.deb
wget http://ftp.de.debian.org/debian/pool/main/libo/libonig/libonig5_6.9.8-2_amd64.deb

wget https://github.com/cli/cli/releases/download/v2.37.0/gh_2.37.0_linux_amd64.deb

dpkg --auto-deconfigure -i *.deb

echo "DONE"

