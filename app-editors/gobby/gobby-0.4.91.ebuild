# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gobby/gobby-0.4.91.ebuild,v 1.1 2009/04/08 19:56:27 dev-zero Exp $

EAPI="2"

inherit base eutils

DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0.5"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="avahi gnome"

RDEPEND="dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-libs/libsigc++:2
	>=net-libs/libinfinity-0.2[gtk,avahi?]
	dev-cpp/libxmlpp:2.6
	x11-libs/gtksourceview:2.0
	gnome? ( gnome-base/gnome-vfs )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# There's only one test and it needs X
RESTRICT="test"

src_configure() {
	econf $(use_with gnome)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	domenu contrib/gobby-0.5.desktop
}
