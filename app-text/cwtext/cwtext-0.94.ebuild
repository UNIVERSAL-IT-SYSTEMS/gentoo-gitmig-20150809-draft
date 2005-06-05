# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cwtext/cwtext-0.94.ebuild,v 1.8 2005/06/05 12:00:44 hansmi Exp $

DESCRIPTION="Text to Morse Code converter"
HOMEPAGE="http://cwtext.sourceforge.net"
SRC_URI="mirror://sourceforge/cwtext/${P}.tar.gz"

KEYWORDS="~amd64 ~mips ppc ~sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# change install directory to ${S}
	sed -i -e "/^PREFIX/ s:=.*:=\"${S}\":" makefile || \
		die "sed makefile failed"
}

src_compile() {
	make install || die
}

src_install() {
	dobin cwtext cwpcm cwmm

	dodoc COPYING Changes README TODO
}
