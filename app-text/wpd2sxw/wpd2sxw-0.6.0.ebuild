# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wpd2sxw/wpd2sxw-0.6.0.ebuild,v 1.5 2004/06/24 22:55:46 agriffis Exp $

DESCRIPTION="WordPerfect Document (wpd) to OpenOffice.org (sxw) converter"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/libwpd/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="gnome-extra/libgsf
	>=app-text/libwpd-0.7.1"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
}
