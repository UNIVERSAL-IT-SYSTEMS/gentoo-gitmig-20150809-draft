# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdlroids/sdlroids-1.3.4-r2.ebuild,v 1.3 2004/01/24 12:48:12 mr_bones_ Exp $

DESCRIPTION="Asteroids Clone for X using SDL"
HOMEPAGE="http://david.hedbor.org/projects/sdlroids/"
SRC_URI="mirror://sourceforge/sdlroids/${P}.tar.bz2"

RESTRICT="nomirror"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.8"

src_compile() {
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --datadir=/usr/share
	assert

	emake || die
}

src_install () {
	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     datadir=${D}/usr/share \
	     install || die

	dodoc COPYING ChangeLog README.orig README.* TODO
}
