# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/mysqltcl/mysqltcl-2.50.ebuild,v 1.7 2011/05/02 06:03:44 jlec Exp $

DESCRIPTION="TCL MySQL Interface"
HOMEPAGE="http://www.xdobry.de/mysqltcl/"
SRC_URI="http://www.xdobry.de/mysqltcl/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="
	dev-lang/tcl
	virtual/mysql"
RDEPEND="${DEPEND}"

src_compile() {
	econf
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README README-msqltcl ChangeLog
	dohtml doc/mysqltcl.html
}
