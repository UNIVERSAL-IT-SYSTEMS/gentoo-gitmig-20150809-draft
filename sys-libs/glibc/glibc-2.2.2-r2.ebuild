# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.2.2-r2.ebuild,v 1.1 2001/04/09 05:33:45 achim Exp $

A="$P.tar.gz glibc-linuxthreads-${PV}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-${PV}.tar.gz
	 ftp://sourceware.cygnus.com/pub/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-${PV}.tar.gz
	 ftp://ftp.unina.it/pub/Unix/cygnus/glibc/releases/glibc-linuxthreads-${PV}.tar.gz
	 ftp://ftp.gnu.org/pub/gnu/glibc/glibc-${PV}.tar.gz
	 ftp://ftp.gnu.org/pub/gnu/glibc/glibc-linuxthreads-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

DEPEND="nls? ( sys-devel/gettext ) gd? ( media-libs/libgd )"

RDEPEND="gd? ( sys-libs/zlib media-libs/libpng )"

PROVIDE="virtual/glibc"

src_unpack() {

    unpack glibc-${PV}.tar.gz
    cd ${S}
    unpack glibc-linuxthreads-${PV}.tar.gz
    for i in mtrace-perl mtrace-tst-loading-perl posix-bug-regex2-mem-perl configure.in configure
    do
      echo "Applying $i patch..."
      patch -p0 < ${FILESDIR}/glibc-2.2.2-${i}.diff
    done
    cd io
    patch -p0 < ${FILESDIR}/glibc-2.2.2-test-lfs-timeout.patch


}

src_compile() {

	local myconf
	if [ "`use build`" ]
	then
	  # If we build for the build system we use the kernel headers from the target
	  myconf="--with-header=${ROOT}usr/include"
	fi
	if [ "`use gd`" ]
	then
	  myconf="${myconf} --with-gd=yes"
	else
	  myconf="${myconf} --with-gd=no"
	fi
    if [ -z "`use nls`" ]
    then
      myconf="${myconf} --disable-nls"
    fi
    rm -rf buildhere
	mkdir buildhere
	cd buildhere
	try ../configure --host=${CHOST} --without-cvs \
		--enable-add-ons=linuxthreads \
		--disable-profile --prefix=/usr \
                --mandir=/usr/share/man --infodir=/usr/share/info \
                --libexecdir=/usr/lib/misc \
		--enable-kernel=2.4.0 ${myconf}
	try make 
	make check
}


src_install() {

    rm -rf ${D}
    mkdir ${D}
    dodir /etc/rc.d/init.d
    export LC_ALL=C
    try make PARALELLMFLAGS=${MAKEOPTS} install_root=${D} install -C buildhere
    try make PARALELLMFLAGS=${MAKEOPTS} install_root=${D} info -C buildhere
    if [ -z "`use build`" ]
    then
      try make PARALELLMFLAGS=${MAKEOPTS} install_root=${D} localedata/install-locales -C buildhere

	# I commented out linuxthreads man pages because I don't want
	# glibc to build depend on perl
	#    dodir /usr/share/man/man3
	#    try make MANDIR=${D}/usr/share/man/man3 install -C linuxthreads/man
	#    cd ${D}/usr/share/man/man3
	#    for i in *.3thr
	#    do
	#      mv ${i} ${i%.3thr}.3
	#    done

      install -m 644 nscd/nscd.conf ${D}/etc
      install -m 755 ${FILESDIR}/nscd ${D}/etc/rc.d/init.d/nscd
      dodoc BUGS ChangeLog* CONFORMANCE COPYING* FAQ INTERFACE NEWS NOTES \
	  PROJECTS README*
    else
      rm -rf ${D}/usr/share/{man,info,zoneinfo}
    fi

    if [ "`use pic`" ]
    then
        find ${S}/buildhere -name "*_pic.a" -exec cp {} ${D}/lib \;
        find ${S}/buildhere -name "*.map" -exec cp {} ${D}/lib \;
        for i in ${D}/lib/*.map
        do
          mv ${i} ${i%.map}_pic.map
        done
    fi
    rm ${D}/lib/ld-linux.so.2
    rm ${D}/lib/libc.so.6

    chmod 755 ${D}/usr/lib/misc/pt_chown
 
}

pkg_preinst()
{
  echo "Saving ld-linux and libc6"

  /bin/cp ${ROOT}lib/ld-linux.so.2 ${ROOT}tmp
  /sbin/sln ${ROOT}tmp/ld-linux.so.2 ${ROOT}lib/ld-linux.so.2
  /bin/cp ${ROOT}lib/libc.so.6 ${ROOT}tmp
  /sbin/sln ${ROOT}tmp/libc.so.6 ${ROOT}lib/libc.so.6

	if [ -e ${ROOT}etc/localtime ]
	then
		#keeping old timezone
		/bin/rm ${D}/etc/localtime
	else
		echo "Please remember to set your timezone using the zic command."
	fi
}

pkg_postinst()
{
  echo "Setting ld-linux and libc6"

  /sbin/sln ${ROOT}lib/ld-${PV}.so ${ROOT}lib/ld-linux.so.2
  /sbin/sln ${ROOT}lib/libc-${PV}.so ${ROOT}lib/libc.so.6
  /bin/rm  ${ROOT}tmp/ld-linux.so.2
  /bin/rm  ${ROOT}tmp/libc.so.6
  /sbin/ldconfig -r ${ROOT}

}



