# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pouetchess/pouetchess-0.2.0.ebuild,v 1.4 2007/03/12 13:51:29 genone Exp $

inherit eutils toolchain-funcs games

MY_PN=${PN/c/C}
DESCRIPTION="3D and open source chess game"
HOMEPAGE="http://pouetchess.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_src_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug"

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-util/scons"

S=${WORKDIR}/${PN}_src_${PV}

pkg_setup() {
	games_pkg_setup
	elog "If you experience problems building pouetchess with nvidia drivers,"
	elog "you can try:"
	elog "eselect opengl set xorg-x11"
	elog "emerge pouetchess"
	elog "eselect opengl set nvidia"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-sconstruct-sandbox.patch \
		"${FILESDIR}"/${P}-nvidia_glext.patch

	# Fix for LibSDL >= 1.2.10 detection
	sed -i \
		-e "s:sdlver.split('.') >= \['1','2','8'\]:sdlver.split('.') >= [1,2,8]:" \
		pouetChess.py \
		|| die "sed failed"
}

src_compile() {
	tc-export CC CXX
	scons configure \
		strip=false \
		prefix="${GAMES_PREFIX}" \
		datadir="${GAMES_DATADIR}"/${PN} \
		$(use debug && echo debug=1) \
		|| die "scons configure failed"
	scons || die "scons failed"
}

src_install() {
	dogamesbin bin/${MY_PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"

	dodoc ChangeLog README

	doicon data/icons/${MY_PN}.png
	make_desktop_entry ${MY_PN} ${MY_PN} ${MY_PN}.png "KDE;Qt;Game;BoardGame"

	prepgamesdirs
}
