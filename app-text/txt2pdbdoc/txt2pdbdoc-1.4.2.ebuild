# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2pdbdoc/txt2pdbdoc-1.4.2.ebuild,v 1.11 2004/06/24 22:54:20 agriffis Exp $

DESCRIPTION="Text to Doc file converter for the Palm Pilot.  Also includes an HTML to Doc converter."
SRC_URI="http://homepage.mac.com/pauljlucas/software/${P}.tar.gz"
HOMEPAGE="http://homepage.mac.com/pauljlucas/software.html"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-lang/perl"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING README INSTALL ChangeLog
}
