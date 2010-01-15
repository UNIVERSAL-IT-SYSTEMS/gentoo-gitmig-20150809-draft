# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tailor/tailor-0.9.35.ebuild,v 1.2 2010/01/15 21:57:01 fauli Exp $

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="A tool to migrate changesets between version control systems."
HOMEPAGE="http://wiki.darcs.net/index.html/Tailor"
SRC_URI="http://darcs.arstecnica.it/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="vcpx"

pkg_postinst() {
	distutils_pkg_postinst
	elog "Tailor does not explicitly depend on any other VCS."
	elog "You should emerge whatever VCS(s) that you want to use seperately."
}
