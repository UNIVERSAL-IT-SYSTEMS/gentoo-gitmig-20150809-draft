# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsidplay/libsidplay-1.36.57.ebuild,v 1.11 2004/07/03 07:17:00 squinky86 Exp $

inherit eutils

IUSE=""
DESCRIPTION="C64 SID player library"
HOMEPAGE="http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/linux.html"
SRC_URI="http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/packages/${P}.tgz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 sparc alpha hppa ia64 ~ppc"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libsidplay-gcc34.patch
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING DEVELOPER INSTALL
}
