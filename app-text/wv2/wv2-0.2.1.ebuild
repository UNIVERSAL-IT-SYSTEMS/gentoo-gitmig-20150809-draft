# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv2/wv2-0.2.1.ebuild,v 1.4 2004/06/24 22:56:18 agriffis Exp $

DESCRIPTION="Excellent MS Word filter lib, used in most Office suites"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.bz2"
HOMEPAGE="http://wvware.sourceforge.net/"

KEYWORDS="~x86 ~amd64 ppc sparc ~alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=gnome-extra/libgsf-1.8.0
	>=media-libs/freetype-2.1
	sys-libs/zlib
	media-libs/libpng"

RDEPEND="${DEPEND}
	media-gfx/imagemagick"

src_install() {
	einstall || die
}
