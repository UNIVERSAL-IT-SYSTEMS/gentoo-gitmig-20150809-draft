# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/table/table-1.5.53.ebuild,v 1.5 2004/06/24 22:24:52 agriffis Exp $

inherit elisp

IUSE=""

DESCRIPTION="Table editor for Emacs"
HOMEPAGE="http://table.sourceforge.net/"
SRC_URI="mirror://sourceforge/table/${P}.el.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/emacs"

S="${WORKDIR}/"

SITEFILE=50table-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S} && mv ${P}.el ${PN}.el
}

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el || die
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
	einfo "Please see ${SITELISP}/${PN}/table.el for the complete documentation."
}

pkg_postrm() {
	elisp-site-regen
}
