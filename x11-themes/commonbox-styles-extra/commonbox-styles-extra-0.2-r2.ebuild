# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/commonbox-styles-extra/commonbox-styles-extra-0.2-r2.ebuild,v 1.5 2006/11/05 00:06:01 opfer Exp $

IUSE=""
DESCRIPTION="Extra styles pack for flux|black|open(box)."
SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://mkeadle.org/distfiles/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ~hppa ~ia64 ppc ~ppc-macos ~ppc64 sparc x86"

# xv is there so *box can convert backgrounds/textures to use
DEPEND=""
RDEPEND="media-gfx/xv
		|| ( x11-wm/fluxbox x11-wm/blackbox x11-wm/openbox )"

src_install () {
	insinto /usr/share/commonbox/styles
	doins ${S}/styles/*

	insinto /usr/share/commonbox/backgrounds
	doins ${S}/backgrounds/*

	dodoc README.commonbox-styles-extra
}
