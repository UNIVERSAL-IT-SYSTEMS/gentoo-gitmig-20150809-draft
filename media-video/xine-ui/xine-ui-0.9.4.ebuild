# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xine-ui/xine-ui-0.9.4.ebuild,v 1.2 2001/11/14 05:08:12 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Xine is a free gpl-licensed video player for unix-like systems"
SRC_URI="http://skyblade.homeip.net/xine/XINE-${PV}/source.TAR.BZ2s/xine-ui-${PV}.tar.bz2"
HOMEPAGE="http://xine.sourceforge.net/"

DEPEND="virtual/glibc
	>=media-video/xine-lib-0.9.4
	X? ( virtual/x11 )
	aalib? ( media-libs/aalib )"


src_unpack() {

	unpack ${A}

	cd ${S}
	patch -p1 <${FILESDIR}/xine-ui-gentoo.diff || die
}

src_compile() {

	# Most of these are not working currently, but are here for completeness
	local myconf
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use aalib  || myconf="${myconf} --disable-aalib --disable-aalibtest"
  
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
		    --sysconfdir=/etc					\
		    ${myconf} || die
	make || die
}

src_install() {
	
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	cd ${S}/doc
	dodoc bug_report_form FAQ* README*
}

