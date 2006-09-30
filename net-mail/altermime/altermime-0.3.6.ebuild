# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/altermime/altermime-0.3.6.ebuild,v 1.2 2006/09/30 01:31:17 robbat2 Exp $

inherit toolchain-funcs

DESCRIPTION=" alterMIME is a small program which is used to alter your mime-encoded mailpacks"
SRC_URI="http://www.pldaniels.com/altermime/${P}.tar.gz"
HOMEPAGE="http://pldaniels.com/altermime/"

LICENSE="Sendmail"
KEYWORDS="~x86 ~s390 ~amd64 ~ppc"
IUSE=""
SLOT="0"

src_unpack() {
	unpack ${A}
	sed -i -e "/^CFLAGS[[:space:]]*=/ s/-O2/${CFLAGS}/" ${S}/Makefile || die "sed failed."
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed."
}

src_install () {
	dobin altermime || die "dobin failed."
	dodoc CHANGELOG INSTALL LICENCE README || die "dodoc failed."
}
