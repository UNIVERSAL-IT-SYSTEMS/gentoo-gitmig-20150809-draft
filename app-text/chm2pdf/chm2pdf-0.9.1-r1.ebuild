# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/chm2pdf/chm2pdf-0.9.1-r1.ebuild,v 1.1 2011/01/12 20:19:19 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"
inherit python eutils

DESCRIPTION="A script that converts a CHM file into a single PDF file."
HOMEPAGE="http://code.google.com/p/chm2pdf/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-python/pychm
	app-text/htmldoc
	dev-libs/chmlib[examples]"

pkg_setup() {
	python_set_active_version 2
}

src_prepare(){
	epatch "${FILESDIR}/tempdir.patch"
}

src_install() {
	dobin ${PN} || die "failed to create executable"
	dodoc README || die "dodoc failed"
}
