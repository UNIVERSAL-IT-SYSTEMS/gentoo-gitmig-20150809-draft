# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.7.1.ebuild,v 1.7 2004/06/28 16:58:44 agriffis Exp $

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die
}
