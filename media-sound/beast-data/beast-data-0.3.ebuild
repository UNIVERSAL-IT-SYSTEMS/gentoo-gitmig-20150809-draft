# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast-data/beast-data-0.3.ebuild,v 1.5 2003/02/28 16:54:59 liquidx Exp $

DESCRIPTION="BEAST - the Bedevilled Sound Engine (datafiles)"
HOMEPAGE="http://beast.gtk.org"
LICENSE="GPL-2"

DEPEND=">=media-sound/beast-0.4.1"

SRC_URI="ftp://beast.gtk.org/pub/beast/v0.3/${P}.tar.gz"
KEYWORDS='~x86'
SLOT="0"
S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING INSTALL NEWS README TODO
}
