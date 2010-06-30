# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-meta/kdeadmin-meta-4.4.5.ebuild,v 1.1 2010/06/30 15:36:27 alexxy Exp $

EAPI="3"
inherit kde4-functions

DESCRIPTION="KDE administration tools - merge this to pull in all kdeadmin-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="4.4"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="aqua cups kdeprefix"

RDEPEND="
	$(add_kdebase_dep kcron)
	$(add_kdebase_dep knetworkconf)
	$(add_kdebase_dep ksystemlog)
	$(add_kdebase_dep kuser)
	cups? ( $(add_kdebase_dep system-config-printer-kde) )
	$(block_other_slots)
"

## The following package was just added and has a questionable interest to Gentoo
#	>=kde-base/kpackage-${PV}:${SLOT}

## the following packages are currently missing in kde 4.1
#>=kde-base/kdeadmin-kfile-plugins-${PV}:${SLOT}
#>=kde-base/secpolicy-${PV}:${SLOT}
