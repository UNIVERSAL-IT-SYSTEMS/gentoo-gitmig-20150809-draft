# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vls/vls-0.5.6-r1.ebuild,v 1.4 2004/06/25 00:52:39 agriffis Exp $

IUSE="debug dvd dvb"

DESCRIPTION="The VideoLAN server"
HOMEPAGE="http://www.videolan.org/vls/"
SRC_URI="http://www.videolan.org/pub/videolan/vls/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="dvd? ( >=media-libs/libdvdread-0.9.4
	>=media-libs/libdvdcss-1.2.8 )
	dvb? ( >=media-libs/libdvbpsi-0.1.3 )"

src_compile() {
	local myconf
	use debug || myconf="--disable-debug"

	use dvd || myconf="${myconf} --disable-dvd"

	use dvb && myconf="${myconf} --enable-dvb"

	econf ${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"

	dodoc AUTHORS INSTALL README TODO
}
