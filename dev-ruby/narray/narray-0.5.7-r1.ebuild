# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/narray/narray-0.5.7-r1.ebuild,v 1.5 2004/06/25 01:54:28 agriffis Exp $

DESCRIPTION="Numerical N-dimensional Array class"
HOMEPAGE="http://www.ir.isas.ac.jp/~masa/ruby/index-e.html"
SRC_URI="http://www.ir.isas.ac.jp/~masa/ruby/dist/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha hppa mips ppc sparc x86"
IUSE=""
DEPEND="virtual/ruby"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make exec_prefix=/usr DESTDIR=${D} install || die
	dodoc ChangeLog README.* SPEC.*
}
