# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okteta/okteta-4.4.5.ebuild,v 1.1 2010/06/30 15:37:02 alexxy Exp $

EAPI="3"

KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE hexeditor"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"

# Tests hang, last checked in 4.3.3
RESTRICT="test"
