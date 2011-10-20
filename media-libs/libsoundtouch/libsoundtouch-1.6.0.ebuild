# Copyright 1999-2011 Gentoo FoundationOU
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsoundtouch/libsoundtouch-1.6.0.ebuild,v 1.3 2011/10/20 15:54:51 ssuominen Exp $

EAPI=4
inherit autotools-utils eutils flag-o-matic

MY_PN=${PN/lib}

DESCRIPTION="Audio processing library for changing tempo, pitch and playback rates."
HOMEPAGE="http://www.surina.net/soundtouch/"
SRC_URI="http://www.surina.net/soundtouch/${P/lib}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="sse2 static-libs"

S=${WORKDIR}/${MY_PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
	sed -i -e "s:^\(pkgdoc_DATA=\)COPYING.TXT :\1:" Makefile.am || die
	eautoreconf

	if use sse2; then
		append-flags -msse2
	else
		sed -i -e '/^.*#define ALLOW_X86_OPTIMIZATIONS.*$/d' \
			include/STTypes.h || die
	fi
}

src_configure() {
	econf \
		--enable-shared \
		--disable-integer-samples \
		$(use_enable static-libs static)
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	emake DESTDIR="${ED}" pkgdocdir="${EPREFIX}/usr/share/doc/${PF}/html" install
	remove_libtool_files all
}
