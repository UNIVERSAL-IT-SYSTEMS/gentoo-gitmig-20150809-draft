# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/nvi/nvi-1.81.4.ebuild,v 1.6 2002/08/14 18:32:05 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Vi clone"
SRC_URI="http://www.kotnet.org/~skimo/nvi/devel/${P}.tar.gz"
HOMEPAGE="http://www.kotnet.org/~skimo/nvi"
DEPEND=">=sys-libs/db-3.1"
RDEPEND=""

SLOT="0"
LICENSE="Sleepycat"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {
	cd build.unix
	../dist/configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	cd ${S}/build.unix
	make prefix=${D}/usr install || die
}
