# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg2/libmpeg2-0.4.1.ebuild,v 1.3 2006/11/26 13:37:15 aballier Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"
inherit eutils flag-o-matic autotools libtool

MY_P="mpeg2dec-${PV}"
DESCRIPTION="library for decoding mpeg-2 and mpeg-1 video"
HOMEPAGE="http://libmpeg2.sourceforge.net/"
SRC_URI="http://libmpeg2.sourceforge.net/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="sdl X"

DEPEND="sdl? ( media-libs/libsdl )
	X? (
		x11-libs/libXv
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXt
		x11-proto/xextproto
	)"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	use alpha && append-flags -fPIC

	# get rid of the -mcpu
	sed -i \
		-e '/-mcpu/d' \
		configure.in \
		|| die "sed configure failed"

	# Fix problem that the test for external symbols
	# uses nm which also displays hidden symbols. Bug #130831
	epatch "${FILESDIR}/${P}-use-readelf-for-test.patch"

	eautoreconf
	elibtoolize
}

src_compile() {
	econf \
		--enable-shared \
		--disable-dependency-tracking \
		$(use_enable sdl) \
		$(use_with X x) \
		${myconf} \
		|| die
	# builds non-pic library by default? (bug #44934)
	emake OPT_CFLAGS="${CFLAGS}" MPEG2DEC_CFLAGS="${CFLAGS}" LIBMPEG2_CFLAGS= || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
