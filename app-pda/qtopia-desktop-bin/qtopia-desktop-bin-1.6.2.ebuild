# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/qtopia-desktop-bin/qtopia-desktop-bin-1.6.2.ebuild,v 1.2 2004/01/12 20:06:55 nerdboy Exp $

IUSE="X"

inherit virtualx

BV=1.6.2-1
QD="/opt/Qtopia"
S="${WORKDIR}"

DESCRIPTION="Qtopia Deskyop sync application for Zaurus PDA's"
SRC_URI="ftp://ftp.trolltech.com/qtopia/desktop/RedHat9.0/qtopia-desktop-${BV}rh9.i386.rpm"
HOMEPAGE="http://www.trolltech.com/download/qtopia/"

DEPEND="app-arch/rpm2targz
virtual/glibc"
RDEPEND="virtual/x11"

LICENSE="QPL"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="nomirror nostrip"

src_unpack() {

	cd ${WORKDIR}
	TMPDIR=${T} rpm2targz ${DISTDIR}/qtopia-desktop-${BV}rh9.i386.rpm
	tar xvzf qtopia-desktop-${BV}rh9.i386.tar.gz || die
}

src_install() {

	dodir ${QD}
	insinto ${QD}/qtopiadesktop/bin ; doins opt/Qtopia/qtopiadesktop/bin/*
	insinto ${QD}/qtopiadesktop/doc/en ; doins opt/Qtopia/qtopiadesktop/doc/en/*
	insinto ${QD}/qtopiadesktop/doc/de ; doins opt/Qtopia/qtopiadesktop/doc/de/*
	insinto ${QD}/qtopiadesktop/doc ; doins opt/Qtopia/qtopiadesktop/doc/*
	insinto ${QD}/qtopiadesktop/etc ; doins opt/Qtopia/qtopiadesktop/etc/*
	insinto ${QD}/qtopiadesktop/plugins ; doins opt/Qtopia/qtopiadesktop/plugins/*
	insinto ${QD}/lib ; doins opt/Qtopia/lib/*
	exeinto ${QD}/bin ; doexe opt/Qtopia/bin/qtopiadesktop
	dodir /etc/env.d
	echo "PATH=${QD}/bin" > ${D}/etc/env.d/37qtopia-desktop-bin
}

pkg_postinst() {

	einfo "******************************************************************"
	einfo " Finished installing Qtopia Desktop into ${QD}"
	einfo
	einfo " To start Qtopia Desktop, run:"
	einfo
	einfo "   $ qtopiadesktop"
	einfo
	einfo "******************************************************************"
}
