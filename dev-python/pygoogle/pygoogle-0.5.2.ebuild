# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygoogle/pygoogle-0.5.2.ebuild,v 1.3 2003/04/04 18:41:31 liquidx Exp $

inherit distutils

S=${WORKDIR}/${PN}
DESCRIPTION="A Python wrapper for the Google web API"
SRC_URI="http://diveintomark.org/projects/${PN}/${P}.zip"
HOMEPAGE="http://diveintomark.org/projects/pygoogle/"

IUSE=""
SLOT="0"
LICENSE="PYTHON"
KEYWORDS="x86"

DEPEND="virtual/python"
