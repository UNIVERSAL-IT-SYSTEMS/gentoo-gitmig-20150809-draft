# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/lard/lard-2.0.15.ebuild,v 1.5 2004/06/24 22:08:00 agriffis Exp $

inherit eutils

IUSE=""

DESCRIPTION="Language for Asynchronous Research and Development. Used to describe and simulate asynchronous circuits"
HOMEPAGE="http://www.cs.man.ac.uk/apt/projects/lard/index.html"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/lard/${P}.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/lard/lard-demos-2.0.12.tar.gz
	ftp://ftp.cs.man.ac.uk/pub/amulet/lard/lard-doc-2.0.14.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="sys-devel/flex
	dev-lang/tcl
	dev-lang/tk
	sys-devel/bison
	sys-devel/binutils
	dev-tcltk/tclx
	dev-libs/gmp
	dev-lang/perl
	dev-tcltk/bwidget"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-configure.patch
}

src_compile() {
	econf --libdir=/usr/lib/lard || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS COPYING NEWS README

	dodir /usr/share/doc/${PF}/demos
	cp -R ${WORKDIR}/lard-demos-2.0.12/* ${D}/usr/share/doc/${PF}/demos
	cd ${WORKDIR}/lard-doc
	find . -name "*.doc *.cgi" -exec rm {} \;
	dodir /usr/share/doc/${PF}/html
	cp -R * ${D}/usr/share/doc/${PF}/html
	cd ${WORKDIR}
	dosed "s:\$exec_prefix:#\$exec_prefix:g" /usr/bin/lcd
}
