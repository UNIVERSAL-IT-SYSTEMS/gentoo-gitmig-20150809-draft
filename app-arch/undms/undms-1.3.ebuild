# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/undms/undms-1.3.ebuild,v 1.1 2004/09/11 12:29:51 dholm Exp $

inherit eutils

DESCRIPTION="Decompress Amiga DMS disk images to ADF"
SRC_URI="ftp://us.aminet.net/pub/aminet/misc/unix/${P}.c.Z ftp://us.aminet.net/pub/aminet/misc/unix/${P}.c.Z.readme"
HOMEPAGE="ftp://us.aminet.net/pub/aminet/misc/unix/${P}.c.Z.readme"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_unpack() {
	mkdir ${S}
	uncompress -dc ${DISTDIR}/${P}.c.Z > ${S}/undms.c
	cp ${DISTDIR}/${P}.c.Z.readme  ${S}/${P}.c.Z.readme
}

src_compile() {
	gcc ${CFLAGS} -o undms undms.c || die "Compilation failed"
}

src_install() {
	dobin undms
	dodoc ${P}.c.Z.readme
}
