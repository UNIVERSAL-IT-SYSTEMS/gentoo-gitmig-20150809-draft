# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bsddb3/bsddb3-4.1.3.ebuild,v 1.5 2003/11/01 14:25:24 weeve Exp $

inherit distutils

DESCRIPTION="Python bindings for BerkelyDB"
HOMEPAGE="http://pybsddb.sourceforge.net/"
SRC_URI="mirror://sourceforge/pybsddb/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/python
	=sys-libs/db-4*"

S="${WORKDIR}/${P}"

mydoc="README.txt TODO.txt"

src_compile() {
	distutils_src_compile "--berkeley-db=/usr"
}

src_install() {
	distutils_src_install "--berkeley-db=/usr"
	dohtml docs/*
}

