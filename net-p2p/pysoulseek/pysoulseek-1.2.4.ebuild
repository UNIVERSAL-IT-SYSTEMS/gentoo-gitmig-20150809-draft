# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/pysoulseek/pysoulseek-1.2.4.ebuild,v 1.1 2003/08/29 18:24:02 liquidx Exp $

IUSE="oggvorbis hyriand"
inherit eutils distutils
MY_PN="${PN/soulseek/slsk}"
MY_PV="${PV/_/}"

MY_P=${MY_PN}-${MY_PV}

DESCRIPTION="client for SoulSeek filesharing"
HOMEPAGE="http://www.sensi.org/~ak/pyslsk/ 
	http://thegraveyard.org/pyslsk/index.html"
SRC_URI="http://www.sensi.org/~ak/pyslsk/${MY_P}.tar.gz "

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=dev-lang/python-2.1
	>=dev-python/wxPython-2.4.1.2
	>=x11-libs/wxGTK-2.4.1
	oggvorbis? ( dev-python/pyvorbis dev-python/pyogg )"

RDEPEND=${DEPEND}

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install
	insinto /usr/share/applications
	doins ${FILESDIR}/pysoulseek.desktop
}

pkg_postinst() {
	echo
	einfo "Use of the hyriand patch is now dependent on a local USE flag"
	einfo "If you want the hyriand features, add 'hyriand' to your USE flags"
	echo
}
