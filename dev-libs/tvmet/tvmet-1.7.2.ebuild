# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/tvmet/tvmet-1.7.2.ebuild,v 1.1 2008/03/23 12:09:45 dev-zero Exp $

inherit autotools eutils

DESCRIPTION="Tiny Vector Matrix library using Expression Templates"
HOMEPAGE="http://tvmet.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc test"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-docs_missing_destdir.patch"

	sed -i \
		-e 's|^GENERATE_LATEX.*|GENERATE_LATEX = NO|' \
		doc/Doxyfile.in || die "sed failed"

	AT_M4DIR="config" eautoreconf
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable doc docs) \
		$(use_enable test cppunit) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
