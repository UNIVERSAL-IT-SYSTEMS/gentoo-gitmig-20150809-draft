# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbconf/bbconf-1.2.ebuild,v 1.2 2002/02/03 21:57:16 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="All-in-one blackbox configuration tool."
SRC_URI="http://${PN}.sourceforge.net/code/${P}.tar.gz"
HOMEPAGE="http://bbconf.sourceforge.net"

DEPEND="virtual/x11
        =x11-libs/qt-2*"

#RDEPEND=""

src_install () {
	make DESTDIR=${D} install || die
}
