# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dateutil/python-dateutil-1.1.ebuild,v 1.6 2006/10/15 18:15:34 kloeri Exp $

inherit distutils

DESCRIPTION="dateutil datetime math and logic library for python"
HOMEPAGE="http://labix.org/python-dateutil"
SRC_URI="http://labix.org/download/python-dateutil/${P}.tar.bz2"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	!<=dev-python/matplotlib-0.82"

DOCS="NEWS example.py sandbox/rrulewrapper.py sandbox/scheduler.py"

src_test() {
	${python} test.py
}
