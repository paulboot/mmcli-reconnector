#!/bin/bash

echo "Start"

wget http://ftp.de.debian.org/debian/pool/main/g/git/git_2.34.1-1~bpo11+1_amd64.deb
wget http://ftp.de.debian.org/debian/pool/main/c/curl/libcurl3-gnutls_7.82.0-2~bpo11+1_amd64.deb
wget http://ftp.de.debian.org/debian/pool/main/g/git/git-man_2.34.1-1~bpo11+1_all.deb
wget http://ftp.de.debian.org/debian/pool/main/libe/liberror-perl/liberror-perl_0.17029-1_all.deb
wget https://github.com/cli/cli/releases/download/v2.13.0/gh_2.13.0_linux_amd64.deb

dpkg -i git_2.34.1-1~bpo11+1_amd64.deb libcurl3-gnutls_7.82.0-2~bpo11+1_amd64.deb git-man_2.34.1-1~bpo11+1_all.deb liberror-perl_0.17029-1_all.deb gh_2.13.0_linux_amd64.deb

echo "DONE"

