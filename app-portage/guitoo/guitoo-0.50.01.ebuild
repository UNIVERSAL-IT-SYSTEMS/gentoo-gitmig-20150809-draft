# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/guitoo/guitoo-0.50.01.ebuild,v 1.2 2004/11/29 01:02:03 pylon Exp $

inherit kde

DESCRIPTION="A KDE Portage frontend"
HOMEPAGE="http://guitoo.sourceforge.net"
SRC_URI="mirror://sourceforge/guitoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="${DEPEND}
	app-admin/sudo"

need-kde 3.2
need-qt 3.3.2
