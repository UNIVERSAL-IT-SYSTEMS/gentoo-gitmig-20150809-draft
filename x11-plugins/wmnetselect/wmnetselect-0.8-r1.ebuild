# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetselect/wmnetselect-0.8-r1.ebuild,v 1.2 2002/10/04 06:46:00 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="WindowMaker browser launcher doclette"
HOMEPAGE="http://freshmeat.net/projects/wmnetselect/"
SRC_URI="ftp://ftp11.freebsd.org/pub/FreeBSD/ports/distfiles/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	emake CDEBUGFLAGS="${CFLAGS}" wmnetselect || die
}

src_install () {
	dobin   wmnetselect
	dodoc   COPYING README ChangeLog TODO README.html
}
