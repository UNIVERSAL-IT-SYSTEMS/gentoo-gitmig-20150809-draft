# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iptables/iptables-1.2.4-r1.ebuild,v 1.1 2001/12/22 15:55:46 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="http://netfilter.samba.org/${P}.tar.bz2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/g" -e "s:/usr/local:/usr:g" Makefile.orig > Makefile
}

src_compile() {
	#I had a problem with emake - DR
	make || die
}

src_install() {
	dodir /usr/{lib,share/man/man8,sbin}
	# iptables and libraries are now installed to /sbin and /lib.  Why?  So systems
	# with remote network-mounted /usr filesystems can get their network interfaces
	# up and running correctly without /usr.
	make LIBDIR=${D}/lib \
		BINDIR=${D}/sbin \
		MANDIR=${D}/usr/share/man \
		install || die
	dodoc COPYING KNOWN_BUGS
}
