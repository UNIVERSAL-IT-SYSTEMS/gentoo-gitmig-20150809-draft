# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmacs/texmacs-1.0.3.ebuild,v 1.5 2004/06/24 22:45:55 agriffis Exp $

inherit flag-o-matic

MY_P=${P/tex/TeX}-src
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNU TeXmacs is a free GUI scientific editor, inspired by TeX and GNU Emacs."
SRC_URI="ftp://ftp.texmacs.org/pub/TeXmacs/targz/${MY_P}.tar.gz
	 ftp://ftp.texmacs.org/pub/TeXmacs/targz/TeXmacs-600dpi-fonts.tar.gz"
HOMEPAGE="http://www.texmacs.org/"
LICENSE="GPL-2"

SLOT="0"
IUSE="spell"
# TeXmacs 1.0.X -> stable release, TeXmacs 1.0.X.Y -> development release
# 1.0.3 and 1.0.3-r* is from stable branch at the moment
KEYWORDS="x86 ppc"

RDEPEND="virtual/tetex
	>=dev-util/guile-1.4
	>=sys-apps/sed-4
	virtual/x11
	spell? ( >=app-text/ispell-3.2 )"

DEPEND="${RDEPEND}
	virtual/ghostscript"

src_compile() {

	# we're not trusting texmacs optimisations here, so
	# we only want the following two
	strip-flags
	append-flags -fno-default-inline
	append-flags -fno-inline

	econf || die
	# and now replace the detected optimisations with our safer ones
	sed -i "s:\(^CXXOPTIMIZE = \).*:\1${CXXFLAGS}:" src/common.makefile
	# emake b0rked
	emake -j1 || die

}


src_install() {

	make DESTDIR=${D} install || die
	dodoc COMPILE COPYING LICENSE

	insinto /usr/share/applications
	doins ${FILESDIR}/TeXmacs.desktop

	# now install the fonts
	cd ${WORKDIR}
	dodir /usr/share/texmf
	cp -r fonts ${D}/usr/share/texmf/

}
