# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lv/lv-4.49.5.ebuild,v 1.1 2003/05/11 17:46:46 nakano Exp $

MY_P=${PN}${PV//./}
DESCRIPTION="Powerful Multilingual File Viewer"
HOMEPAGE="http://www.ff.iij4u.or.jp/~nrt/lv/"
SRC_URI="http://www.ff.iij4u.or.jp/~nrt/freeware/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"

S=${WORKDIR}/${MY_P}/build

src_compile() {
	../src/configure --prefix=/usr || die
	emake LIBS=-lncurses || die
}

src_install() {
	dodir /usr/{bin,lib,man}
	dodir /usr/man/man1
	einstall
}
