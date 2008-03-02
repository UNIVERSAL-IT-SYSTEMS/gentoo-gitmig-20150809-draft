# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-coveramazon/gmpc-coveramazon-0.15.5.0.ebuild,v 1.3 2008/03/02 18:22:08 nixnut Exp $

inherit eutils

DESCRIPTION="This plugin fetches cover art and album information from Amazon"
HOMEPAGE="http://sarine.nl/amazon-provider"
SRC_URI="http://download.sarine.nl/gmpc-0.15.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use =x11-libs/gtk+-2* jpeg ; then
		echo
		eerror "x11-libs/gtk+-2 needs to be built with \"jpeg\" USE flag"
		die "x11-libs/gtk+-2 needs to be built with \"jpeg\" USE flag"
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die
}
