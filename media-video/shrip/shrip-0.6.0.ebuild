# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/shrip/shrip-0.6.0.ebuild,v 1.1 2010/04/26 19:20:11 ssuominen Exp $

EAPI=2

DESCRIPTION="Command line tool for ripping DVDs and encoding to AVI/OGM/MKV/MP4"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2.14:2
	>=media-video/ogmrip-0.13.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e '/CFLAGS/s:-Werror::' \
		configure || die
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO

	insinto /etc
	doins shrip.conf || die
}
