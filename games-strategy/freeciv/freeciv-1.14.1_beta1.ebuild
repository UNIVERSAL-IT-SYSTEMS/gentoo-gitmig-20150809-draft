# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freeciv/freeciv-1.14.1_beta1.ebuild,v 1.1 2003/09/17 19:49:47 msterret Exp $

MY_P=${P/_/-}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="multiplayer strategy game (Civilization Clone)"
HOMEPAGE="http://www.freeciv.org/"
SRC_URI="ftp://ftp.freeciv.org/freeciv/beta/${MY_P}.tar.bz2"

KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"

IUSE="X Xaw3d gtk2 nls"

DEPEND="X? ( virtual/x11 )
		Xaw3d? ( x11-libs/Xaw3d )
		gtk? ( ~x11-libs/gtk+-1.2.10-r4
				>=media-libs/imlib-1.9.2
				>=media-libs/libogg-1.0
				>=media-libs/libvorbis-1.0-r2 )
		gtk2? ( >=x11-libs/gtk+-2.0.0
				>=dev-libs/atk-1.0.3
				>=x11-libs/pango-1.2.1-r1
				>=media-libs/libogg-1.0
				>=media-libs/libvorbis-1.0-r2 )"
RDEPEND="sys-libs/zlib"

src_compile() {
	local myconf

	myconf="${myconf} --enable-client=no"

	use X \
		&& myconf="${myconf} --enable-client=xaw --with-x"

	use Xaw3d \
		&& myconf="${myconf} --enable-client=xaw3d --disable-gtktest"

	use gtk \
		&& myconf="${myconf} --enable-client=gtk --enable-gtktest"

	use gtk2 \
		&& myconf="${myconf} --enable-client=gtk-2.0 --enable-gtktest"


	use nls \
		|| myconf="${myconf} --disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-zlib \
	${myconf} || die

	emake || die "emake failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		install	|| die "make install failed"

	use gtk	|| use gtk2 || /bin/install -D -m 644 \
		${S}/data/Freeciv \
		${D}/usr/X11R6/lib/X11/app-defaults/Freeciv

	dodoc ChangeLog INSTALL NEWS \
		doc/{BUGS,CodingStyle,HACKING,HOWTOPLAY,PEOPLE,README*,TODO}
}
