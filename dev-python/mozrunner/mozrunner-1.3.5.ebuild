# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozrunner/mozrunner-1.3.5.ebuild,v 1.2 2009/07/27 07:14:56 mr_bones_ Exp $
# Ebuild generated by g-pypi 0.2.2 (rev. 214)

EAPI="2"
inherit distutils

DESCRIPTION="Reliable start/stop/configuration of Mozilla Applications (Firefox,
Thunderbird, etc.)"
HOMEPAGE="http://code.google.com/p/mozrunner/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MPL-1.1"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}
		>=dev-python/simplesettings-0.3
		dev-python/simplejson"
