# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.6.1-r2.ebuild,v 1.2 2006/03/26 17:43:24 genstef Exp $

inherit eutils

DESCRIPTION="gv is used to view PostScript and PDF documents using Ghostscript"
HOMEPAGE="http://www.gnu.org/software/gv/"
SRC_URI="ftp://ftp.gnu.org/gnu/gv/${P}.tar.gz
	mirror://debian/pool/main/g/gv/gv_3.6.1-13.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64 ~mips ~ppc-macos ~ppc64"
IUSE=""

RDEPEND="|| ( (
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXmu
			x11-libs/libXpm
			x11-libs/libXt
		) virtual/x11
	)
	x11-libs/Xaw3d
	virtual/ghostscript"

DEPEND="${RDEPEND}
	|| (
		x11-libs/libXt
		virtual/x11
	)"
PROVIDE="virtual/pdfviewer
	virtual/psviewer"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-landscape.patch
	epatch ${FILESDIR}/${P}-setenv.patch
	epatch ${FILESDIR}/${P}-a0.patch
	epatch ${WORKDIR}/gv_3.6.1-13.diff
	epatch ${P}/debian/patches/*.dpatch
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}
