# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.79.1-r4.ebuild,v 1.10 2003/09/05 02:07:39 msterret Exp $

IUSE="nls static build"

S=${WORKDIR}/${P}
DESCRIPTION="Standard tool to compile source trees"
SRC_URI="ftp://prep.ai.mit.edu/gnu/make/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/make/make.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_compile() {
	local myconf=""
	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--info=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	if [ -z "`use static`" ]
	then
		make ${MAKEOPTS} || die
	else
		make ${MAKEOPTS} LDFLAGS=-static || die
	fi
}

src_install() {
	if [ -z "`use build`" ]
	then
		make DESTDIR=${D} install || die

		chmod 0755 ${D}/usr/bin/make

		dodoc AUTHORS COPYING ChangeLog NEWS README*
	else
		dobin make
	fi
}
