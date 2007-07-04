# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/doxymacs/doxymacs-1.8.0.ebuild,v 1.2 2007/07/04 09:29:29 opfer Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="Doxygen editing minor mode"
HOMEPAGE="http://doxymacs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6.13"
RDEPEND="${DEPEND}"

SITEFILE="50doxymacs-gentoo.el"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_compile() {
	econf \
		--with-datadir="${SITELISP}/${PN}" \
		--with-lispdir="${SITELISP}/${PN}" \
		|| die "econf failed"

	emake || die "emake failed"
	elisp-make-autoload-file ${PN}-autoloads.el lisp/
}

src_install() {
	emake \
		prefix="${D}/usr" \
		datadir="${D}/${SITELISP}/${PN}" \
		lispdir="${D}/${SITELISP}/${PN}" \
		install \
		|| die "emake install failed"

	elisp-install ${PN} ${PN}-autoloads.el
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc ${DOCS} || die "dodoc failed"
}

pkg_postinst() {
	elisp-site-regen
	elog "doxymacs is loaded for all C modes"
	elog "if you need it in other situations, please add (require 'doxmacs)"
	elog "to your ~/.emacs file"
}
