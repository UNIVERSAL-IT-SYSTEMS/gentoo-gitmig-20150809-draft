# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavbreaker/wavbreaker-0.3.ebuild,v 1.5 2004/04/20 17:39:57 eradicator Exp $

IUSE=""

DESCRIPTION="wavbreaker/wavmerge GTK2 utility to break or merge WAV file"
HOMEPAGE="http://huli.org/wavbreaker/"
SRC_URI="http://huli.org/wavbreaker/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2.0
	virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc ChangeLog COPYING INSTALL README NEWS
}
