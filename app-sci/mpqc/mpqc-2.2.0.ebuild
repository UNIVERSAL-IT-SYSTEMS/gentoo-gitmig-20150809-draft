# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/mpqc/mpqc-2.2.0.ebuild,v 1.5 2004/06/24 22:10:56 agriffis Exp $

DESCRIPTION="The Massively Parallel Quantum Chemistry Program"
HOMEPAGE="http://aros.ca.sandia.gov/~cljanss/mpqc/"
SRC_URI="http://aros.ca.sandia.gov/~cljanss/mpqc/distrib/${P}.tar.gz
	doc? ( http://aros.ca.sandia.gov/~cljanss/mpqc/distrib/${PN}-man-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc X"

DEPEND="sys-devel/flex
	app-sci/blas
	app-sci/lapack
	dev-lang/perl
	X? ( virtual/x11 )"

src_compile() {
	CFLAGS_SAVE=${CFLAGS}; CXXFLAGS_SAVE=${CXXFLAGS}
	myconf="${myconf} --prefix=/usr"
	use X && myconf="${myconf} --x-includes=/usr/X11R6/include \
	  --x-libraries=/usr/X11R6/lib"
	./configure ${myconf}
	sed -e "s:^CFLAGS =.*$:CFLAGS=${CFLAGS_SAVE}:" \
	  -e "s:^FFLAGS =.*$:FFLAGS=${CFLAGS_SAVE}:" \
	  -e "s:^CXXFLAGS =.*$:CXXFLAGS=${CXXFLAGS_SAVE}:" \
	  lib/LocalMakefile > lib/LocalMakefile.foo
	mv lib/LocalMakefile.foo lib/LocalMakefile
	emake
}

src_install() {
	sed -e "s:^prefix=.*$:prefix=${D}/usr:" lib/LocalMakefile \
	  > lib/LocalMakefile.foo
	mv lib/LocalMakefile.foo lib/LocalMakefile
	use doc && doman ${WORKDIR}/${PN}-man-${PV}/man3/*
	make install install_devel install_inc
}
