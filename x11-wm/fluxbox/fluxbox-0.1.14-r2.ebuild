# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-0.1.14-r2.ebuild,v 1.6 2003/10/28 13:01:25 tseng Exp $

IUSE="kde gnome nls xinerama truetype cjk"

inherit commonbox flag-o-matic eutils gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on Blackbox -- has tabs."
SRC_URI="http://download.sourceforge.net/${PN}/${P}.tar.bz2"
HOMEPAGE="http://fluxbox.sf.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa mips amd64"
PROVIDE="virtual/blackbox"

mydoc="ChangeLog COPYING NEWS"
if pkg-config xft
then
	CXXFLAGS="${CXXFLAGS} -I/usr/include/freetype2"
fi
filter-flags -fno-exceptions

src_unpack() {

	unpack ${A}
	cd ${S}
	# Patch to fix toggledecor for terms
	epatch ${FILESDIR}/${P}-toggledecor.patch
	# Remember patch
	#epatch ${FILESDIR}/${P}-remember.patch
	# Menukey patch
	epatch ${FILESDIR}/${P}-menukey.patch
	# Vano menu destroy patch
	epatch ${FILESDIR}/${PN}-vano-gentoo.patch
	# gcc 3.3 fixes
	epatch ${FILESDIR}/${P}-gcc33.patch

	if [ `use cjk` ]; then
		epatch ${FILESDIR}/${P}-ja.patch
	fi
}

src_compile() {

	# Allow configure to detect mipslinux systems
	use mips && gnuconfig_update

	commonbox_src_compile

	cd data
	make \
		pkgdatadir=/usr/share/commonbox init
}


src_install() {

	commonbox_src_install
	cd data
	insinto /usr/share/commonbox
	doins init keys
	rmdir ${D}/usr/share/commonbox/fluxbox
	rm -f ${D}/usr/bin/fluxbox-generate_menu
}
