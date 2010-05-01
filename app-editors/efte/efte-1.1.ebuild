# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/efte/efte-1.1.ebuild,v 1.1 2010/05/01 22:56:10 hanno Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="A fast text editor supporting folding, syntax highlighting, etc."
HOMEPAGE="http://efte.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gpm X"

RDEPEND="sys-libs/ncurses
	gpm? ( sys-libs/gpm )
	X? (
		x11-libs/libXpm
		x11-libs/libXdmcp
		x11-libs/libXau
		media-fonts/font-misc-misc
	)"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_build gpm)
		$(cmake-utils_use_build X)"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm "${D}/usr/share/doc/${PN}/COPYING"
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}"
	prepalldocs
}
