# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bdelta/bdelta-0.1.0.ebuild,v 1.1 2005/05/09 19:48:12 genstef Exp $

DESCRIPTION="Binary Delta - Efficient difference algorithm and format"
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/deltup/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

src_install () {
	dodir /usr/lib
	make DESTDIR=${D} install || die "make install failed"
	dodoc README
}
