# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/sampeg3/sampeg3-0.0.3.ebuild,v 1.5 2004/07/01 08:42:18 eradicator Exp $

DESCRIPTION="MPEG video encoder targeted for optimum picture quality"
HOMEPAGE="http://rachmaninoff.informatik.uni-mannheim.de/sampeg/"
SRC_URI="http://rachmaninoff.informatik.uni-mannheim.de/sampeg/data/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="1.0"

KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/libc
		sys-libs/zlib
		>=media-libs/libvideogfx-1.0
		media-libs/libpng
		media-libs/jpeg
		virtual/x11"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO
}
