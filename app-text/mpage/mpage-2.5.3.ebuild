# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mpage/mpage-2.5.3.ebuild,v 1.6 2004/06/24 22:45:04 agriffis Exp $

DESCRIPTION="Many to one page printing utility"
HOMEPAGE="http://www.mesa.nl/"
SRC_URI="http://www.mesa.nl/pub/mpage/${P}.tgz"

KEYWORDS="x86 sparc amd64"
LICENSE="freedist"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake \
		CFLAGS="$CFLAGS \$(DEFS)" \
		PREFIX=/usr \
		MANDIR=/usr/share/man/man1 || die "emake failed"
}

src_install () {
	make \
		PREFIX="${D}/usr" \
		MANDIR="${D}/usr/share/man/man1" install || die "make install failed"
	dodoc CHANGES Encoding.format FAQ NEWS README TODO || die "dodoc failed"
}
