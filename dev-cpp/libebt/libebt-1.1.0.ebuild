# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libebt/libebt-1.1.0.ebuild,v 1.1 2005/12/08 03:02:08 ciaranm Exp $

DESCRIPTION="A pure C++ template library that provides a clean way of getting human-readable backtrace messages."
HOMEPAGE="http://libebt.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"
RESTRICT="primaryuri"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	use doc && { emake doxygen || die "failed to build API docs" ; }
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
	use doc && dohtml -r doc/html/*
}
