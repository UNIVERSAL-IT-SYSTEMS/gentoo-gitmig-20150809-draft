# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uriparser/uriparser-0.3.3-r1.ebuild,v 1.1 2007/04/13 01:22:05 beandog Exp $

inherit flag-o-matic

DESCRIPTION="Uriparser is a strictly RFC 3986 compliant URI parsing library in C"
HOMEPAGE="http://uriparser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_compile() {
	append-flags "-fPIC"

	econf || die "configure failed"
	emake || die "emake failed"

	if use doc; then
		ebegin "Creating documentation"
		cd "${S}/doc"
		doxygen Doxyfile
		eend 0
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog

	if use doc; then
		dohtml doc/html/*
	fi
}
