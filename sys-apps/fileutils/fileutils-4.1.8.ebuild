# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fileutils/fileutils-4.1.8.ebuild,v 1.5 2002/10/04 06:24:53 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU file utilities (chmod, cp, dd, dir, ls, etc)"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/fileutils/fileutils.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_compile() {
	local myconf
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--bindir=/bin \
		${myconf} || die
	emake || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		bindir=${D}/bin \
		install || die
	cd ${D}
	dodir /usr/bin
	rm -rf usr/lib
	cd usr/bin
	ln -s ../../bin/* .
	if [ -z "`use build`" ]
	then
		cd ${S}
		dodoc COPYING NEWS README*  THANKS TODO ChangeLog ChangeLog-1997 AUTHORS

		#conflicts with textutils.  seems that they install the same
		#.info file between the two of them
		rm -f ${D}/usr/share/info/coreutils.info
	else
		rm -rf ${D}/usr/share
	fi
}

