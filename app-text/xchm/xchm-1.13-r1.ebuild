# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xchm/xchm-1.13-r1.ebuild,v 1.1 2008/05/19 13:14:26 pva Exp $

inherit eutils wxwidgets flag-o-matic fdo-mime gnome2-utils

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://xchm.sf.net"
SRC_URI="mirror://sourceforge/xchm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="nls unicode"
DEPEND=">=dev-libs/chmlib-0.36
	=x11-libs/wxGTK-2.6*"
# Tested to work against a local install of 2.8.3

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc-4.3.patch
}

src_compile() {
	local myconf
	export WX_GTK_VER="2.6"

	use unicode && need-wxwidgets unicode || need-wxwidgets ansi

	append-flags -fno-strict-aliasing

	myconf="${myconf} --with-wx-config=${WX_CONFIG}"

	econf ${myconf} \
		$(use_enable nls) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS README ChangeLog

	cp "${D}"/usr/share/pixmaps/xchm-32.xpm "${D}"/usr/share/pixmaps/xchm.xpm
	rm -f "${D}"/usr/share/pixmaps/xchm-*.xpm
	rm -f "${D}"/usr/share/pixmaps/xchmdoc*.xpm

	insinto /usr/share/applications
	doins "${FILESDIR}"/xchm.desktop
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/xchm.xml
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
