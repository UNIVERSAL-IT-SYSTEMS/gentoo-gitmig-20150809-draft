# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kopete-facebook/kopete-facebook-0.1.3.ebuild,v 1.1 2009/10/09 09:55:11 alexxy Exp $

EAPI="2"

inherit kde4-base

MY_PN="dmacvicar-${PN}-ffc26f60c2d08260098eeb7bc22119a0dc35ccd3"

DESCRIPTION="Facebook Chat support for Kopete"
HOMEPAGE="http://duncan.mac-vicar.com/blog/archives/tag/facebook"
SRC_URI="http://github.com/dmacvicar/kopete-facebook/tarball/release_0_1_3 -> ${MY_PN}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	dev-libs/qjson
	>=kde-base/kopete-${KDE_MINIMAL}
"
RDEPEND="${DEPEND}
	!net-im/kopete-facebook:0
"

PATCHES=(
	"${FILESDIR}/${PN}-as-needed.patch"
)

S="${WORKDIR}/${MY_PN}"
