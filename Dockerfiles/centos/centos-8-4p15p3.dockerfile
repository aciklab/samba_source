# [ Base ]
FROM centos:8

# [ Maintainer ] 
LABEL maintainer="Fatih Arslan Tugay fatiharslantugay@gmail.com"

# [ Dependencies ]

RUN set -xueo pipefail

RUN sed -i 's/#baseurl/baseurl/g' /etc/yum.repos.d/*
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/*
RUN sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/*
RUN yum update -y
RUN yum install -y dnf-plugins-core
RUN yum install -y epel-release

RUN yum -v repolist all
RUN yum config-manager --set-enabled PowerTools -y || \
    yum config-manager --set-enabled powertools -y
RUN yum config-manager --set-enabled Devel -y || \
    yum config-manager --set-enabled devel -y
RUN yum update -y

RUN yum install -y \
    --setopt=install_weak_deps=False \
    "@Development Tools" \
    acl \
    attr \
    autoconf \
    avahi-devel \
    bind-utils \
    binutils \
    bison \
    ccache \
    chrpath \
    cups-devel \
    curl \
    dbus-devel \
    docbook-dtds \
    docbook-style-xsl \
    flex \
    gawk \
    gcc \
    gdb \
    git \
    glib2-devel \
    glibc-common \
    glibc-langpack-en \
    glusterfs-api-devel \
    glusterfs-devel \
    gnutls-devel \
    gpgme-devel \
    gzip \
    hostname \
    htop \
    jansson-devel \
    keyutils-libs-devel \
    krb5-devel \
    krb5-server \
    libacl-devel \
    libarchive-devel \
    libattr-devel \
    libblkid-devel \
    libbsd-devel \
    libcap-devel \
    libcephfs-devel \
    libicu-devel \
    libnsl2-devel \
    libpcap-devel \
    libtasn1-devel \
    libtasn1-tools \
    libtirpc-devel \
    libunwind-devel \
    libuuid-devel \
    libxslt \
    lmdb \
    lmdb-devel \
    make \
    mingw64-gcc \
    ncurses-devel \
    openldap-devel \
    pam-devel \
    patch \
    perl \
    perl-Archive-Tar \
    perl-ExtUtils-MakeMaker \
    perl-JSON \
    perl-Parse-Yapp \
    perl-Test-Simple \
    perl-generators \
    perl-interpreter \
    pkgconfig \
    popt-devel \
    procps-ng \
    psmisc \
    python3 \
    python3-cryptography \
    python3-devel \
    python3-dns \
    python3-gpg \
    python3-iso8601 \
    python3-libsemanage \
    python3-markdown \
    python3-policycoreutils \
    python3-pyasn1 \
    python3-setproctitle \
    quota-devel \
    readline-devel \
    redhat-lsb \
    rng-tools \
    rpcgen \
    rpcsvc-proto-devel \
    rsync \
    sed \
    sudo \
    systemd-devel \
    tar \
    tree \
    wget \
    which \
    xfsprogs-devel \
    yum-utils \
    zlib-devel

RUN yum clean all

# [ Version ]
ARG sambaver=4.15.3

# [ Compile ]
RUN mkdir /opt/samba4
RUN cd /usr/src; curl -O https://download.samba.org/pub/samba/stable/samba-$sambaver.tar.gz; tar xvfz samba-$sambaver.tar.gz
RUN cd /usr/src/samba-$sambaver; ./configure --prefix=/usr  --sbindir=/usr/sbin  --bindir=/usr/bin  --with-configdir=/etc/samba  --with-logfilebase=/var/log/samba  --libdir=/usr/lib64  --datarootdir=/usr/share  --datadir=/usr/share  --with-modulesdir=/usr/lib64/samba  --with-lockdir=/var/lib/samba/lock  --with-statedir=/var/lib/samba  --with-cachedir=/var/lib/samba  --with-piddir=/run  --with-smbpasswd-file=/var/lib/samba/private/smbpasswd  --with-privatedir=/var/lib/samba/private  --with-bind-dns-dir=/var/lib/samba/bind-dns  --enable-cups --with-acl-support --with-ads  --with-automount --enable-fhs --with-pam --with-quotas --with-syslog --with-utmp --with-shared-modules=idmap_rid,idmap_ad,idmap_hash,idmap_adex
RUN cd /usr/src/samba-$sambaver; make
RUN cd /usr/src/samba-$sambaver; make install DESTDIR=/opt/samba4/


# [ Pack ]
RUN cd /opt/; tar -czvf samba.tar.gz /opt/samba4/
RUN cd /opt/; ls -la
