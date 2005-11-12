# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-jack/xmms-jack-0.15.ebuild,v 1.1 2005/11/12 17:25:05 metalgod Exp $

IUSE="bmp"

inherit eutils

S="${WORKDIR}/${PN}"

DESCRIPTION="a jack audio output plugin for XMMS"
HOMEPAGE="http://xmms-jack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~ppc64"

RDEPEND="media-sound/xmms
	bmp? ( media-sound/beep-media-player )
	>=media-libs/bio2jack-0.4
	media-sound/jack-audio-connection-kit"

DEPEND="${RDEPEND}
	=sys-devel/automake-1.8*
	=sys-devel/autoconf-2.5*"

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/${PN}-0.11-sysbio2jack.patch
	#quick endianess fix
	sed -i -e "s:FMT_S16_LE:FMT_S16_NE:g" jack.c
	export WANT_AUTOMAKE=1.8
	export WANT_AUTOCONF=2.5
	aclocal
	libtoolize --copy --force
	autoheader
	automake -a -c -f
	autoconf
}

src_compile() {
	econf --disable-static || die
	emake || die

	if use bmp;
		then
		emake -f Makefile.BMP
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	if use bmp;
		then
		make -f Makefile.BMP DESTDIR="${D}" install || die
	fi
	dodoc AUTHORS ChangeLog NEWS README
}
