# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/rcs/rcs-5.7.ebuild,v 1.3 2000/10/05 00:12:58 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Revision Controll System"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/rcs/${A}
	 ftp://ftp.gnu.org/gnu/rcs/${A}"
HOMEPAGE="http://www.gnu.org/software/rcs/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --with-diffutils
    cp ${FILESDIR}/conf.sh src/conf.sh
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    prepman
    dodoc ChangeLog COPYING CREDITS NEWS README REFS
}

