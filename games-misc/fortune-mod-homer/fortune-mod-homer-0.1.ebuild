# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/fortune-mod-homer/fortune-mod-homer-0.1.ebuild,v 1.7 2004/06/24 22:55:30 agriffis Exp $

DESCRIPTION="Quotes from Homer Simpson"
HOMEPAGE="http://www.cs.indiana.edu/~crcarter/homer/homer.html"
SRC_URI="http://www.cs.indiana.edu/~crcarter/homer/homer-quotes.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"
IUSE=""

RDEPEND="games-misc/fortune-mod"

S="${WORKDIR}/${PN/mod-/}"

src_install() {
	insinto /usr/share/fortune
	doins homer homer.dat
}
