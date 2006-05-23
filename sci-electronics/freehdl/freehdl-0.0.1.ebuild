# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/freehdl/freehdl-0.0.1.ebuild,v 1.1 2006/05/23 09:43:55 calchan Exp $

DESCRIPTION="A free VHDL simulator."
SRC_URI="http://cran.mit.edu/~enaroska/${P}.tar.gz"
HOMEPAGE="http://freehdl.seul.org/"
LICENSE="GPL-2"
DEPEND=">=sys-devel/gcc-3.4.3.20050110-r2"
RDEPEND=">=dev-util/guile-1.2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64"

src_install () {
	make DESTDIR=${D} install || die "installation failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README*
}

