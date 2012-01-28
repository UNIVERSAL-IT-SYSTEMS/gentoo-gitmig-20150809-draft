# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mplus-outline-fonts/mplus-outline-fonts-0_pre046.ebuild,v 1.1 2012/01/28 15:33:10 matsuu Exp $

EAPI="3"
inherit font

MY_P="mplus-${PV/0_pre/TESTFLIGHT-}"
DESCRIPTION="M+ Japanese outline fonts"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/ http://ossipedia.ipa.go.jp/ipafont/"
SRC_URI="mirror://sourceforge.jp/mplus-fonts/6650/${MY_P}.tar.xz"

LICENSE="mplus-fonts ipafont? ( IPAfont )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~x86 ~ppc-macos ~x86-macos"
IUSE="ipafont"

DEPEND="ipafont? (
		media-gfx/fontforge
		>=media-fonts/ja-ipafonts-003.02
	)"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="README_J README_E"

RESTRICT="strip binchecks"

IPAFONT_DIR="${EPREFIX}/usr/share/fonts/ja-ipafonts"

src_prepare() {
	if use ipafont ; then
		cp -p "${IPAFONT_DIR}/ipag.ttf" "${S}" || die
	fi
}

src_compile() {
	if use ipafont ; then
		fontforge -script m++ipa.pe || die
		rm -f ipag.ttf || die
	fi
}
