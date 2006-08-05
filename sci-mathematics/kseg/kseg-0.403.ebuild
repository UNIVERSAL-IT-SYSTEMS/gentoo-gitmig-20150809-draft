# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/kseg/kseg-0.403.ebuild,v 1.2 2006/08/05 12:54:21 dertobi123 Exp $

inherit eutils qt3

DESCRIPTION="Interactive geometry program for exploring Euclidean geometry"
HOMEPAGE="http://www.mit.edu/~ibaran/kseg.html"
SRC_URI="http://www.mit.edu/~ibaran/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"
DEPEND="$(qt_min_version 3.3)"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	# Fix silly hardcoded help file path and CCFLAGS.
	#epatch ${FILESDIR}/${P}-gentoo.patch
	sed -i -e "s|KSEG_HELP_DIR|${PF}/help|" main.cpp
}

src_compile() {
	${QTDIR}/bin/qmake QMAKE=${QTDIR}/bin/qmake || die 'qmake failed.'
	emake || die 'emake failed.'
}

src_install() {
	exeinto /usr/bin
	doexe kseg
	dodoc AUTHORS README README.translators VERSION
	insinto /usr/share/doc/${PF}/help
	doins *.html *.qm
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
