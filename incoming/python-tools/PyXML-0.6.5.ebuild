# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ollie Rutherfurd <oliver@rutherfurd.net>
# :mode=shellscript:noTabs=true:

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="http://prdownloads.sourceforge.net/pyxml/"${A}
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python"

src_compile() {
    cd ${S}
    try python setup.py build
}

src_install() {
    cd ${S}
    try python setup.py install --prefix=${D}/usr
    dodoc MANIFEST
    dodoc README*
}
 