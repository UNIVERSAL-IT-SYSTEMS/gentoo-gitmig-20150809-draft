# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/trm/trm-0.2.1.ebuild,v 1.1 2004/05/27 22:48:20 caleb Exp $

LICENSE="GPL-2"

DESCRIPTION="Generates Relatable TRM acoustic fingerprints"
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/${P}.tar.gz"
HOMEPAGE="http://www.musicbrainz.org/products/trmgen/download.html"

KEYWORDS="~x86"
SLOT="0"

DEPEND=">=media-libs/musicbrainz-2.0.1
	media-libs/libmad
	media-libs/libvorbis
	media-libs/libogg"

src_install() {
	dodoc README
	dobin trm
}
