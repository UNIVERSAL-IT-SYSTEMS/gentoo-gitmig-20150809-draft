# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/otpcalc/otpcalc-0.97.ebuild,v 1.5 2005/07/20 14:38:15 gustavoz Exp $

inherit eutils

DESCRIPTION="A One Time Password and S/Key calculator for X"
HOMEPAGE="http://killa.net/infosec/otpCalc/"
SRC_URI="http://killa.net/infosec/otpCalc/otpCalc-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ppc sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	virtual/x11
	virtual/libc"

S=${WORKDIR}/${P/c/C}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/otpcalc-man-table-format.diff
	sed -i -e "s/VERSION/${PV}/g" ${S}/otpCalc.man
	sed -i "s#-s -O3#${CFLAGS}#g" ${S}/Makefile.in
}

src_install() {
	newman otpCalc.man otpCalc.1
	dobin otpCalc || die
}
