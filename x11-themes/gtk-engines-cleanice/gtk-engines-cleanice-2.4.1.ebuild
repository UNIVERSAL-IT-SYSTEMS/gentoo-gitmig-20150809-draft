# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-cleanice/gtk-engines-cleanice-2.4.1.ebuild,v 1.6 2009/01/21 20:14:42 jer Exp $

DESCRIPTION="GTK+ CleanIce Theme Engine"
HOMEPAGE="http://sourceforge.net/projects/elysium-project"
SRC_URI="mirror://sourceforge/elysium-project/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	insinto /usr/share/themes/CleanIce/gtk-2.0
	newins "${FILESDIR}"/cleanice-2-gtkrc gtkrc || die "newins failed."
	dodoc AUTHORS ChangeLog README
}
