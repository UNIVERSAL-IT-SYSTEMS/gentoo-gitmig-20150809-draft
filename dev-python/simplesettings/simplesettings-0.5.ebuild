# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplesettings/simplesettings-0.5.ebuild,v 1.2 2009/07/27 07:15:16 mr_bones_ Exp $
# Ebuild generated by g-pypi 0.2.2 (rev. 214)

EAPI="2"
inherit distutils

DESCRIPTION="Simple settings initialization"
HOMEPAGE="http://code.google.com/p/simplesettings/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

RDEPEND="virtual/python"
DEPEND="${RDEPEND}
		dev-python/setuptools"
