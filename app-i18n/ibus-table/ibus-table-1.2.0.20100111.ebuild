# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-table/ibus-table-1.2.0.20100111.ebuild,v 1.4 2010/05/26 10:42:16 pacho Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="sqlite"
inherit python

DESCRIPTION="The Table Engine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=app-i18n/ibus-1.2
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.16.1 )
	dev-util/pkgconfig"

src_prepare() {
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf $(use_enable nls) --disable-additional || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}/engine
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}/engine
}
