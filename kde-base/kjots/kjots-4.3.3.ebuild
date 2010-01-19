# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kjots/kjots-4.3.3.ebuild,v 1.6 2010/01/19 02:37:45 jer Exp $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Kjots - KDE note taking utility"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug +handbook"

DEPEND="
	$(add_kdebase_dep libkdepim)
"
RDEPEND="${DEPEND}"
