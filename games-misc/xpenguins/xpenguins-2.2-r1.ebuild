# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xpenguins/xpenguins-2.2-r1.ebuild,v 1.2 2004/06/24 22:59:01 agriffis Exp $

inherit games

THEMES_VERSION="1.0"
DESCRIPTION="Cute little penguins invading your desktop"
HOMEPAGE="http://xpenguins.seul.org/"
SRC_URI="http://xpenguins.seul.org/${P}.tar.gz
	http://xpenguins.seul.org/xpenguins_themes-${THEMES_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	egamesconf --with-x || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	cp -r ../themes/ "${D}${GAMES_DATADIR}/${PN}/" || die "cp failed"
	prepgamesdirs
}
