# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/blight-glN64/blight-glN64-0.3.1.ebuild,v 1.2 2003/09/27 04:02:55 mr_bones_ Exp $

inherit games

S=${WORKDIR}
MY_P="glNintendo64-${PV}"
DESCRIPTION="An OpenGL graphics plugin for the mupen64 N64 emulator"
SRC_URI="http://deltaanime.ath.cx/~blight/n64/blight_glN64_port/${MY_P}.so"
HOMEPAGE="http://deltaanime.ath.cx/~blight/n64/"

KEYWORDS="x86"
LICENSE="as-is"
SLOT="0"
IUSE=""

RDEPEND="media-libs/libsdl"

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR} || die "cp failed"
}

src_install () {
	exeinto ${GAMES_LIBDIR}/mupen64/plugins
	doexe ${MY_P}.so || die "doexe failed"
	prepgamesdirs
}
