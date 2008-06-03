# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtecla/libtecla-1.6.0-r1.ebuild,v 1.3 2008/06/03 13:10:03 markusle Exp $

DESCRIPTION="Tecla command-line editing library"
HOMEPAGE="http://www.astro.caltech.edu/~mcs/tecla/"
SRC_URI="http://www.astro.caltech.edu/~mcs/tecla/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc x86"

IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/libtecla

src_compile() {
	# remove build directory from RPATH (see bug #119477)
	sed -e "s|:\$\$LD_RUN_PATH:\`pwd\`||" -i Makefile.rules || \
		die "Failed to adjust Makefile.rules"
	econf || die
	make || die
}

src_install() {
	make install prefix="${D}"/usr MANDIR="${D}"/usr/share/man || die
	dodoc CHANGES INSTALL LICENSE.TERMS PORTING README RELEASE.NOTES
}
