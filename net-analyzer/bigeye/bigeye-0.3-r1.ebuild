# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bigeye/bigeye-0.3-r1.ebuild,v 1.1 2005/09/08 18:49:53 vanquirius Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Bigeye is a network utility dump and simple honeypot utility"
HOMEPAGE="http://violating.us/projects/bigeye/"
SRC_URI="http://violating.us/projects/bigeye/download/${P}.tgz
	mirror://gentoo/${P}-gcc34.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${P}-gcc34.diff
}

src_compile() {
	cd src
	$(tc-getCC) ${CFLAGS} bigeye.c emulate.c -o bigeye || die
	einfo "Done compiling."
}

src_install() {
	dobin src/bigeye || die

	insinto /usr/share/bigeye
	doins sig.file
	cp -r messages ${D}/usr/share/bigeye/
	dodoc README
}

pkg_postinst() {
	einfo "The service emulation files mentioned in the README"
	einfo "are located in /usr/share/bigeye/messages"
}
