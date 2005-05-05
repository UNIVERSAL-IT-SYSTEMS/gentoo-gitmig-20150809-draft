# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/cairo/cairo-0.1.18-r1.ebuild,v 1.7 2005/05/05 23:19:47 latexer Exp $

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE=""
DEPEND="virtual/x11
	virtual/xft
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/libpixman"

src_compile() {
	PKG_CONFIG_PATH=${PKG_CONFIG_PATH+$PKG_CONFIG_PATH:}${FILESDIR} econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
}
