# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmoe/libmoe-1.5.5.ebuild,v 1.4 2004/04/28 06:15:37 vapier Exp $

inherit gcc

DESCRIPTION="multi octet character encoding handling library"
HOMEPAGE="http://pub.ks-and-ks.ne.jp/prog/libmoe/"
SRC_URI="http://pub.ks-and-ks.ne.jp/prog/pub/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 -alpha sparc ppc"
IUSE=""

DEPEND="virtual/glibc
	dev-lang/perl"

src_compile() {
	emake CF="${CFLAGS} -I." \
		LF="${LDFLAGS} -shared"\
		CC="$(gcc-getCC)" || die
}

src_install() {

	make DESTDIR=${D} \
		PREFIX=/usr \
		MAN=/usr/share/man \
		install-lib install-man || die

	exeinto /usr/bin
	doexe  mbconv

	dolib.so libmoe.so
	dosym /usr/lib/libmoe.so /usr/lib/libmoe.so.${PV%%.*}
	dosym /usr/lib/libmoe.so /usr/lib/libmoe.so.${PV%.*}
	dosym /usr/lib/libmoe.so /usr/lib/libmoe.so.${PV}

	dodoc ChangeLog libmoe.shtml
}
