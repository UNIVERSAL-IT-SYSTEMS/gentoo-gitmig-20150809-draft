# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kxdocker-dcop/kxdocker-dcop-1.0.0-r1.ebuild,v 1.1 2006/04/22 03:43:11 dragonheart Exp $

inherit kde

DESCRIPTION="KXDocker dcop plugin for KXDocker (the KDE animated docker)"
HOMEPAGE="http://www.xiaprojects.com/www/prodotti/kxdocker/main.php"
SRC_URI="http://www.xiaprojects.com/www/downloads/files/kxdocker/1.0.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-misc/kxdocker-1.0.0a"

need-kde 3.2
