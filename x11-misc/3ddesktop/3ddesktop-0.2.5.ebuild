# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header

DESCRIPTION="OpenGL virtual desktop switching"
HOMEPAGE="http://desk3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/desk3d/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/x11
		media-libs/imlib2
		x11-base/opengl-update"

src_compile() {
	econf || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc README AUTHORS COPYING TODO ChangeLog README.windowmanagers

}
