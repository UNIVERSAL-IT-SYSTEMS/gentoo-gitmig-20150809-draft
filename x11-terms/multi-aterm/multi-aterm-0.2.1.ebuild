# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/multi-aterm/multi-aterm-0.2.1.ebuild,v 1.7 2005/09/17 10:11:43 agriffis Exp $

inherit eutils

DESCRIPTION="A terminal emulator with transparency support as well as rxvt backwards compatibility like aterm, with tab support"
HOMEPAGE="http://www.nongnu.org/materm/materm.html"
SRC_URI="http://www.nongnu.org/materm/${P}.tar.gz"

IUSE="cjk debug jpeg png"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"

RDEPEND="virtual/x11
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-initialize-vars.patch
}

src_compile() {
	econf \
		--enable-transparency \
		--enable-fading \
		--enable-xterm-scroll \
		--enable-half-shadow \
		--enable-graphics \
		--enable-mousewheel \
		--with-x \
		$(use_enable cjk kanji) \
		$(use_enable debug) \
		$(use_enable jpeg) \
		$(use_enable png) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"
	dodoc NEWS ChangeLog doc/TODO || die "dodoc failed"
}
