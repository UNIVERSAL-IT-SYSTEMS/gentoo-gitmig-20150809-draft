# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lfpfonts-fix/lfpfonts-fix-0.82.ebuild,v 1.3 2002/07/11 06:30:57 drobbins Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Linux Font Project fixed-width fonts"
SRC_URI="http://dreamer.nitro.dk/linux/lfp/${P}.tar.bz2"
HOMEPAGE="http://dreamer.nitro.dk/linux/lfp/"
LICENSE="Public Domain"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/x11"

src_install() {
	dodoc doc/*
	cd lfp-fix
	insinto /usr/X11R6/lib/X11/fonts/lfp-fix
	insopts -m0644
	doins *
}
