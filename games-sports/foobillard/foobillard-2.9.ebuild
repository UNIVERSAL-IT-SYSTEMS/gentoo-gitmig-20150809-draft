# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/foobillard/foobillard-2.9.ebuild,v 1.5 2004/06/24 23:24:19 agriffis Exp $

inherit games

DESCRIPTION="8ball, 9ball, snooker and carambol game"
HOMEPAGE="http://foobillard.sunsite.dk/"
SRC_URI="http://foobillard.sunsite.dk/dnl/${P}.tar.gz"

KEYWORDS="x86 ppc amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="sdl"

DEPEND="virtual/x11
	virtual/opengl
	>=media-libs/freetype-2.0.9
	>=media-libs/libpng-1.2.1
	|| (
		sdl? ( media-libs/libsdl )
		(
			virtual/glu
			virtual/glut )
	)"

src_compile() {
	local myconf=""
	[ "$(ls /usr/include/GL/gl.h -al | awk '{print $NF}' | cut -d/ -f5)" == "nvidia" ] \
		&& myconf="--enable-nvidia" \
		|| myconf="--disable-nvidia"
	myconf="${myconf} $(use_enable sdl SDL)"
	use sdl \
		&& myconf="${myconf} --disable-glut" \
		|| myconf="${myconf} --enable-glut"

	egamesconf \
		--enable-sound \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README README.FONTS AUTHORS NEWS ChangeLog
	prepgamesdirs
}
