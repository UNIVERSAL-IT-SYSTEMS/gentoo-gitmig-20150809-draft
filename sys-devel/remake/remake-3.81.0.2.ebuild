# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/remake/remake-3.81.0.2.ebuild,v 1.3 2009/03/15 19:06:04 armin76 Exp $

MY_P="${PN}-${PV:0:4}+dbg-${PV:5}"

DESCRIPTION="patched version of GNU make that adds improved error reporting, tracing, and a debugger"
HOMEPAGE="http://bashdb.sourceforge.net/remake/"
SRC_URI="mirror://sourceforge/bashdb/${MY_P}.tar.bz2"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS INSTALL NEWS README
	# fix collide with the real make's info pages
	rm -f "${D}"/usr/share/info/make.*
}
