# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/sux/sux-1.0-r2.ebuild,v 1.4 2005/07/25 15:10:10 blubb Exp $

inherit eutils

DESCRIPTION="\"su\" wrapper which transfers X credentials"
HOMEPAGE="http://fgouget.free.fr/sux/sux-readme.shtml"
SRC_URI="http://fgouget.free.fr/sux/sux"
LICENSE="X11"
SLOT="0"

KEYWORDS="amd64 ~ppc x86"
IUSE=""
S=${WORKDIR}

DEPEND="virtual/x11
		sys-apps/debianutils"

src_unpack() {
	cp ${DISTDIR}/${A} .
	epatch ${FILESDIR}/${P}-r1.patch
}

src_compile() {
	echo "nothing to be done"
}

src_install() {
	exeinto /usr/bin
	doexe sux
}
