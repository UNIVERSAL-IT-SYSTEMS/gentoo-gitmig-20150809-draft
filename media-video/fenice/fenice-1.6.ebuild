# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/fenice/fenice-1.6.ebuild,v 1.1 2005/01/06 17:13:19 lu_zero Exp $
DESCRIPTION="Experimental rtsp streaming server"

HOMEPAGE="http://streaming.polito.it/fenice.shtml"

SRC_URI="http://streaming.polito.it/files/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="sys-libs/glibc"

export WANT_AUTOMAKE="1.6"

src_unpack(){
	unpack ${A}
#	cd ${S}
#	./autogen.sh
}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
