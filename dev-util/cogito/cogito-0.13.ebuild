# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cogito/cogito-0.13.ebuild,v 1.5 2005/08/26 22:33:04 ferdy Exp $

inherit eutils

DESCRIPTION="The GIT scripted toolkit"
HOMEPAGE="http://kernel.org/pub/software/scm/cogito/"
SRC_URI="http://kernel.org/pub/software/scm/cogito/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="dev-libs/openssl
	sys-libs/zlib
	>=dev-util/git-0.99.3
	doc? ( >=app-text/asciidoc-7.0.1 app-text/xmlto )"

RDEPEND="net-misc/rsync
		app-text/rcs
		net-misc/curl"

src_compile() {
	emake || die "emake failed"

	if use doc; then
		cd ${S}/Documentation
		sed -i -e "/^MAN7_TXT/s/git.txt/#git.txt/g" Makefile
		make || die "make documentation failed"
	fi
}

src_install() {
	make install DESTDIR="${D}" prefix="/usr" || die "install failed"
	dodoc README* VERSION COPYING

	if use doc; then
		doman Documentation/*.1 Documentation/*.7
	fi
}
