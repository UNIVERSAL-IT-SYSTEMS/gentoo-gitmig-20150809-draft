# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmappl/wmappl-0.6.ebuild,v 1.5 2002/07/11 06:30:57 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Simple application launcher for the Window Maker dock."
SRC_URI="http://www.upl.cs.wisc.edu/~charkins/wmappl/${P}.tar.gz"
HOMEPAGE="http://www.pobox.com/~charkins/wmappl.html"
DEPEND="x11-base/xfree virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	emake || die
}

src_install () {
	dobin wmappl
	dodoc README LICENSE CHANGELOG sample.wmapplrc
	insinto /usr/share/icons/wmappl
	doins icons/*
}
