# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/googlecl/googlecl-0.9.11.ebuild,v 1.1 2010/10/28 21:17:22 wired Exp $

EAPI=3
PYTHON_DEPEND="2:2.5:2.6"

inherit distutils

DESCRIPTION="Command line tools for the Google Data APIs"
HOMEPAGE="http://code.google.com/p/googlecl/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/gdata
"

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	distutils_src_install

	dodoc changelog || die "dodoc failed"
	doman man/*.1 || die "doman failed"
}
