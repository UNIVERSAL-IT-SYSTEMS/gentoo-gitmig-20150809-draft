# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# /home/cvsroot/gentoo-x86/app-admin/mon/mon-0.38.20.ebuild,v 1.2 2001/01/20 01:13:36 achim Exp

S=${WORKDIR}/${P}
DESCRIPTION="Highly configurable service monitoring daemon"
SRC_URI="ftp://ftp.kernel.org/pub/software/admin/mon/mon-0.38.20.tar.bz2"
HOMEPAGE="http://www.kernel.org/software/mon/"

DEPEND=">=dev-perl/Mon-0.9"

src_compile() {

    cd ${S}/mon.d
    try make

}

src_install () {

    cd ${S}

    dosbin mon clients/mon*

    insinto /etc/mon
    doins etc/*.cf etc/example.monshowrc

    insinto /usr/lib/mon/utils
    doins utils/*


    exeinto /usr/lib/mon/alert.d
    doexe alert.d/*
  
    exeinto /usr/lib/mon/mon.d
    doexe mon.d/*.monitor
    insopts -g uucp -m 02555 
    doins mon.d/*.wrap
	
    exeinto /etc/rc.d/init.d
    doexe ${FILESDIR}/mon

    dodir /var/log/mon.d
    dodir /var/lib/mon.d
    dodoc CHANGES COPYING CREDITS KNOWN-PROBLEMS
    dodoc mon.lsm README TODO VERSION
    doman doc/*.1
    docinto txt
    dodoc doc/README*
}


