# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/syck/syck-0.55-r3.ebuild,v 1.3 2006/11/30 01:53:32 mcummings Exp $

inherit flag-o-matic distutils

IUSE="php python"
DESCRIPTION="Syck is an extension for reading and writing YAML swiftly in popular scripting languages."
HOMEPAGE="http://whytheluckystiff.net/syck/"
SRC_URI="http://rubyforge.org/frs/download.php/4492/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND="python? ( dev-lang/python )"
RDEPEND="${DEPEND}"
PDEPEND="php? ( || ( ~dev-php5/syck-php-bindings-${PV}
		    ~dev-php4/syck-php-bindings-${PV} )
		    !=dev-libs/syck-0.55-r1 )"

src_compile() {
	append-flags -fPIC
	econf
	emake

	if use python; then
		pushd ext/python
		distutils_src_compile
		popd
	fi
}

src_install() {
	einstall

	if use python; then
		pushd ext/python
		distutils_src_install
		popd
	fi
}
