# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/hcalc/hcalc-1.2.ebuild,v 1.1 2012/07/07 15:22:53 jlec Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="DJ's Hex Calculator"
HOMEPAGE="http://www.delorie.com/store/hcalc/ https://github.com/jlec/hcalc"
SRC_URI="mirror://github/jlec/hcalc/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	x11-libs/libX11
	x11-libs/libXpm"
DEPEND="${RDEPEND}"

pkg_postinst() {
	einfo "Enter hcalc to run and use kill or ctrl-c to exit."
}
