# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/pdmenu/pdmenu-1.2.95.ebuild,v 1.5 2012/07/08 15:17:57 jer Exp $

EAPI=4

inherit eutils

DESCRIPTION="A simple console menu program"
HOMEPAGE="http://joeyh.name/code/pdmenu/"
SRC_URI="mirror://debian/pool/main/p/pdmenu/pdmenu_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~mips x86"
IUSE="nls gpm examples"

DEPEND="
	sys-libs/slang
	gpm? ( sys-libs/gpm )
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

RESTRICT="test"

src_prepare() {
	sed \
		-e 's:\(-o pdmenu\):$(LDFLAGS) \1:g' \
		-i Makefile || die
}

src_configure() {
	econf \
		$(use_with gpm) \
		$(use_enable nls)
}

src_install() {
	dobin pdmenu

	dodoc doc/ANNOUNCE doc/BUGS doc/TODO

	use examples && doins -r examples

	mv doc/pdmenu.man doc/pdmenu.1
	mv doc/pdmenurc.man doc/pdmenurc.5
	doman doc/pdmenu.1 doc/pdmenurc.5

}

pkg_postinst() {
	ewarn "Note this part from man page: Security warning! Any exec command"
	ewarn "that uses the 'edit' flag will be a security hole. The user need"
	ewarn "only to enter text with a ';' in it, and they can run an"
	ewarn "arbitrary command after the semicolon!"
}
