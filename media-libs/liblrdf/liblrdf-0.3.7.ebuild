# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblrdf/liblrdf-0.3.7.ebuild,v 1.3 2004/05/06 16:22:16 eradicator Exp $

DESCRIPTION="A library for the manipulation of RDF file in LADSPA plugins"
HOMEPAGE="http://plugin.org.uk"
SRC_URI="http://plugin.org.uk/releases/lrdf/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""
DEPEND="dev-util/pkgconfig
	>=media-libs/raptor-0.9.12
	>=media-libs/ladspa-sdk-1.12"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
