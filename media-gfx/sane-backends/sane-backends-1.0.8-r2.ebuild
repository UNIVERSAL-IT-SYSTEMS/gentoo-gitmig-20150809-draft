# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-backends/sane-backends-1.0.8-r2.ebuild,v 1.2 2002/07/05 17:12:27 seemant Exp $

DESCRIPTION="Scanner Access Now Easy - Backends"
HOMEPAGE="http://www.mostang.com/sane/"

ADDDEP=""

if [ `arch` != "ppc" ] ; then
	ADDDEP="sys-libs/libieee1284"
fi

DEPEND=">=media-libs/jpeg-6b
	${ADDDEP}"

SRC_URI="ftp://ftp.mostang.com/pub/sane/sane-$PV/$P.tar.gz"
S=${WORKDIR}/${P}
SLOT=""
LICENSE="GPL"

src_unpack() {
	unpack ${A}
	cp ${FILESDIR}/linux_sg3_err.h ${S}/sanei

	#only generate the .ps and not the fonts 
	cp ${S}/doc/Makefile.in ${S}/doc/Makefile.in.orig
	sed -e 's:dvips sane.dvi -o sane.ps:dvips sane.dvi -o -M0 sane.ps:' \
		${S}/doc/Makefile.in.orig > ${S}/doc/Makefile.in
}

src_compile() {
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--host=${CHOST} || die
	make || die
}

src_install () {
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		mandir=${D}/usr/share/man \
		docdir=${D}/usr/share/doc/${PF} \
		install || die

	docinto backend
	cd backend
	dodoc GUIDE *.README *.BUGS *.CHANGES *.FAQ *.TODO

	echo "SANE_CONFIG_DIR=/etc/sane.d" > 30sane
	insinto /etc/env.d
	doins 30sane

}
