# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tkseti/tkseti-3.06.ebuild,v 1.3 2002/07/11 06:30:57 drobbins Exp $

# This ebuild was generated by Ebuilder v0.4.

S="${WORKDIR}/${P}"
DESCRIPTION="TkSeti is a GUI to control the SETI@Home client for UNIX."
SRC_URI="http://www.cuug.ab.ca/~macdonal/tkseti/${P}.tar.gz"
HOMEPAGE="http://www.cuug.ab.ca/~macdonal/tkseti/tkseti.html"
LICENSE="as-is"
DEPEND=""
RDEPEND=">=dev-lang/tcl-8.3.3"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	echo "Nothing to compile for ${P}."
}

src_install () {
	dobin tkseti
	doman tkseti.1
	dodoc CHANGES README DOC
	insinto /usr/share/tkseti/contrib
	doins contrib/*
}
