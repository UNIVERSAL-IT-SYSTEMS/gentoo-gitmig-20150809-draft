# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aldumb/aldumb-0.9.2-r1.ebuild,v 1.4 2004/11/09 07:10:27 josejx Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/dumb"
DESCRIPTION="Allegro support for DUMB (an IT, XM, S3M, and MOD player library)"
HOMEPAGE="http://dumb.sourceforge.net/"
SRC_URI="mirror://sourceforge/dumb/dumb-${PV}-fixed.tar.gz"

#-amd64: 0.9.2-r1: dumbplay killed my X session - eradicator
KEYWORDS="x86 ppc ~alpha ~ia64 -amd64"
LICENSE="DUMB-0.9.2"
SLOT="0"

DEPEND=">=media-libs/dumb-0.9.2-r2
	media-libs/allegro"

src_unpack() {
	unpack ${A}
	cd ${S}
	cat << EOF > make/config.txt
include make/unix.inc
ALL_TARGETS := allegro allegro-examples allegro-headers
PREFIX := /usr
EOF

	epatch ${FILESDIR}/${P}-PIC.patch
}

src_compile() {
	emake OFLAGS="${CFLAGS}" all || die "emake failed"
}

src_install() {
	dodir /usr/lib /usr/include /usr/bin
	make PREFIX=${D}/usr install || die "make install failed"
}
