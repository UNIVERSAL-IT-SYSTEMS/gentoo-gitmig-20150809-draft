# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Christophe Vanfleteren <c.vanfleteren@pandora.be>
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlgui/sqlgui-0.3.3.ebuild,v 1.1 2002/05/11 13:49:24 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

newdepend ">=dev-db/mysql-3.23.38 >=kde-base/kdebase-3"

DESCRIPTION="This KDE 3 program lets you administer a mysql db"
SRC_URI="http://www.sqlgui.de/download/${P}.tar.gz"
HOMEPAGE="http://www.sqlgui.de/"

myconf="$myconf --with-extra-includes=/usr/include/mysql"

