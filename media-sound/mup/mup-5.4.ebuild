# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mup/mup-5.4.ebuild,v 1.5 2009/06/07 21:22:54 maekke Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Program for printing music scores"
HOMEPAGE="http://www.arkkra.com/"
SRC_URI="ftp://ftp.arkkra.com/pub/unix/mup${PV//.}src.tar.gz"

LICENSE="Arkkra"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/fltk:1.1
	x11-libs/libXpm
	media-libs/jpeg
	media-libs/libpng"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" \
		CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc docs/{*.txt,README0}
	dohtml docs/{*.html,uguide/*}
	docinto sample
	dodoc docs/{*.mup,*.ps}
}
