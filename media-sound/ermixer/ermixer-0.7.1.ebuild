# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ermixer/ermixer-0.7.1.ebuild,v 1.6 2004/04/20 17:19:52 eradicator Exp $

IUSE=""

DESCRIPTION="A full featured console-based audio mixer."
HOMEPAGE="http://ermixer.sourceforge.net"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
KEYWORDS="x86"

SRC_URI="mirror://sourceforge/ermixer/${P}.tar.gz"
RESTRICT="nomirror"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
