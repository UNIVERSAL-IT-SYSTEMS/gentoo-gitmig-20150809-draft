# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/iiimecf/iiimecf-11.4.1467.ebuild,v 1.3 2004/06/24 22:15:17 agriffis Exp $

inherit elisp iiimf

DESCRIPTION="IIIMECF is a Emacs client framework for IIIMF"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/libiiimp
	dev-libs/libiiimcf"

src_compile() {
	emacs -q --no-site-file -batch -l iiimcf-comp.el
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install ${FILESDIR}/50iiimecf-gentoo.el
	dodoc ChangeLog README*
	newdoc lisp/ChangeLog ChangeLog.lisp
}
