# [ Base ]
FROM debian:buster

RUN export DEBIAN_FRONTEND=noninteractive; 

# [ Maintainer ] 
LABEL maintainer="Zeynep Duygu Ölmez zeynepduyguolmez@gmail.com"

# [ Dependencies ]
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt -yq update && apt -yqq install krb5-user krb5-config krb5-kdc
RUN apt -yq update && apt -yq install acl apt-utils attr autoconf bind9utils binutils bison build-essential ccache chrpath curl debhelper dnsutils docbook-xml docbook-xsl flex gcc gdb git glusterfs-common 
RUN apt -yq install gzip heimdal-multidev hostname htop lcov libacl1-dev libarchive-dev libattr1-dev libavahi-common-dev libblkid-dev libbsd-dev libcap-dev 
RUN apt -yq install libcephfs-dev libcups2-dev libdbus-1-dev libglib2.0-dev libgnutls28-dev libgpgme11-dev libicu-dev libjansson-dev libjs-jquery libjson-perl libkrb5-dev libldap2-dev
RUN apt -yq install liblmdb-dev libncurses5-dev libpam0g-dev libparse-yapp-perl libpcap-dev libpopt-dev libreadline-dev libsystemd-dev libtasn1-bin libtasn1-dev libunwind-dev lmdb-utils 
RUN apt -yq install locales lsb-release make mawk mingw-w64 patch perl perl-modules pkg-config procps psmisc python3 python3-cryptography python3-dbg python3-dev python3-dnspython 
RUN apt -yq install python3-gpg python3-iso8601 python3-markdown python3-matplotlib python3-pexpect python3-pyasn1 python3-setproctitle rng-tools rsync
RUN apt -yq install sed sudo tar tree uuid-dev 
RUN apt -yq install samba-*

## Ubuntu
## RUN apt -y install language-pack-en   

# [ Version ]
ARG sambaver=4.15.3

# [ Compile ]
RUN mkdir /opt/samba4
RUN cd /usr/src; curl -O --insecure https://download.samba.org/pub/samba/stable/samba-$sambaver.tar.gz; tar xvfz samba-$sambaver.tar.gz
RUN cd /usr/src/samba-$sambaver; ./configure  --prefix=/usr/share/samba --sbindir=/usr/sbin --bindir=/usr/bin --with-configdir=/etc/samba --with-logfilebase=/var/log/samba \--libdir=/usr/lib/x86_64-linux-gnu --with-modulesdir=/usr/lib/x86_64-linux-gnu/samba --with-lockdir=/var/run/samba --with-statedir=/var/lib/samba --with-cachedir=/var/cache/samba --with-piddir=/var/run/samba --with-smbpasswd-file=/etc/samba/smbpasswd --with-privatedir=/var/lib/samba/private --with-bind-dns-dir=/var/lib/samba/bind-dns --enable-cups --with-acl-support --with-ads  --with-automount --enable-fhs --with-pam --with-quotas --with-syslog --with-utmp --with-shared-modules=idmap_rid,idmap_ad,idmap_hash,idmap_adex
RUN cd /usr/src/samba-$sambaver; make
RUN cd /usr/src/samba-$sambaver; make install DESTDIR=/opt/samba4/

# [ Pack ]
RUN cd /opt/; tar -czvf samba.tar.gz /opt/samba4/
RUN cd /opt/; ls -la
