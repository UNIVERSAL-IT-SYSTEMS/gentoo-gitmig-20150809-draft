# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/sel/sel-0.08.2.ebuild,v 1.5 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for shell scripts"
SRC_URI="http://www.rhein-neckar.de/~darkstar/files/${P}.tar.gz"
HOMEPAGE="http://www.rhein-neckar.de/~darkstar/sel.html"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1"

src_unpack () {
	unpack ${A}
	cd ${S}

	cp Makefile Makefile.orig
	sed -e "s:-m486:${CFLAGS}:" -e "s:-O3::" Makefile.orig > Makefile

	cp sel.c sel.c.orig
	sed -e "s:/usr/local/share/sel/help\.txt:/usr/share/sel/help\.txt:" \
       	    sel.c.orig > sel.c
}

src_compile() {
	make || die
}

src_install () {
	dobin sel
	doman sel.1
	insinto /usr/share/sel
	doins help.txt
	dodoc Changelog LICENSE
}
