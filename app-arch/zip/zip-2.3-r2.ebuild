# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/zip/zip-2.3-r2.ebuild,v 1.2 2003/07/18 15:29:02 mholzer Exp $

IUSE="crypt"

DESCRIPTION="Info ZIP (encryption support)"
SRC_URI="http://www.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/${PN}23.tar.gz
	crypt? ( ftp://ftp.icce.rug.nl/infozip/src/zcrypt29.zip )"
HOMEPAGE="ftp://ftp.freesoftware.com/pub/infozip/Zip.html"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="Info-ZIP"

DEPEND="crypt? ( app-arch/unzip )"

src_unpack() {
	unpack ${A}
	if [ "`use crypt`" ]; then
		mv -f crypt.h ${S}
		mv -f crypt.c ${S}
	fi
	cd ${S}/unix
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	make -f unix/Makefile generic_gcc || die
}

src_install() {
	dobin zip zipcloak zipnote zipsplit
	doman man/zip.1
	dodoc BUGS CHANGES LICENSE MANUAL README TODO WHATSNEW WHERE
}

