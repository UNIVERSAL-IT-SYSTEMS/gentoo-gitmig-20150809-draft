# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4cpp/log4cpp-1.0.ebuild,v 1.6 2010/06/29 18:42:06 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Library of C++ classes for flexible logging to files, syslog and other destinations."
HOMEPAGE="http://log4cpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc s390 x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PV}-doc_install_path.patch \
		"${FILESDIR}"/${PV}-gcc43.patch

	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf \
		--without-idsa \
		$(use_enable doc doxygen)
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
