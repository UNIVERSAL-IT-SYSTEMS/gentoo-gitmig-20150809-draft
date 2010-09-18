# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/odsclient/odsclient-1.03-r1.ebuild,v 1.1 2010/09/18 01:55:18 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Client for the Open Domain Server's dynamic dns"
HOMEPAGE="http://www.ods.org/"
SRC_URI="http://www.ods.org/dl/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_prepare() {
	sed -i Makefile -e 's| -o | $(LDFLAGS)&|g' || die "sed failed"

	epatch "${FILESDIR}"/${PV}-gentoo.patch
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die
}

src_install() {
	dosbin odsclient
	dodoc README
}
