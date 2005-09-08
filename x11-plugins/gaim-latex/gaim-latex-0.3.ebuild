# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-latex/gaim-latex-0.3.ebuild,v 1.3 2005/09/08 10:03:47 blubb Exp $

inherit flag-o-matic multilib

DESCRIPTION="Gaim plugin that renders latex formulae"
HOMEPAGE="http://sourceforge.net/projects/gaim-latex"
SRC_URI="mirror://sourceforge/gaim-latex/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-im/gaim"
RDEPEND="virtual/tetex
		media-gfx/imagemagick"

src_compile()
{
	append-flags -fPIC
	emake || die "emake failed"
}

src_install()
{
	make LIB_INSTALL_DIR="${D}/usr/$(get_libdir)" install PREFIX=${D}/usr \
	|| die "make install failed"
	dodoc README CHANGELOG COPYING TODO
}
