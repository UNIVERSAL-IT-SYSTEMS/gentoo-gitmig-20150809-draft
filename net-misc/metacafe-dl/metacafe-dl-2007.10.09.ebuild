# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/metacafe-dl/metacafe-dl-2007.10.09.ebuild,v 1.4 2008/05/01 14:05:27 coldwind Exp $

DESCRIPTION="A small command-line program to download videos from Metacafe."
HOMEPAGE="http://www.arrakis.es/~rggi3/metacafe-dl/"
SRC_URI="http://www.arrakis.es/~rggi3/${PN}/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_unpack() {
	:
}

src_install() {
	dobin "${DISTDIR}/${P}"
	dosym "${P}" "/usr/bin/${PN}"
}
