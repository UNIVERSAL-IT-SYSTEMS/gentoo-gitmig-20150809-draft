# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/texi2html/texi2html-1.76.ebuild,v 1.9 2005/05/18 09:01:46 corsair Exp $

DESCRIPTION="Perl script that converts Texinfo to HTML"
HOMEPAGE="https://texi2html.cvshome.org/"
SRC_URI="https://texi2html.cvshome.org/files/documents/70/758/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~ppc-macos sparc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1"

src_install() {
	#yes, htmldir line is correct, no ${D}
	make DESTDIR="${D}" \
		htmldir=/usr/share/doc/${PF}/html \
		install || die "Installation Failed"

	dodoc AUTHORS ChangeLog INSTALL INTRODUCTION NEWS README TODO
}

pkg_preinst() {
	rm -f "${ROOT}"/usr/bin/texi2html
}
