# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbdate/bbdate-0.2.4.ebuild,v 1.10 2008/09/17 19:18:01 coldwind Exp $

DESCRIPTION="blackbox date display"
HOMEPAGE="http://bbtools.windsofstorm.net/available.phtml"
SRC_URI="http://bbtools.windsofstorm.net/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/blackbox"

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS BUGS INSTALL ChangeLog TODO

	# since multiple bbtools packages provide this file, install
	# it in /usr/share/doc/${PF}
	mv "${D}"/usr/share/bbtools/bbtoolsrc.in \
		"${D}"/usr/share/doc/${PF}/bbtoolsrc.example
}
