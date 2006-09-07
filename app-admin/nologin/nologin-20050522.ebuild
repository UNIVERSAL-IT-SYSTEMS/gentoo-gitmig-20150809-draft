# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/nologin/nologin-20050522.ebuild,v 1.7 2006/09/07 19:36:31 dang Exp $

inherit toolchain-funcs

DESCRIPTION="OpenBSD's nologin - politely refuse a login; intended as a replacement shell field (in /etc/passwd) for accounts that have been disabled."
HOMEPAGE="http://www.openbsd.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~mips ppc x86"
IUSE=""

src_compile() {
	echo "$(tc-getCC) ${CFLAGS} nologin.c -o nologin"
	$(tc-getCC) ${CFLAGS} nologin.c -o nologin || die "compilation failed"
}

src_install() {
	doman nologin.8 || die "doman failed"
	into /
	dosbin nologin || die "dosbin failed"
}

pkg_postinst() {
	einfo
	einfo "To use nologin, edit /etc/passwd and replace /bin/false with"
	einfo "/sbin/nologin for those accounts."
	einfo
	einfo "If the file /etc/nologin.txt exists, nologin displays it's"
	einfo "contents instead of the default message."
	einfo
}
