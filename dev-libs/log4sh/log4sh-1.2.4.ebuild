# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/log4sh/log4sh-1.2.4.ebuild,v 1.1 2004/12/31 15:13:04 ka0ttic Exp $

DESCRIPTION="A flexible logging framework for shell scripts"
HOMEPAGE="http://forestent.com/products/log4sh/"
SRC_URI="http://forestent.com/dist/${PN}/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""

src_test() {
	make test || die "make test failed"
}

src_install() {
	insinto /usr/lib/log4sh
	doins build/log4sh || die "Failed to install log4sh"

	dodoc doc/CHANGES doc/TODO
	dohtml doc/*.{html,css}
	docinto examples
	dodoc src/examples/*
}
