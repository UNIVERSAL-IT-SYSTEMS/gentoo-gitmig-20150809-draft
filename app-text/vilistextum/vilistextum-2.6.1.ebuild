# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vilistextum/vilistextum-2.6.1.ebuild,v 1.10 2004/06/24 22:55:14 agriffis Exp $

DESCRIPTION="Vilistextum is a html to ascii converter specifically programmed to get the best out of incorrect html."
SRC_URI="http://www.mysunrise.ch/users/bhaak/vilistextum/${P}.tar.bz2"
HOMEPAGE="http://www.mysunrise.ch/users/bhaak/vilistextum/"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	./configure \
		--enable-multibyte \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README README.multibyte README.xhtml CHANGES
}
