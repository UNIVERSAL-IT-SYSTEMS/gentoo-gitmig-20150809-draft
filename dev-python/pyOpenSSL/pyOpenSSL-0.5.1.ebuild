# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyOpenSSL/pyOpenSSL-0.5.1.ebuild,v 1.8 2003/07/12 12:49:26 aliz Exp $

IUSE="tetex"

S=${WORKDIR}/${P}
DESCRIPTION="Python interface to the OpenSSL library"
SRC_URI="mirror://sourceforge/pyopenssl/${P}.tar.gz"
HOMEPAGE="http://pyopenssl.sourceforge.net/"
LICENSE="LGPL-2.1"
SLOT="0"
RDEPEND="virtual/python
	>=dev-libs/openssl-0.9.6g"
DEPEND="$RDEPEND
        tetex? ( >=dev-tex/latex2html-2002.2 )"
KEYWORDS="x86"

inherit distutils

src_compile() {
    distutils_src_compile

    if [ "`use tetex`" ] ; then
	cd ${S}/doc
	make html ps dvi
    fi
}

src_install() {
    distutils_src_install
    
    if [ "`use tetex`" ] ; then	
	dohtml ${S}/doc/html/*
	dodoc ${S}/doc/pyOpenSSL.*
    fi
    
    # install examples
    dodir /usr/share/doc/${PF}/examples/simple
    insinto /usr/share/doc/${PF}/examples
    doins ${S}/examples/*
    insinto /usr/share/doc/${PF}/examples/simple
    doins ${S}/examples/simple/*
}

pkg_postinst() {
    echo
    einfo "For docs in html you need to have tetex in your USE var"
    echo
}
