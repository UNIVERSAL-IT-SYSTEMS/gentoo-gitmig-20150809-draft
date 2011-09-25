# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mg/mg-20110905.ebuild,v 1.2 2011/09/25 17:30:02 armin76 Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Micro GNU/emacs, a port from the BSDs"
HOMEPAGE="http://homepage.boetes.org/software/mg/"
SRC_URI="http://homepage.boetes.org/software/mg/${P}.tar.gz"

LICENSE="public-domain BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_configure() {
	# econf won't work, as this script does not accept any parameters
	./configure || die "configure failed"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install()  {
	einstall
	dodoc README tutorial
}
