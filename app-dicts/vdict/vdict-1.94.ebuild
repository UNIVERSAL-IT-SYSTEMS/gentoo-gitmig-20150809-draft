# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict/vdict-1.94.ebuild,v 1.5 2008/06/14 05:06:45 matsuu Exp $

inherit eutils qt3

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="Vdict - Vietnamese Dictionary"
SRC_URI="mirror://sourceforge/xvnkb/${P}.tar.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="$(qt_min_version 3)
	sys-libs/gdbm
	media-libs/freetype"

src_install() {
	dobin fd/fd vd/vd utils/wd2vd
}

pkg_postinst() {
	elog "You may want to install app-dicts/vdict-* packages"
	elog "to have corresponding dictionaries"
}
