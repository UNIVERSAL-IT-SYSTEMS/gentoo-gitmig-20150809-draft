# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glark/glark-1.6.4.ebuild,v 1.6 2004/06/24 22:36:48 agriffis Exp $

DESCRIPTION="File searcher"
HOMEPAGE="http://glark.sf.net"
SRC_URI="mirror://sourceforge/glark/${P}.tar.gz"

KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="virtual/ruby"

src_compile() {
	emake || die
}

src_install () {
	dobin glark
	doman glark.1
}
