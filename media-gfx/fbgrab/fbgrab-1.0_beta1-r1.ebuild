# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbgrab/fbgrab-1.0_beta1-r1.ebuild,v 1.1 2003/01/21 06:28:49 tad Exp $


DESCRIPTION="Framebuffer screenshot utility"
HOMEPAGE="http://w1.827.telia.com/~u82705821/fbgrab/"

SRC_URI="http://w1.827.telia.com/~u82705821/fbgrab/${PN}-1.0b1.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"
DEPEND="media-libs/libpng"

S="${WORKDIR}/${PN}-1.0b1"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:splint:#splint:" Makefile
	sed -i "s:-Wall:-Wall ${CFLAGS}:" Makefile
}

src_compile() {

	emake || die
}

src_install() {
	exeinto /usr/bin
	dobin fbgrab

	mv ${S}/fbgrab.1.man ${S}/fbgrab.1
	doman fbgrab.1
}
