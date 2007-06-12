# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-volman/thunar-volman-0.1.2.ebuild,v 1.15 2007/06/12 19:26:19 drac Exp $

inherit eutils xfce44

xfce44

DESCRIPTION="Thunar volume management"
HOMEPAGE="http://foo-projects.org/~benny/projects/thunar-volman"
SRC_URI="http://download2.berlios.de/xfce-goodies/${P}.tar.bz2"

KEYWORDS="amd64 ~arm hppa ia64 ppc ppc64 sparc x86"

RDEPEND="dev-libs/dbus-glib
	sys-apps/hal
	>=xfce-extra/exo-0.3.2
	>=xfce-base/thunar-${THUNAR_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use xfce-extra/exo hal; then
		ewarn "Volume management requires exo with hal support. Enable"
		ewarn "hal USE flag and re-emerge exo."
		die "re-emerge exo with USE hal"
	fi
}

DOCS="AUTHORS ChangeLog NEWS README THANKS"
