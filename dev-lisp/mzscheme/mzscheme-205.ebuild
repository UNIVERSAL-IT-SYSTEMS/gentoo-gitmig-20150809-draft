# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/mzscheme/mzscheme-205.ebuild,v 1.4 2004/04/11 06:38:46 mkennedy Exp $

inherit flag-o-matic

# http://bugs.gentoo.org/show_bug.cgi?id=47037 -march=athlon-xp causes
# build failure

if is-flag '-march=athlon-xp'; then
	replace-flags '-march=athlon-xp' '-mcpu=athlon-xp'
fi

S=${WORKDIR}/plt
DESCRIPTION="MzScheme scheme compiler"
HOMEPAGE="http://www.plt-scheme.org/software/mzscheme/"
SRC_URI="http://www.cs.utah.edu/plt/download/${PV}/${PN}/${P}.src.unix.tar.gz"
DEPEND=">=sys-devel/gcc-2.95.3-r7"
#RDEPEND=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"
IUSE=""

src_compile() {
	cd ${S}/src
	econf || die "./configure failed"
	make || die
}

src_install () {
	cd ${S}/src
	echo -e "n\n" | einstall || die "installation failed"
	cd ${S}
	dodoc README
	dodoc notes/COPYING.LIB
	dodoc notes/mzscheme/*

	# 2002-09-06: karltk
	# Normally, one specifies the full path to the collects,
	# so this should work, but it's not been tested properly.
	mv ${D}/usr/install ${D}/usr/bin/mzscheme-install

	dodir /usr/share/mzscheme
	mv ${D}/usr/collects/ ${D}/usr/share/mzscheme/collects/

	rm -rf ${D}/usr/notes/

	#the resultant files are infected with ${D} and Makefiles do not recognize
	#standard conventions. Looks like the simples way out is to
	#strip ${D}'s here
	cd ${D}/usr
	grep -rle "${D}" . | xargs sed -i -e "s:${D}:/:g"
}
