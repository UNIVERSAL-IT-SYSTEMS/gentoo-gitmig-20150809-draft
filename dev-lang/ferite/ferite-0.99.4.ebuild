# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ferite/ferite-0.99.4.ebuild,v 1.7 2002/10/20 18:41:38 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="ferite is a scripting engine and language written in c for complete portability."

SRC_URI="http://telia.dl.sourceforge.net/sourceforge/ferite/${P}.tar.gz"
HOMEPAGE="http://www.ferite.org/"

DEPEND="virtual/glibc
		dev-libs/libpcre
		dev-libs/libxml2"

SLOT="1"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	./configure --host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man || die

	emake || die
}

src_install() {
	make prefix=${D}/usr \
		 infodir=${D}/usr/share/info \
		 mandir=${D}/usr/share/man \
		 install || die
	
	dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS

	dohtml -r docs
}
