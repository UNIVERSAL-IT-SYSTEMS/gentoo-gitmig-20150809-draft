# Copyright 2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net>

A=xzip182.tar.Z
S=${WORKDIR}/xzip
DESCRIPTION="X interface to Z-code based text games"
SRC_URI="http://www.eblong.com/zarf/ftp/${A}"
HOMEPAGE="http://www.eblong.com/zarf/xzip.html"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/xzip-182-makefile.diff
}

src_compile() {
    try make
}

src_install () {
#    try make DESTDIR=${D}/usr/X11R6 install
    doman xzip.1
    into /usr/X11R6
    dobin xzip
}

 