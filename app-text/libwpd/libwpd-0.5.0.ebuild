# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpd/libwpd-0.5.0.ebuild,v 1.4 2004/06/24 22:43:16 agriffis Exp $

DESCRIPTION="WordPerfect Document import/export library"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=gnome-extra/libgsf-1.6"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {

	econf || die
	emake || die

}

src_install() {

	einstall || die

	dodoc CHANGES COPYING CREDITS INSTALL README TODO

}

