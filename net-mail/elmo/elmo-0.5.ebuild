# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/elmo/elmo-0.5.ebuild,v 1.2 2003/07/13 13:32:32 aliz Exp $

DESCRIPTION="Elmo: console email client"
HOMEPAGE="http://elmo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README THANKS TODO
	einfo "from BUGS:"
	einfo "* mbox"
	einfo "Reading file in mbox format may NOT work.  If you try to use it,"
	einfo "it may crash.  I don't support this format any more.  But feel free"
	einfo "to fix it."

}
