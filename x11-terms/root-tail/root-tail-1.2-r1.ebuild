# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/root-tail/root-tail-1.2-r1.ebuild,v 1.2 2005/02/19 08:13:03 corsair Exp $

DESCRIPTION="Terminal to display (multiple) log files on the root window"
HOMEPAGE="http://www.goof.com/pcg/marc/root-tail.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc ppc64"
IUSE=""

DEPEND="virtual/x11
	>=sys-apps/sed-4"

src_compile() {
	xmkmf -a
	sed -i 's|/usr/X11R6/bin|/usr/bin|' Makefile || die "sed Makefile failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install install.man || die "make install failed"
	dodoc Changes README
}
