# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mrtg/mrtg-2.9.22.ebuild,v 1.8 2004/06/30 17:35:28 vapier Exp $

DESCRIPTION="A tool to monitor the traffic load on network-links"
HOMEPAGE="http://ee-staff.ethz.ch/~oetiker/webtools/mrtg/"
SRC_URI="http://ee-staff.ethz.ch/~oetiker/webtools/mrtg/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha"
IUSE=""

DEPEND="virtual/libc
	dev-lang/perl
	>=media-libs/gd-1.8.3"
#	>=media-libs/libpng-1.2.1"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die
	dodir /usr/share/man
	mv ${D}/usr/man/man1 ${D}/usr/share/man
	rm -rf ${D}/usr/{man,doc}
	dodoc ANNOUNCE COPYING CHANGES COPYRIGHT MANIFEST README THANKS
	docinto txt ; dodoc doc/*.txt
	cp -a contrib ${D}/usr/share/doc/${PF}/contrib
	prepalldocs
	docinto html ; dohtml -r doc/* images/*
}
