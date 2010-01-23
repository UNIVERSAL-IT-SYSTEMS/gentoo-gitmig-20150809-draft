# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nautilus-python/nautilus-python-0.6.1.ebuild,v 1.1 2010/01/23 19:01:09 pva Exp $

EAPI="2"

inherit gnome.org eutils

DESCRIPTION="Python bindings for the Nautilus file manager"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pygtk-2.8
	>=dev-python/gnome-python-2.12
	>=gnome-base/nautilus-2.6
	>=gnome-base/eel-2.6"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/usr/share/doc/{${PN},${PF}}
	dodoc AUTHORS ChangeLog NEWS || die
}
