# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/mysql-python/mysql-python-0.9.2.ebuild,v 1.4 2003/04/05 07:20:53 lordvan Exp $

S=${WORKDIR}/MySQL-python-${PV}
DESCRIPTION="MySQL Module for python" 
SRC_URI="mirror://sourceforge/mysql-python/MySQL-python-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mysql-python/"
LICENSE="GPL-2"
SLOT="0"
DEPEND="virtual/python
	virtual/glibc
	>=dev-lang/python-1.5.2
	>=dev-db/mysql-3.22.19"
RDEPEND=""
KEYWORDS="ppc x86 sparc "
IUSE=""

inherit distutils

src_compile() {
    if has_version '>=dev-db/mysql-4.0.10' >& /dev/null
	then
	cp ${FILESDIR}/setup.py-0.9.2__mysql4 ${S}/setup.py
    fi
    distutils_src_compile
}

src_install() {
    distutils_src_install
    
    dohtml doc/*
}

