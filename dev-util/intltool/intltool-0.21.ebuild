# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.21.ebuild,v 1.2 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
	>=dev-libs/popt-1.5
	>=sys-devel/perl-5.6.0"

src_compile() {                           
	./configure --host=${CHOST}	\
		    --prefix=/usr		\
		    --sysconfdir=/etc	\
		    --localstatedir=/var/lib \
		    --mandir=/usr/share/man || die
	emake || die
}

src_install() {
	make prefix=${D}/usr	\
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib	\
	     mandir=${D}/usr/share/man \
	     install || die

	dodoc AUTHORS ChangeLog NEWS README
}

