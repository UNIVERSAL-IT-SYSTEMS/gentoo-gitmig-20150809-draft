# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/vendetta-online-bin/vendetta-online-bin-1.8.82.ebuild,v 1.3 2010/05/25 21:07:07 pacho Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Space-based MMORPG"
HOMEPAGE="http://www.vendetta-online.com/"
SRC_URI="amd64? (
		http://mirror.cle.vendetta-online.com/vendetta-linux-amd64-installer.sh
			-> ${P}-amd64.sh
	)
	x86? (
		http://mirror.cle.vendetta-online.com/vendetta-linux-ia32-installer.sh
			-> ${P}-x86.sh
	)"

LICENSE="guild"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	x11-libs/gtk+:2"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms +x "${dir}"/{vendetta,install/{media.rlb,update.rlb,vendetta}} \
		|| die "fperms failed"

	sed \
		-e "s:DATADIR:${dir}:" \
		"${FILESDIR}"/vendetta > "${T}"/vendetta \
		|| die "sed failed"

	dogamesbin "${T}"/vendetta || die "dogamesbin failed"
	newicon install/manual/images/ships.valkyrie.jpg ${PN}.jpg
	make_desktop_entry vendetta "Vendetta Online" /usr/share/pixmaps/${PN}.jpg

	prepgamesdirs
}
